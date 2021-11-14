// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Amplify Flutter Packages
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/theme.dart';
import 'package:refocus_app/l10n/l10n.dart';

// Generated in previous step
class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  // final log = logger(App);
  final _appRouter = AppRouter();

  // bool _amplifyAndGoogleConfigured = false;

  @override
  void initState() {
    // _configureAmplifyAndGoogleSignIn();
    super.initState();
    Intl.defaultLocale = 'en_US';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: _appRouter.delegate(
        navigatorObservers: () => [
          AppRouteObserver(),
        ],
      ),
      routeInformationParser: _appRouter.defaultRouteParser(),
      routeInformationProvider: AutoRouteInformationProvider(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: materialThemeData,
      darkTheme: materialDarkThemeData,
      themeMode: ThemeMode.light,
    );
  }
}

class AppRouteObserver extends AutoRouterObserver {
  final _log = logger(AppRouteObserver);
  @override
  void didPush(Route route, Route? previousRoute) {
    _log.i('New route pushed: ${route.settings.name}');
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _log.i('Route pop: ${route.settings.name}');
    super.didPop(route, previousRoute);
  }
}
