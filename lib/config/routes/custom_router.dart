import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';

Route<T> myCustomRouteBuilder<T>(
    BuildContext context, Widget child, CustomPage<T> page) {
  return PageRouteBuilder(
      fullscreenDialog: page.fullscreenDialog,
      // this is important
      settings: page,
      pageBuilder: (_, __, ___) => child);
}
