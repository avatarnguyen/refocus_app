import 'package:auto_route/auto_route.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Route<T> modalSheetCustomRouteBuilder<T>(
    BuildContext context, Widget child, CustomPage<T> page) {
  return CupertinoModalBottomSheetRoute(
    elevation: 16,
    settings: page,
    expanded: false,
    topRadius: const Radius.circular(16),
    builder: (BuildContext context) => child,
  );
}
