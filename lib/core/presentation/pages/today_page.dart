import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/ui_helper.dart';

class TodayPage extends StatefulWidget {
  const TodayPage({Key? key, required this.onDrawerSelected}) : super(key: key);

  final VoidCallback onDrawerSelected;

  @override
  _TodayPageState createState() => _TodayPageState();
}

class _TodayPageState extends State<TodayPage> {
  final log = custom_log.logger(TodayPage);

  bool showMonthView = false;

  String returnDate(DateTime date) {
    return DateFormat.yMMMMEEEEd('de_DE').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return PlatformScaffold(
      // iosContentBottomPadding: true,
      // iosContentPadding: true,
      backgroundColor: kcLightBackground,
      body: [
        [
          verticalSpaceRegular,
          [
            InkWell(
              onTap: () async {},
              child: const Icon(
                Icons.inbox,
                size: 26,
                color: kcPrimary500,
              ),
            ),
            InkWell(
              onTap: () => widget.onDrawerSelected(),
              child: const Icon(
                Icons.menu,
                size: 26,
                color: kcPrimary500,
              ),
            ),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          verticalSpaceRegular,
          [
            [
              PlatformText(
                'Good Morning!',
                overflow: TextOverflow.fade,
                style: context.textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              verticalSpaceSmall,
              PlatformText(
                returnDate(today),
                style: context.textTheme.headline6!.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.calendar_view_month_rounded,
                size: 24,
                color: showMonthView ? kcPrimary600 : kcPrimary500,
              )
                  .decorated(
                    color: showMonthView ? kcPrimary200 : Colors.transparent,
                    borderRadius: BorderRadius.circular(10),
                  )
                  .constrained(height: 32, width: 32),
            ),
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(headerTodayContainer),
        verticalSpaceRegular,
        [
          const LinearProgressIndicator(
            value: 0.3,
            minHeight: 8.0,
            color: kcPrimary500,
            backgroundColor: kcPrimary200,
          )
              .clipRRect(all: 4.0)
              .parent(({required child}) => Flexible(child: child)),
          horizontalSpaceSmall,
          Text(
            '30 %',
            style: context.textTheme.subtitle1!.copyWith(color: Colors.black54),
          )
        ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween).parent(
              ({required child}) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                ),
                height: 32,
                decoration: BoxDecoration(
                  boxShadow: const [
                    kShadowLightBase,
                    kShadowLight60,
                  ],
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: child,
              ),
            ),
        verticalSpaceSmall,
        //* Body: List View
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return const ListTile(
                  title: Text('Test Cell'),
                );
              }),
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).parent((page)),
    );
  }
}
