// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/cupertino.dart' as _i13;
import 'package:flutter/material.dart' as _i11;
import 'package:refocus_app/config/routes/custom_router.dart' as _i12;
import 'package:refocus_app/core/presentation/pages/app_loader_page.dart'
    as _i1;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i5;
import 'package:refocus_app/features/auth/presentation/login/pages/login_page.dart'
    as _i2;
import 'package:refocus_app/features/auth/presentation/signup/pages/confirmation_page.dart'
    as _i4;
import 'package:refocus_app/features/auth/presentation/signup/pages/signup_page.dart'
    as _i3;
import 'package:refocus_app/features/create/presentation/pages/create_page.dart'
    as _i6;
import 'package:refocus_app/features/setting/presentation/pages/setting_page.dart'
    as _i9;
import 'package:refocus_app/features/task/domain/entities/project_entry.dart'
    as _i14;
import 'package:refocus_app/features/task/presentation/pages/create_project_page.dart'
    as _i7;
import 'package:refocus_app/features/task/presentation/pages/task_page.dart'
    as _i8;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    AppLoaderWrapperRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AppLoaderWrapperPage());
    },
    AppLoaderRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.AppLoaderPage());
    },
    LoginRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i2.LoginPage(),
          fullscreenDialog: true);
    },
    SignupRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i3.SignupPage(),
          fullscreenDialog: true);
    },
    ConfirmationRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i4.ConfirmationPage(),
          fullscreenDialog: true);
    },
    HomeRoute.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.HomePage());
    },
    HomeRouteWidget.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i5.HomePageWidget());
    },
    CreateRoute.name: (routeData) {
      return _i10.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i6.CreatePage(),
          customRouteBuilder: _i12.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    CreateProjectRoute.name: (routeData) {
      final args = routeData.argsAs<CreateProjectRouteArgs>(
          orElse: () => const CreateProjectRouteArgs());
      return _i10.CustomPage<dynamic>(
          routeData: routeData,
          child: _i7.CreateProjectPage(key: args.key, project: args.project),
          customRouteBuilder: _i12.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    TaskRoute.name: (routeData) {
      final args = routeData.argsAs<TaskRouteArgs>();
      return _i10.CustomPage<dynamic>(
          routeData: routeData,
          child: _i8.TaskPage(key: args.key, project: args.project),
          customRouteBuilder: _i12.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    SettingRoute.name: (routeData) {
      return _i10.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i9.SettingPage(),
          customRouteBuilder: _i12.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(AppLoaderWrapperRoute.name, path: '/', children: [
          _i10.RouteConfig(AppLoaderRoute.name,
              path: '',
              parent: AppLoaderWrapperRoute.name,
              children: [
                _i10.RouteConfig(HomeRoute.name,
                    path: '',
                    parent: AppLoaderRoute.name,
                    children: [
                      _i10.RouteConfig(HomeRouteWidget.name,
                          path: '', parent: HomeRoute.name),
                      _i10.RouteConfig(CreateRoute.name,
                          path: 'create-page', parent: HomeRoute.name),
                      _i10.RouteConfig(CreateProjectRoute.name,
                          path: 'create-project-page', parent: HomeRoute.name),
                      _i10.RouteConfig(TaskRoute.name,
                          path: 'task-page', parent: HomeRoute.name),
                      _i10.RouteConfig(SettingRoute.name,
                          path: 'setting-page', parent: HomeRoute.name)
                    ])
              ]),
          _i10.RouteConfig(LoginRoute.name,
              path: 'login-page', parent: AppLoaderWrapperRoute.name),
          _i10.RouteConfig(SignupRoute.name,
              path: 'signup-page', parent: AppLoaderWrapperRoute.name),
          _i10.RouteConfig(ConfirmationRoute.name,
              path: 'confirmation-page', parent: AppLoaderWrapperRoute.name)
        ])
      ];
}

/// generated route for
/// [_i1.AppLoaderWrapperPage]
class AppLoaderWrapperRoute extends _i10.PageRouteInfo<void> {
  const AppLoaderWrapperRoute({List<_i10.PageRouteInfo>? children})
      : super(AppLoaderWrapperRoute.name, path: '/', initialChildren: children);

  static const String name = 'AppLoaderWrapperRoute';
}

/// generated route for
/// [_i1.AppLoaderPage]
class AppLoaderRoute extends _i10.PageRouteInfo<void> {
  const AppLoaderRoute({List<_i10.PageRouteInfo>? children})
      : super(AppLoaderRoute.name, path: '', initialChildren: children);

  static const String name = 'AppLoaderRoute';
}

/// generated route for
/// [_i2.LoginPage]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: 'login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i3.SignupPage]
class SignupRoute extends _i10.PageRouteInfo<void> {
  const SignupRoute() : super(SignupRoute.name, path: 'signup-page');

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i4.ConfirmationPage]
class ConfirmationRoute extends _i10.PageRouteInfo<void> {
  const ConfirmationRoute()
      : super(ConfirmationRoute.name, path: 'confirmation-page');

  static const String name = 'ConfirmationRoute';
}

/// generated route for
/// [_i5.HomePage]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
      : super(HomeRoute.name, path: '', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i5.HomePageWidget]
class HomeRouteWidget extends _i10.PageRouteInfo<void> {
  const HomeRouteWidget() : super(HomeRouteWidget.name, path: '');

  static const String name = 'HomeRouteWidget';
}

/// generated route for
/// [_i6.CreatePage]
class CreateRoute extends _i10.PageRouteInfo<void> {
  const CreateRoute() : super(CreateRoute.name, path: 'create-page');

  static const String name = 'CreateRoute';
}

/// generated route for
/// [_i7.CreateProjectPage]
class CreateProjectRoute extends _i10.PageRouteInfo<CreateProjectRouteArgs> {
  CreateProjectRoute({_i13.Key? key, _i14.ProjectEntry? project})
      : super(CreateProjectRoute.name,
            path: 'create-project-page',
            args: CreateProjectRouteArgs(key: key, project: project));

  static const String name = 'CreateProjectRoute';
}

class CreateProjectRouteArgs {
  const CreateProjectRouteArgs({this.key, this.project});

  final _i13.Key? key;

  final _i14.ProjectEntry? project;

  @override
  String toString() {
    return 'CreateProjectRouteArgs{key: $key, project: $project}';
  }
}

/// generated route for
/// [_i8.TaskPage]
class TaskRoute extends _i10.PageRouteInfo<TaskRouteArgs> {
  TaskRoute({_i13.Key? key, required _i14.ProjectEntry project})
      : super(TaskRoute.name,
            path: 'task-page', args: TaskRouteArgs(key: key, project: project));

  static const String name = 'TaskRoute';
}

class TaskRouteArgs {
  const TaskRouteArgs({this.key, required this.project});

  final _i13.Key? key;

  final _i14.ProjectEntry project;

  @override
  String toString() {
    return 'TaskRouteArgs{key: $key, project: $project}';
  }
}

/// generated route for
/// [_i9.SettingPage]
class SettingRoute extends _i10.PageRouteInfo<void> {
  const SettingRoute() : super(SettingRoute.name, path: 'setting-page');

  static const String name = 'SettingRoute';
}
