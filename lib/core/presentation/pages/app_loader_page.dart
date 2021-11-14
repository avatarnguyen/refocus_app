import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/pages/login_page.dart';
import 'package:refocus_app/injection.dart';

class AppLoaderWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  const AppLoaderWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>()..add(const AuthEvent.login()),
      child: this,
    );
  }
}

class AppLoaderPage extends StatelessWidget {
  const AppLoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final log = logger(AppLoaderPage);
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log.d('$state Amplify isConfigured: ${Amplify.isConfigured}');
        return state.maybeWhen(
          unknown: () {
            return const LoginPage();
          },
          authenticated: (userEntry) {
            log.i('Authenticated: $userEntry');
            return const HomePage();
          },
          unauthenticated: () {
            return const LoginPage();
          },
          loading: () => const Scaffold(
            body: Center(
              child: progressIndicator,
            ),
          ),
          orElse: () {
            return const Scaffold(
              body: Center(
                child: Text('Something went wrong with the Authentication'),
              ),
            );
          },
        );
      },
    );
  }
}
