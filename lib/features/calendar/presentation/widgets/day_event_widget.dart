import 'package:flutter/material.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:get/get.dart';

class DayEventCellWidget extends StatelessWidget {
  const DayEventCellWidget({
    Key? key,
    required this.backgroudColor,
    required this.event,
    required this.textColor,
    required this.height,
    required this.width,
  }) : super(key: key);

  final Color backgroudColor;
  final CalendarEventEntry event;
  final Color textColor;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: backgroudColor,
      ),
      child: Text(
        event.subject,
        textAlign: TextAlign.center,
        style: context.textTheme.subtitle2!.copyWith(
          color: textColor,
        ),
      ),
    );
  }
}
