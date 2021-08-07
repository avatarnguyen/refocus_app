import 'package:flutter/widgets.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:styled_widget/styled_widget.dart';

Widget page({required Widget child}) =>
    SafeArea(child: Container(child: Styled.widget(child: child)));

Widget headerContainer({required Widget child}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Styled.widget(child: child));
