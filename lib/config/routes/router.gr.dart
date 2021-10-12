// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i1;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart' as _i3;
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart'
    as _i2;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CalendarListRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.CalendarListPage());
    },
    QuickAddRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.QuickAddPage(),
          fullscreenDialog: true,
          transitionsBuilder: _i4.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomeRoute.name, path: '/'),
        _i4.RouteConfig(CalendarListRoute.name, path: '/calendar-list-page'),
        _i4.RouteConfig(QuickAddRoute.name, path: '/quick-add-page')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.CalendarListPage]
class CalendarListRoute extends _i4.PageRouteInfo<void> {
  const CalendarListRoute() : super(name, path: '/calendar-list-page');

  static const String name = 'CalendarListRoute';
}

/// generated route for [_i3.QuickAddPage]
class QuickAddRoute extends _i4.PageRouteInfo<void> {
  const QuickAddRoute() : super(name, path: '/quick-add-page');

  static const String name = 'QuickAddRoute';
}
