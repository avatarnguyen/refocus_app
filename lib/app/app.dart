// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:refocus_app/constants/routes_name.dart';
import 'package:refocus_app/core/presentation/pages/home_page.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart';
import 'package:refocus_app/l10n/l10n.dart';

// Amplify Flutter Packages
import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_datastore/amplify_datastore.dart';
// import 'package:amplify_api/amplify_api.dart'; // UNCOMMENT this line after backend is deployed

// Generated in previous step
import '../models/ModelProvider.dart';
import '../amplifyconfiguration.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool _amplifyConfigured = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  void _configureAmplify() async {
    // await Amplify.addPlugin(AmplifyAPI()); // UNCOMMENT this line after backend is deployed
    await Amplify.addPlugin(
        AmplifyDataStore(modelProvider: ModelProvider.instance));

    // Once Plugins are added, configure Amplify
    await Amplify.configure(amplifyconfig);
    try {
      setState(() {
        _amplifyConfigured = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => HomePage(amplifyConfigured: _amplifyConfigured)),
        GetPage(
          name: rCalendarListPage,
          page: () => const CalendarListPage(),
          fullscreenDialog: true,
          transition: Transition.cupertinoDialog,
        ),
      ],
      theme: ThemeData(
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
          textTheme: const TextTheme(
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
          )),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // home: const HomePage(),
    );
  }
}
