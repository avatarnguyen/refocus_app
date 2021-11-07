import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
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
  Future<aws_model.User> attemptAutoLogin();
  Future<void> signOut();
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

  @override
  Future<aws_model.User> attemptAutoLogin() {
    // TODO: implement attemptAutoLogin
    throw UnimplementedError();
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
        await _getUserIdFromAttributes();
        return aws_model.User();
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
        await _getUserIdFromAttributes();

        return aws_model.User();
      } else {
        return null;
      }
    } on AuthException catch (e) {
      log.e(e);
      throw ServerException();
    }
  }
}
