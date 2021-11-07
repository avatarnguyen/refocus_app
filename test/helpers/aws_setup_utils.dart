import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:refocus_app/amplifyconfiguration.dart';

Future<void> configureAuth() async {
  if (!Amplify.isConfigured) {
    final api = AmplifyAPI();
    // final authPlugin = AmplifyAuthCognito();
    await Amplify.addPlugins([api]);
    await Amplify.configure(amplifyconfig);
  }
}

// ensure no user is currently signed in
Future<void> signOutUser() async {
  try {
    await Amplify.Auth.signOut();
    // ignore: unused_catch_clause
  } on AuthException catch (e) {
    // Ignore a signOut error because we only care when someone signed in.
  }
}
