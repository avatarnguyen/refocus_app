import 'package:flutter/material.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

class AppointmentEventCellWidget extends StatelessWidget {
  const AppointmentEventCellWidget({
    Key? key,
    required this.width,
    required this.diff,
    required this.height,
    required this.backgroudColor,
    required this.event,
    required this.textColor,
  }) : super(key: key);

  final double width;
  final int diff;
  final double height;
  final Color backgroudColor;
  final CalendarEventEntry event;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: diff < 25 ? 18 : height,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        color: backgroudColor,
      ),
      child: [
        [
          SizedBox(
            child: Text(
              event.subject,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textScaleFactor: (diff > 30 || diff < 20) ? 1.0 : 0.86,
              style: diff > 20
                  ? context.textTheme.bodyText2!.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    )
                  : kTinyStyleRegular.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
            ),
          ).padding(
            vertical: diff > 20 ? 4 : 2,
          ),
          if (diff > 30)
            [
              Icon(
                Icons.alarm_on,
                color: textColor.withOpacity(0.9),
                size: 16,
              ),
              horizontalSpaceTiny,
              Text(
                "${DateFormat('hh:mm a').format(event.startDateTime!)} - ${DateFormat('hh:mm a').format(event.endDateTime!)}",
                textScaleFactor: diff > 45 ? 1.0 : 0.7,
                style: context.textTheme.subtitle2!
                    .copyWith(color: textColor.withOpacity(0.9)),
              )
            ]
                .toRow()
                .parent(({required child}) => SizedBox(
                      child: child,
                    ))
                .flexible(),
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(({required child}) => SizedBox(
                  child: child,
                ))
            .expanded(flex: 10),
        Icon(
          Icons.more_horiz,
          color: textColor,
          size: diff > 20 ? 24 : 22,
        ).flexible(),
      ].toRow(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
    );
  }
}
