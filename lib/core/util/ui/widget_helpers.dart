import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:styled_widget/styled_widget.dart';

Widget todayPage(BuildContext context, {required Widget child}) => SizedBox(
      child: [
        SizedBox(
          height: 88,
          child: CustomPaint(painter: LinePainter()),
        ).positioned(top: context.height * 0.4, left: 6),
        Styled.widget(child: child).padding(bottom: 40, left: 8, right: 8),
      ].toStack(),
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

class LinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 3.6
      ..strokeCap = StrokeCap.round;

    const startingPoint = Offset.zero;
    final endingPoint = Offset(0, size.height);

    canvas.drawLine(startingPoint, endingPoint, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
