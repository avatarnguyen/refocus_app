import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/util/ui/layout_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';

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
      decoration: BoxDecoration(
        color: textColor,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: const [
          kShadowLightBase,
          kShadowLight20,
        ],
      ),
      padding: const EdgeInsets.only(left: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
          color: Colors.white,
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
                        fontSize: 16,
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
                Text(
                  "${DateFormat('hh:mm a').format(event.startDateTime!.toLocal())} - ${DateFormat('hh:mm a').format(event.endDateTime!.toLocal())}",
                  textScaleFactor: diff > 45 ? 1.0 : 0.7,
                  style: context.textTheme.subtitle2!.copyWith(
                    color: textColor.withOpacity(0.9),
                  ),
                  overflow: TextOverflow.fade,
                ).flexible(),
              ]
                  .toRow()
                  .parent(({required child}) => SizedBox(
                        child: Styled.widget(child: child),
                      ))
                  .flexible(),
          ]
              .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
              .parent(
                ({required child}) => SizedBox(
                  child: Styled.widget(child: child),
                ),
              )
              .expanded(),
        ].toRow(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }
}
