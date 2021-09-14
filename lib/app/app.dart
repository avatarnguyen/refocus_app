// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// Amplify Flutter Packages
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:intl/intl.dart';
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
      accentColor: kcTertiary500,
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
    );

    const _cupertinoThemeData = CupertinoThemeData(
      primaryColor: kcPrimary500,
      primaryContrastingColor: CupertinoColors.black,
      scaffoldBackgroundColor: kcLightBackground,
      barBackgroundColor: kcSecondary500,
      textTheme: CupertinoTextThemeData(
        primaryColor: kcPrimary500,
        navLargeTitleTextStyle: kHeadline2StyleBold,
        navTitleTextStyle: kHeadline1StyleRegular,
        navActionTextStyle: kCaptionStyleRegular,
        textStyle: kBodyStyleRegular,
      ),
    );

    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage<dynamic>(name: '/', page: () => const HomePage()),
        GetPage<dynamic>(
          name: rCalendarListPage,
          page: () => const CalendarListPage(),
          fullscreenDialog: true,
          transition: Transition.cupertinoDialog,
        ),
        GetPage<dynamic>(
          name: rAddNewPage,
          page: () => const QuickAddPage(),
          fullscreenDialog: true,
          transition: Transition.fade,
        )
      ],
      theme: _materialThemeData,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
    // return PlatformWidget(
    // cupertino: (context, platform) => GetCupertinoApp(
    //   color: ,
    //   initialRoute: '/',
    //   getPages: _getPagesList,
    //   theme: _cupertinoThemeData,
    //   localizationsDelegates: const [
    //     AppLocalizations.delegate,
    //     GlobalCupertinoLocalizations.delegate,
    //   ],
    //   supporteLocales: AppLocalizations.supportedLocales,
    // ),
    //   material: (context, platform) => GetMaterialApp(
    //     initialRoute: '/',
    //     getPages: _getPagesList,
    //     theme: _materialThemeData,
    //     localizationsDelegates: const [
    //       AppLocalizations.delegate,
    //       GlobalMaterialLocalizations.delegate,
    //     ],
    //     supportedLocales: AppLocalizations.supportedLocales,
    //   ),
    // );
  }
}
