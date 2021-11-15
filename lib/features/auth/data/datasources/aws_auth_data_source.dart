import 'dart:async';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/enum/authetication_status.dart';
import 'package:refocus_app/models/ModelProvider.dart' as aws_model;

abstract class AuthDataSource {
  Future<aws_model.User?> signUp({
    required String username,
    required String email,
    required String password,
  });
  Future<aws_model.User?> login({
    required String username,
    required String password,
  });
  Future<aws_model.User?> attemptAutoLogin();
  Future<void> signOut();

  Future<bool> confirmSignUp({
    required String username,
    required String confirmationCode,
  });

  Stream<AuthenticationStatus> getAuthStatus();
}

@LazySingleton(as: AuthDataSource)
class AWSAuthDataSource implements AuthDataSource {
  final log = logger(AWSAuthDataSource);

  Future<String> _getUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      for (var element in attributes) {
        log.i('key: ${element.userAttributeKey}; value: ${element.value}');
      }
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value as String;
      // final _user = attributes.first;
      return userId;
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  Future<aws_model.User?> _getUserModelFromDataStore(String userId) async {
    try {
      final fetchedUser = await Amplify.DataStore.query(
          aws_model.User.classType,
          where: aws_model.User.ID.eq(userId));
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

  Future<aws_model.User?> _createUserModelInDataStore(
      aws_model.User user) async {
    try {
      await Amplify.DataStore.save(user);

      return _getUserModelFromDataStore(user.id);
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<aws_model.User?> attemptAutoLogin() async {
    try {
      final session = await Amplify.Auth.fetchAuthSession();

      if (session.isSignedIn) {
        final userId = await _getUserIdFromAttributes();
        return _getUserModelFromDataStore(userId);
      } else {
        log.d('No User Session is available');
        return null;
      }
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Future<aws_model.User?> login(
      {required String username, required String password}) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username.trim(),
        password: password.trim(),
      );

      if (result.isSignedIn) {
        final userId = await _getUserIdFromAttributes();
        return _getUserModelFromDataStore(userId);
      } else {
        return null;
      }
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
  Future<aws_model.User?> signUp(
      {required String username,
      required String email,
      required String password}) async {
    final options = CognitoSignUpOptions(
      userAttributes: {'email': email.trim()},
    );
    try {
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: options,
      );
      if (result.isSignUpComplete) {
        final _userId = await _getUserIdFromAttributes();

        final _newUser = aws_model.User(
          id: _userId,
          username: username,
          email: email,
        );
        final result = _createUserModelInDataStore(_newUser);

        return result;
      } else {
        log.d('Sign Up not completed');
        return null;
      }
    } catch (e) {
      log.e(e);
      throw ServerException();
    }
  }

  @override
  Stream<AuthenticationStatus> getAuthStatus() {
    final _controller = StreamController<AuthenticationStatus>();

    log.d('Amplify Configured: ${Amplify.isConfigured}');
    // if (Amplify.isConfigured) {
    Amplify.Hub.listen([HubChannel.Auth], (dynamic event) {
      if (event is AuthHubEvent) {
        log.d('Auth Event: ${event.eventName}');
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
}

class AuthHubEvent extends HubEvent {
  AuthHubEvent(String eventName, {HubEventPayload? payload})
      : super(eventName, payload: payload);
}
