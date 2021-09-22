// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Amplify Flutter Packages
import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/config/routes/router.dart';
import 'package:refocus_app/constants/routes_name.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart';
import 'package:refocus_app/l10n/l10n.dart';

// Generated in previous step

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final log = logger(App);
  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
    Intl.defaultLocale = 'en_US';
  }

  @override
  Widget build(BuildContext context) {
    const _materialTextTheme = TextTheme(
      headline1: kHeadline1StyleBold,
      headline2: kHeadline2StyleBold,
      headline3: kHeadline3StyleRegular,
      headline4: kHeadline4StyleRegular,
      headline5: kHeadline5StyleBold,
      headline6: kHeadline5StyleRegular,
      bodyText1: kBodyStyleBold,
      bodyText2: kBodyStyleRegular,
      caption: kCaptionStyleRegular,
      subtitle1: kSmallStyleRegular,
      subtitle2: kXSmallStyleRegular,
    );
    final _materialThemeData = ThemeData(
      // accentColor: kcTertiary500,
      appBarTheme: const AppBarTheme(color: kcPrimary500),
      backgroundColor: kcLightBackground,
      colorScheme: const ColorScheme(
        primary: kcPrimary500,
        primaryVariant: kcPrimary200,
        secondary: kcSecondary500,
        secondaryVariant: kcSecondary200,
        surface: Colors.white70,
        background: kcLightBackground,
        error: kcError500,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black87,
        onBackground: Colors.black87,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      textTheme: _materialTextTheme,
      brightness: Brightness.light,
    );

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
      theme: _materialThemeData,
      themeMode: ThemeMode.light,
    );
  }
}

class AppRouteObserver extends AutoRouterObserver {
  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
  }
}
