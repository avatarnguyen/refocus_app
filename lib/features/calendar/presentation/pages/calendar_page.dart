import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/presentation/helper/page_stream.dart';
import 'package:refocus_app/core/util/helpers/logging.dart' as custom_log;
import 'package:refocus_app/core/util/ui/ui_helper.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/calendar_bloc.dart';
import 'package:refocus_app/features/calendar/presentation/bloc/calendar/datetime_stream.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendar_monthview_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendarview_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/widgets.dart';
import 'package:refocus_app/injection.dart';
import 'package:uuid/uuid.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key, required this.changePage}) : super(key: key);

  final VoidCallback changePage;

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
      child: CalendarWidget(
        changePage: _changePage,
      ),
    );
  }

  void _changePage() {
    widget.changePage();
  }

  @override
  bool get wantKeepAlive => true;
}

class CalendarWidget extends StatefulWidget {
  const CalendarWidget({
    Key? key,
    required this.changePage,
  }) : super(key: key);

  final VoidCallback changePage;

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final log = custom_log.logger(CalendarWidget);

  final PageStream _pageStream = getIt<PageStream>();
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

  //TODO: move this to home page
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
  }

  //! Should put sign in other page
  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      log.e(error);
    }
  }

  String returnDate(DateTime date) {
    return DateFormat.MMMMEEEEd().format(date);
  }

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();

    return PlatformScaffold(
      backgroundColor: kcLightBackground,
      body: <Widget>[
        [
          [
            const SizedBox(height: 24, width: 24),
            const Icon(
              Icons.task_alt,
              size: 26,
              color: kcPrimary500,
            ).ripple().gestures(onTap: () {
              widget.changePage();
            }),
          ]
              .toRow(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
              )
              .padding(top: 10),
          // verticalSpaceSmall,
          [
            [
              PlatformText(
                today.year.toString(),
                overflow: TextOverflow.fade,
                style: context.textTheme.headline3!.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
              PlatformText(
                returnDate(today),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: true,
                textScaleFactor: context.textScaleFactor,
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
              CupertinoIcons.list_bullet_below_rectangle,
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
                _pageStream.broadCastCurrentPage(showMonthView ? 2 : 0);
              });
            }),
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(headerContainer),

        if (showMonthView) verticalSpaceRegular else verticalSpaceTiny,
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
