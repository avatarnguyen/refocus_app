import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:refocus_app/amplifyconfiguration.dart';
import 'package:refocus_app/features/auth/data/datasources/aws_auth_data_source.dart';
import 'package:refocus_app/models/ModelProvider.dart' as aws_model;

import '../../../../helpers/aws_setup_utils.dart';

// class MockSignInResult extends Mock implements SignInResult {}

//! Error:
// AmplifyException(message: Amplify plugin AmplifyAPI was not added successfully., recoverySuggestion: We currently don't have a recovery suggestion for this exception., underlyingException: Null check operator used on a null value)
// Looking at example from aws-amplify repo, they dont have unit test but only integration test
// maybe unit test is not possible??

// void main() {
//   late AWSAuthDataSource authDataSource;
//   // late MockSignInResult signInResult;

//   // AmplifyAuthCognito authCognito = AmplifyAuthCognito();

//   setUp(() async {
//     // await configureAuth();
//     // await signOutUser();
//     authDataSource = AWSAuthDataSource();
//     // signInResult = MockSignInResult();
//   });

//   group('Sign Up Flow', () {
//     const tUserName = 'Avatar';
//     const tEmail = 'avatar@gmail.com';
//     const tPassword = 'avatar1234';

//     setUpAll(() async {
//       // await configureAuth();
//     });

//     test(
//       'should perform signup with email and password and return null',
//       () async {
//         // arrange
//         // when(() => signInResult.isSignedIn).thenReturn(true);
//         // act
//         final result = authDataSource.signUp(
//             username: tUserName, email: tEmail, password: tPassword);
//         // // assert
//         expect(result, null);
//       },
//     );
//   });
// }
