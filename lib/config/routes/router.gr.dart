// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:refocus_app/config/routes/custom_router.dart' as _i7;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i1;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart' as _i2;
import 'package:refocus_app/features/task/domain/entities/project_entry.dart'
    as _i8;
import 'package:refocus_app/features/task/presentation/pages/create_project_page.dart'
    as _i3;
import 'package:refocus_app/features/task/presentation/pages/task_page.dart'
    as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    HomeRouteWidget.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePageWidget());
    },
    QuickAddRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i2.QuickAddPage(),
          customRouteBuilder: _i7.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    CreateProjectRoute.name: (routeData) {
      final args = routeData.argsAs<CreateProjectRouteArgs>(
          orElse: () => const CreateProjectRouteArgs());
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i3.CreateProjectPage(key: args.key, project: args.project),
          customRouteBuilder: _i7.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    },
    TaskRoute.name: (routeData) {
      final args = routeData.argsAs<TaskRouteArgs>();
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: _i4.TaskPage(key: args.key, project: args.project),
          customRouteBuilder: _i7.modalSheetCustomRouteBuilder,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomeRoute.name, path: '/', children: [
          _i5.RouteConfig(HomeRouteWidget.name, path: ''),
          _i5.RouteConfig(QuickAddRoute.name, path: 'quick-add-page'),
          _i5.RouteConfig(CreateProjectRoute.name, path: 'create-project-page'),
          _i5.RouteConfig(TaskRoute.name, path: 'task-page')
        ])
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute({List<_i5.PageRouteInfo>? children})
      : super(name, path: '/', initialChildren: children);

  static const String name = 'HomeRoute';
}

/// generated route for [_i1.HomePageWidget]
class HomeRouteWidget extends _i5.PageRouteInfo<void> {
  const HomeRouteWidget() : super(name, path: '');

  static const String name = 'HomeRouteWidget';
}

/// generated route for [_i2.QuickAddPage]
class QuickAddRoute extends _i5.PageRouteInfo<void> {
  const QuickAddRoute() : super(name, path: 'quick-add-page');

  static const String name = 'QuickAddRoute';
}

/// generated route for [_i3.CreateProjectPage]
class CreateProjectRoute extends _i5.PageRouteInfo<CreateProjectRouteArgs> {
  CreateProjectRoute({_i6.Key? key, _i8.ProjectEntry? project})
      : super(name,
            path: 'create-project-page',
            args: CreateProjectRouteArgs(key: key, project: project));

  static const String name = 'CreateProjectRoute';
}

class CreateProjectRouteArgs {
  const CreateProjectRouteArgs({this.key, this.project});

  final _i6.Key? key;

  final _i8.ProjectEntry? project;
}

/// generated route for [_i4.TaskPage]
class TaskRoute extends _i5.PageRouteInfo<TaskRouteArgs> {
  TaskRoute({_i6.Key? key, required _i8.ProjectEntry project})
      : super(name,
            path: 'task-page', args: TaskRouteArgs(key: key, project: project));

  static const String name = 'TaskRoute';
}

class TaskRouteArgs {
  const TaskRouteArgs({this.key, required this.project});

  final _i6.Key? key;

  final _i8.ProjectEntry project;
}
