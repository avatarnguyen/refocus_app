// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter/widgets.dart' as _i7;
import 'package:refocus_app/core/presentation/pages/home_page.dart' as _i1;
import 'package:refocus_app/core/presentation/pages/quickadd_page.dart' as _i4;
import 'package:refocus_app/core/presentation/widgets/edit_page_widgets/edit_task_view.dart'
    as _i3;
import 'package:refocus_app/features/calendar/presentation/pages/calendar_list_page.dart'
    as _i2;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.HomePage());
    },
    CalendarListRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.CalendarListPage());
    },
    EditTaskView.name: (routeData) {
      final args = routeData.argsAs<EditTaskViewArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.EditTaskView(
              key: args.key, taskID: args.taskID, colorID: args.colorID));
    },
    QuickAddRoute.name: (routeData) {
      return _i5.CustomPage<dynamic>(
          routeData: routeData,
          child: const _i4.QuickAddPage(),
          fullscreenDialog: true,
          transitionsBuilder: _i5.TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
          opaque: true,
          barrierDismissible: false);
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(HomeRoute.name, path: '/'),
        _i5.RouteConfig(CalendarListRoute.name, path: '/calendar-list-page'),
        _i5.RouteConfig(EditTaskView.name, path: '/edit-task-view'),
        _i5.RouteConfig(QuickAddRoute.name, path: '/quick-add-page')
      ];
}

/// generated route for [_i1.HomePage]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [_i2.CalendarListPage]
class CalendarListRoute extends _i5.PageRouteInfo<void> {
  const CalendarListRoute() : super(name, path: '/calendar-list-page');

  static const String name = 'CalendarListRoute';
}

/// generated route for [_i3.EditTaskView]
class EditTaskView extends _i5.PageRouteInfo<EditTaskViewArgs> {
  EditTaskView({_i7.Key? key, required String taskID, String? colorID})
      : super(name,
            path: '/edit-task-view',
            args: EditTaskViewArgs(key: key, taskID: taskID, colorID: colorID));

  static const String name = 'EditTaskView';
}

class EditTaskViewArgs {
  const EditTaskViewArgs({this.key, required this.taskID, this.colorID});

  final _i7.Key? key;

  final String taskID;

  final String? colorID;
}

/// generated route for [_i4.QuickAddPage]
class QuickAddRoute extends _i5.PageRouteInfo<void> {
  const QuickAddRoute() : super(name, path: '/quick-add-page');

  static const String name = 'QuickAddRoute';
}
