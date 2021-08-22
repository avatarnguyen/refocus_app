import 'package:flutter/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

Widget page({required Widget child}) => SafeArea(
    bottom: false,
    child: Container(
        padding: const EdgeInsets.only(left: 6),
        child: Styled.widget(child: child)));

Widget headerContainer({required Widget child}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    child: Styled.widget(child: child));

Widget headerTodayContainer({required Widget child}) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8),
    child: Styled.widget(child: child));
