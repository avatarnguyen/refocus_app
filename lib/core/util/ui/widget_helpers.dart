import 'package:flutter/widgets.dart';
import 'package:styled_widget/styled_widget.dart';

Widget todayPage({required Widget child}) => SafeArea(
      child: SizedBox(
        child: Styled.widget(child: child),
      ).padding(bottom: 40, left: 8, right: 8),
    );
Widget calendarPage({required Widget child}) => SafeArea(
      child: SizedBox(
        child: Styled.widget(child: child),
      ).padding(bottom: 40),
    );

Widget headerContainer({required Widget child}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Styled.widget(child: child),
    );

Widget headerTodayContainer({required Widget child}) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Styled.widget(child: child),
    );
