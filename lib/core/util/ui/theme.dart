import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';

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

final materialThemeData = ThemeData(
  appBarTheme: const AppBarTheme(color: kcPrimary500),
  backgroundColor: kcLightBackground,
  colorScheme: const ColorScheme(
    primary: kcPrimary500,
    secondary: kcSecondary400,
    surface: Colors.white70,
    background: kcDarkBackground,
    error: kcError500,
    onPrimary: kcPrimary100,
    onSecondary: kcSecondary100,
    onSurface: Colors.black87,
    onBackground: Colors.black87,
    onError: Colors.white,
    brightness: Brightness.light,
  ),
  textTheme: _materialTextTheme,
  brightness: Brightness.light,
);

final materialDarkThemeData = ThemeData(
  appBarTheme: const AppBarTheme(color: kcPrimary500),
  backgroundColor: kcDarkBackground,
  colorScheme: const ColorScheme(
    primary: kcPrimary500,
    secondary: kcSecondary500,
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

// -----------------------------------------------------------------------
// CUpertino Themes
const cupertinoLightTheme = CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: kcPrimary500,
  scaffoldBackgroundColor: kcLightBackground,
  textTheme: cupertinoTextLightTheme,
);

const cupertinoTextLightTheme = CupertinoTextThemeData(
  primaryColor: kcPrimary500,
  textStyle: kBodyStyleRegular,
  navTitleTextStyle: kHeadline2StyleRegular,
  navLargeTitleTextStyle: kHeadline1StyleBold,
);
