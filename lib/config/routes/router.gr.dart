// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:refocus_app/config/routes/custom_router.dart' as _i11;
import 'package:refocus_app/core/presentation/pages/app_loader_page.dart'
    as _i1;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i4;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart' as _i5;
import 'package:refocus_app/features/auth/presentation/pages/login_page.dart'
    as _i2;
import 'package:refocus_app/features/auth/presentation/pages/signup_page.dart'
    as _i3;
import 'package:refocus_app/features/setting/presentation/pages/setting_page.dart'
    as _i8;
import 'package:refocus_app/features/task/domain/entities/project_entry.dart'
    as _i12;
import 'package:refocus_app/features/task/presentation/pages/create_project_page.dart'
    as _i6;
import 'package:refocus_app/features/task/presentation/pages/task_page.dart'
    as _i7;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    AppLoaderWrapperRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AppLoaderWrapperPage());
    },
    AppLoaderRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AppLoaderPage());
    },
    LoginRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i2.LoginPage(),
          fullscreenDialog: true);
    },
    SignupRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.SignupPage(),
          fullscreenDialog: true);
    },
    HomeRoute.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.HomePage());
    },
    HomeRouteWidget.name: (routeData) {
      return _i9.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.HomePageWidget());
    },
    QuickAddRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i5.QuickAddPage(),
          customRouteBuilder: _i11.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    CreateProjectRoute.name: (routeData) {
      final args = routeData.argsAs<CreateProjectRouteArgs>(
          orElse: () => const CreateProjectRouteArgs());
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: _i6.CreateProjectPage(key: args.key, project: args.project),
          customRouteBuilder: _i11.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    TaskRoute.name: (routeData) {
      final args = routeData.argsAs<TaskRouteArgs>();
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: _i7.TaskPage(key: args.key, project: args.project),
          customRouteBuilder: _i11.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SettingRoute.name: (routeData) {
      return _i9.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i8.SettingPage(),
          customRouteBuilder: _i11.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(AppLoaderWrapperRoute.name, path: '/', children: [
          _i9.RouteConfig(AppLoaderRoute.name, path: ''),
          _i9.RouteConfig(LoginRoute.name, path: 'login-page'),
          _i9.RouteConfig(SignupRoute.name, path: 'signup-page'),
          _i9.RouteConfig(HomeRoute.name, path: 'home-page', children: [
            _i9.RouteConfig(HomeRouteWidget.name, path: ''),
            _i9.RouteConfig(QuickAddRoute.name, path: 'quick-add-page'),
            _i9.RouteConfig(CreateProjectRoute.name,
                path: 'create-project-page'),
            _i9.RouteConfig(TaskRoute.name, path: 'task-page'),
            _i9.RouteConfig(SettingRoute.name, path: 'setting-page')
          ])
        ])
      ];
}

/// generated route for [_i1.AppLoaderWrapperPage]
class AppLoaderWrapperRoute extends _i9.PageRouteInfo<void> {
  const AppLoaderWrapperRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'AppLoaderWrapperRoute';
}

/// generated route for [_i1.AppLoaderPage]
class AppLoaderRoute extends _i9.PageRouteInfo<void> {
  const AppLoaderRoute() : super(name, path: '');

  static const String name = 'AppLoaderRoute';
}

/// generated route for [_i2.LoginPage]
class LoginRoute extends _i9.PageRouteInfo<void> {
  const LoginRoute() : super(name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for [_i3.SignupPage]
class SignupRoute extends _i9.PageRouteInfo<void> {
  const SignupRoute() : super(name, path: 'signup-page');

  static const String name = 'SignupRoute';
}

/// generated route for [_i4.HomePage]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
      : super(name, path: 'home-page', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for [_i4.HomePageWidget]
class HomeRouteWidget extends _i9.PageRouteInfo<void> {
  const HomeRouteWidget() : super(name, path: '');

  static const String name = 'HomeRouteWidget';
}

/// generated route for [_i5.QuickAddPage]
class QuickAddRoute extends _i9.PageRouteInfo<void> {
  const QuickAddRoute() : super(name, path: 'quick-add-page');

  static const String name = 'QuickAddRoute';
}

/// generated route for [_i6.CreateProjectPage]
class CreateProjectRoute extends _i9.PageRouteInfo<CreateProjectRouteArgs> {
  CreateProjectRoute({_i10.Key? key, _i12.ProjectEntry? project})
      : super(name,
            path: 'create-project-page',
            args: CreateProjectRouteArgs(key: key, project: project));

  static const String name = 'CreateProjectRoute';
}

class CreateProjectRouteArgs {
  const CreateProjectRouteArgs({this.key, this.project});

  final _i10.Key? key;

  final _i12.ProjectEntry? project;
}

/// generated route for [_i7.TaskPage]
class TaskRoute extends _i9.PageRouteInfo<TaskRouteArgs> {
  TaskRoute({_i10.Key? key, required _i12.ProjectEntry project})
      : super(name,
            path: 'task-page', args: TaskRouteArgs(key: key, project: project));

  static const String name = 'TaskRoute';
}

class TaskRouteArgs {
  const TaskRouteArgs({this.key, required this.project});

  final _i10.Key? key;

  final _i12.ProjectEntry project;
}

/// generated route for [_i8.SettingPage]
class SettingRoute extends _i9.PageRouteInfo<void> {
  const SettingRoute() : super(name, path: 'setting-page');

  static const String name = 'SettingRoute';
}
