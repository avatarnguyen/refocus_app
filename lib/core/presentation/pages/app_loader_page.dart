import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:refocus_app/amplifyconfiguration.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/pages/login_page.dart';
import 'package:refocus_app/features/auth/presentation/signup/bloc/signup_bloc.dart';
import 'package:refocus_app/features/auth/presentation/signup/pages/confirmation_page.dart';
import 'package:refocus_app/injection.dart';
import 'package:refocus_app/models/ModelProvider.dart';

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
          create: (_) =>
              getIt<AuthBloc>(), //..add(const AuthEvent.autoSignInAttempt()),
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

class AppLoaderPage extends StatefulWidget {
  const AppLoaderPage({Key? key}) : super(key: key);

  @override
  State<AppLoaderPage> createState() => _AppLoaderPageState();
}

class _AppLoaderPageState extends State<AppLoaderPage> {
  final log = logger(AppLoaderPage);
  bool _amplifyConfigured = false;

  Future _configureAmplify() async {
    try {
      await Amplify.addPlugins(
        [
          AmplifyAPI(),
          AmplifyDataStore(modelProvider: ModelProvider.instance),
          AmplifyAuthCognito(),
        ],
      );

      // Once Plugins are added, configure Amplify
      await Amplify.configure(amplifyconfig);
      // ignore: use_build_context_synchronously
      context.read<AuthBloc>().add(const AuthEvent.autoSignInAttempt());

      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      log.e(e);
    }
  }

  @override
  void initState() {
    _configureAmplify();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        log.i('$state Amplify isConfigured: ${Amplify.isConfigured}');
        return _amplifyConfigured
            ? state.maybeWhen(
                unknown: () => const LoginPage(),
                authenticated: (userEntry) => const AutoRouter(),
                unauthenticated: () => const LoginPage(),
                loading: () => const Scaffold(
                  body: Center(child: progressIndicator),
                ),
                confirmationRequired: () => const ConfirmationPage(),
                orElse: () => const Scaffold(
                  body: Center(
                      child:
                          Text('Something went wrong with the Authentication')),
                ),
              )
            : const Scaffold(body: Center(child: progressIndicator));
      },
    );
  }
}
    // return Scaffold(
                  //   body: Center(
                  //     child: PlatformButton(
                  //       child: Text('Sign Out'),
                  //       onPressed: () {
                  //         context.read<AuthBloc>().add(AuthEvent.signOutRequested());
                  //       },
                  //     ),
                  //   ),
                  // );