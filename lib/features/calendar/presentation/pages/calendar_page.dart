import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/route_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/constants/routes_name.dart';
import 'package:refocus_app/core/util/helpers/date_utils.dart'
    as custom_date_tils;
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/ui_helper.dart';

import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/event_params.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendar_monthview_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendarview_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/datepicker_widget.dart';
import 'package:refocus_app/injection.dart';

import 'package:uuid/uuid.dart';

import '../bloc/calendar/calendar_bloc.dart';
import '../widgets/widgets.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider<CalendarBloc>(
      create: (context) => getIt<CalendarBloc>(),
      child: const CalendarWidget(),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    Key? key,
  }) : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final log = custom_log.logger(CalendarWidget);

  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();
  GoogleSignInAccount? _currentUser;

  Uuid uuid = const Uuid();

  bool showMonthView = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      log.v('Init Google Sign In');

      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        BlocProvider.of<CalendarBloc>(context, listen: false)
            .add(GetCalendarEntries());
      }
    });
    // _googleSignIn.signInSilently();
  }

  //! Should put sign in other page
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      log.e(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return PlatformScaffold(
      backgroundColor: kcLightBackground,
      body: <Widget>[
        [
          // verticalSpaceRegular,
          [
            const Icon(
              Icons.calendar_view_day,
              size: 26,
              color: kcPrimary500,
            ).ripple().gestures(
              onTap: () async {
                await Get.toNamed<dynamic>(rCalendarListPage);
                context.read<CalendarBloc>().add(GetCalendarEntries());
              },
            ),
            const Icon(
              Icons.inbox,
              size: 26,
              color: kcPrimary500,
            ).ripple().gestures(onTap: () {}),
          ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
          verticalSpaceRegular,
          [
            [
              PlatformText(
                today.year.toString(),
                overflow: TextOverflow.fade,
                style: context.textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              PlatformText(
                custom_date_tils.CustomDateUtils.returnMonth(today),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
                textScaleFactor: context.mediaQuery.textScaleFactor,
                style: context.textTheme.bodyText2!.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).gestures(
                onTap: () {
              _dateTimeStream.broadCastCurrentDate(DateTime.now());
            }),
            // .padding(left: 6),
            Icon(
              Icons.calendar_view_month_rounded,
              size: 24,
              color: showMonthView ? kcPrimary600 : kcPrimary500,
            )
                .decorated(
                  color: showMonthView ? kcPrimary200 : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                )
                .constrained(height: 32, width: showMonthView ? 32 : 26)
                .ripple()
                .gestures(onTap: () {
              setState(() {
                showMonthView = !showMonthView;
              });
            }),
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(headerContainer),
        verticalSpaceSmall,
        // if (!showMonthView) const DatePickerWidget(),
        // if (showMonthView) verticalSpaceMedium,
        // Calendar View
        BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is GcalInitial) {
              return [
                const MessageDisplay(message: 'Sign In'),
                ElevatedButton(
                  onPressed: () async {
                    await _handleSignIn();
                  },
                  child: const Text('Sign In Google'),
                ).center(),
              ].toColumn();
            } else if (state is Loading) {
              return const LoadingWidget();
            } else if (state is Error) {
              return MessageDisplay(
                message: state.message,
              );
            } else if (state is Loaded) {
              return showMonthView
                  ? CalendarMonthViewWidget(state: state)
                  : CalendarViewWidget(state: state);
            } else {
              return const MessageDisplay(
                message: 'Unexpected State',
              );
            }
          },
        ),
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .parent(calendarPage),
    );
  }
}
