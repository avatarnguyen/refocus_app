// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i3;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart' as _i5;
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart'
    as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i3.HomePage());
    },
    CalendarListRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.CalendarListPage());
    },
    QuickAddRoute.name: (routeData) {
      return _i1.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.QuickAddPage(),
          fullscreenDialog: true,
          transitionsBuilder: _i1.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(CalendarListRoute.name, path: '/calendar-list-page'),
        _i1.RouteConfig(QuickAddRoute.name, path: '/quick-add-page')
      ];
}

class HomeRoute extends _i1.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class CalendarListRoute extends _i1.PageRouteInfo<void> {
  const CalendarListRoute() : super(name, path: '/calendar-list-page');

  static const String name = 'CalendarListRoute';
}

class QuickAddRoute extends _i1.PageRouteInfo<void> {
  const QuickAddRoute() : super(name, path: '/quick-add-page');

  static const String name = 'QuickAddRoute';
}
