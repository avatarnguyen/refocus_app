// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Amplify Flutter Packages
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/ui/theme.dart';
import 'package:refocus_app/features/auth/presentation/authentication/bloc/auth_bloc.dart';
import 'package:refocus_app/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:refocus_app/features/auth/presentation/signup/bloc/signup_bloc.dart';
import 'package:refocus_app/injection.dart';
import 'package:refocus_app/l10n/l10n.dart';

// Generated in previous step
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // final log = logger(App);

  // bool _amplifyAndGoogleConfigured = false;

  @override
  void initState() {
    // _configureAmplifyAndGoogleSignIn();
    super.initState();
    Intl.defaultLocale = 'en_US';
  }

  @override
  Widget build(BuildContext context) {
    // final _router = getRouterConfig(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<AuthBloc>()
            ..add(
              const AuthEvent.autoSignInAttempt(),
            ),
        ),
        BlocProvider(
          create: (_) => getIt<SignupBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<LoginBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: goRouter.routerDelegate,
        routeInformationParser: goRouter.routeInformationParser,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
        ],
        // supportedLocales: AppLocalizations.supportedLocales,
        theme: materialThemeData,
        darkTheme: materialDarkThemeData,
        themeMode: ThemeMode.light,
      ),
    );
  }
}
