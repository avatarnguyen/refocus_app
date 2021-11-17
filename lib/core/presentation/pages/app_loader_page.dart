import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/pages/login_page.dart';
import 'package:refocus_app/features/auth/presentation/signup/bloc/signup_bloc.dart';
import 'package:refocus_app/injection.dart';

class AppLoaderWrapperPage extends StatelessWidget implements AutoRouteWrapper {
  const AppLoaderWrapperPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<SignupBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<LoginBloc>(),
        ),
      ],
      child: this,
    );
  }
}

class AppLoaderPage extends StatelessWidget {
  const AppLoaderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final log = logger(AppLoaderPage);

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        state.when(
          unknown: () {
            context.read<AuthBloc>().add(const AuthEvent.autoSignInAttempt());
          },
          authenticated: (value) {},
          unauthenticated: () {},
          loading: () {},
        );
      },
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
          loading: () => Scaffold(
            body: Center(
              child: PlatformButton(
                child: const Text('Confirm Account'),
                onPressed: () {
                  // context.read<SignupBloc>().add(const SignupEvent.submitted());
                },
              ),
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
