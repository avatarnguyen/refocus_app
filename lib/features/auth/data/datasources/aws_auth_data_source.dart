import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/enum/authetication_status.dart';
import 'package:refocus_app/features/task/data/datasources/aws_data_source.dart';
import 'package:refocus_app/models/ModelProvider.dart' as aws_model;

abstract class AuthDataSource {
  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<bool> login({
    required String username,
    required String password,
  });
  Future<bool> attemptAutoLogin();
  Future<void> signOut();

  Future<bool> confirmSignUp({
    required String username,
    required String confirmationCode,
  });
  Future<aws_model.User?> getUserModelFromDataStore();

  Stream<AuthenticationStatus> getAuthStatus();

  Future<void> close();
}

@LazySingleton(as: AuthDataSource)
class AWSAuthDataSource implements AuthDataSource {
  late StreamController<AuthenticationStatus> _controller;
  late StreamSubscription<dynamic> _hubSubscription;
  final log = logger(AWSAuthDataSource);

  Future<aws_model.User> _getUserFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      for (final element in attributes) {
        log.v('key: ${element.userAttributeKey}; value: ${element.value}');
      }
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value as String;
      final userEmail = attributes
          .firstWhere((element) => element.userAttributeKey == 'email')
          .value as String;
      return aws_model.User(
        id: userId,
        email: userEmail,
      );
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<aws_model.User?> getUserModelFromDataStore() async {
    try {
      final _user = await _getUserFromAttributes();
      final fetchedUser = await Amplify.DataStore.query(
        aws_model.User.classType,
        where: aws_model.User.ID.eq(_user.id),
      );
      if (fetchedUser.isNotEmpty) {
        return fetchedUser.first;
      } else {
        log.d('No User with the given ID exist in the database');
        return null;
      }
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  Future<void> _createUserModelInDataStore(aws_model.User user) async {
    try {
      final _fetchUser = await Amplify.DataStore.query(aws_model.User.classType,
          where: aws_model.User.ID.eq(user.id));
      if (_fetchUser.isEmpty) {
        await Amplify.DataStore.save(user);
        await _createExampleProjectAtFirstSignIn(user.id);
      }
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  Future<void> _createExampleProjectAtFirstSignIn(String userID) async {
    final _remoteDataSource = AWSTaskRemoteDataSource();
    final _newProject = aws_model.Project(
      title: 'Inbox',
      userID: userID,
      color: '#8879FC',
      id: 'inbox_$userID',
    );
    await _remoteDataSource.createOrUpdateRemoteProject(_newProject);
  }

  @override
  Future<bool> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();
      log.v('Auth Session: ${session.isSignedIn}');
      return session.isSignedIn;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<bool> login(
      {required String username, required String password}) async {
    try {
      // await Amplify.Auth.signOut();
      final result = await Amplify.Auth.signIn(
        username: username.trim(),
        password: password.trim(),
      );
      final _user = await _getUserFromAttributes();

      final _newUser = _user.copyWith(username: username);
      await _createUserModelInDataStore(_newUser);

      return result.isSignedIn;
    } on UserNotConfirmedException {
      throw NotConfirmedException();
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }

  @override
  Future<void> signUp(
      {required String username,
      required String email,
      required String password}) async {
    final options = CognitoSignUpOptions(
      userAttributes: {'email': email.trim()},
    );
    try {
      final result = await Amplify.Auth.signUp(
        username: username.trim(),
        password: password.trim(),
        options: options,
      );
      if (!result.isSignUpComplete) {
        log.d('Sign Up not completed');
        log.d(result.nextStep.signUpStep);
        if (result.nextStep.signUpStep == 'CONFIRM_SIGN_UP_STEP') {
          _controller.add(AuthenticationStatus.confirmationRequired);
        }
      }
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Stream<AuthenticationStatus> getAuthStatus() {
    _controller = StreamController<AuthenticationStatus>();

    log.v('Amplify Configured: ${Amplify.isConfigured}');

    _hubSubscription = Amplify.Hub.listen([HubChannel.Auth], (event) {
      log.v('Event Received: $event');
      if (event != null) {
        // ignore: avoid_dynamic_calls
        log.d('--> Auth Event: ${event.eventName}');
        switch (event.eventName) {
          case 'SIGNED_IN':
            {
              log.i('USER IS SIGNED IN');
              _controller.add(AuthenticationStatus.authenticated);
            }
            break;
          case 'SIGNED_OUT':
            {
              log.i('USER IS SIGNED OUT');
              _controller.add(AuthenticationStatus.unauthenticated);
            }
            break;
          case 'SESSION_EXPIRED':
            {
              log.i('USER SESSION EXPIRED');
              _controller.add(AuthenticationStatus.unauthenticated);
            }
            break;
          default:
            _controller.add(AuthenticationStatus.unknown);
            break;
        }
      }
    });

    return _controller.stream;
  }

  @override
  Future<bool> confirmSignUp({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username.trim(),
        confirmationCode: confirmationCode.trim(),
      );
      return result.isSignUpComplete;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<void> close() async {
    await _hubSubscription.cancel();
    await _controller.close();
  }
}

class AuthHubEvent extends HubEvent {
  AuthHubEvent(String eventName, {HubEventPayload? payload})
      : super(eventName, payload: payload);
}
