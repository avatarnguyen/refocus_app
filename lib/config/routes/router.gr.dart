// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;
import 'package:refocus_app/config/routes/custom_router.dart' as _i6;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i1;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart' as _i2;
import 'package:refocus_app/features/today/presentation/pages/create_project_page.dart'
    as _i3;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    HomeRouteWidget.name: (routeData) {
      return _i4.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePageWidget());
    },
    QuickAddRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.QuickAddPage(),
          customRouteBuilder: _i6.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    CreateProjectRoute.name: (routeData) {
      return _i4.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i3.CreateProjectPage(),
          customRouteBuilder: _i6.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(HomeRoute.name, path: '/', children: [
          _i4.RouteConfig(HomeRouteWidget.name, path: ''),
          _i4.RouteConfig(QuickAddRoute.name, path: 'quick-add-page'),
          _i4.RouteConfig(CreateProjectRoute.name, path: 'create-project-page')
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute({List<_i4.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for [_i1.HomePageWidget]
class HomeRouteWidget extends _i4.PageRouteInfo<void> {
  const HomeRouteWidget() : super(name, path: '');

  static const String name = 'HomeRouteWidget';
}

/// generated route for [_i2.QuickAddPage]
class QuickAddRoute extends _i4.PageRouteInfo<void> {
  const QuickAddRoute() : super(name, path: 'quick-add-page');

  static const String name = 'QuickAddRoute';
}

/// generated route for [_i3.CreateProjectPage]
class CreateProjectRoute extends _i4.PageRouteInfo<void> {
  const CreateProjectRoute() : super(name, path: 'create-project-page');

  static const String name = 'CreateProjectRoute';
}
