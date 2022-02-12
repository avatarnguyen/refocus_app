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
  const CalendarPage({Key? key}) : super(key: key);

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const CalendarWidget();
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

  final PageStream _pageStream = getIt<PageStream>();
  final DateTimeStream _dateTimeStream = getIt<DateTimeStream>();
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();
  GoogleSignInAccount? _currentUser;

  Uuid uuid = const Uuid();

  bool showMonthView = false;

  @override
  void initState() {
    super.initState();
    log.i('Init: ${_googleSignIn.currentUser}');
    WidgetsBinding.instance?.addPostFrameCallback(
      (_) {
        _getCurrentUser();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  //TODO: move this to home page
  Future<void> _getCurrentUser() async {
    final _isSignInGoogle = await _googleSignIn.isSignedIn();
    if (_isSignInGoogle) {
      setState(() {
        _currentUser = _googleSignIn.currentUser;
      });
    } else {
      _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
        log.v('Google Sign In On Current User Changed');

        setState(() {
          _currentUser = account;
        });
      });
    }
    if (_currentUser != null) {
      final _start = DateTime.now();
      final _end = DateTime.now();
      context.read<CalendarBloc>().add(GetCalendarEntries(
            start: _start,
            end: _end,
          ));
    }
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
            ).ripple().gestures(onTap: () {}),
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
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).gestures(onTap: () {
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
        ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).parent(headerContainer),

        if (showMonthView) verticalSpaceRegular else verticalSpaceTiny,
        // Calendar View
        BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is CalendarInitial) {
              return [
                const MessageDisplay(message: 'Sign In'),
                ElevatedButton(
                  onPressed: () async {
                    await _handleSignIn();
                  },
                  child: const Text('Sign In Google'),
                ).center(),
              ].toColumn();
            } else if (state is CalendarLoading) {
              return const Center(child: LoadingWidget());
            } else if (state is CalendarError) {
              return MessageDisplay(message: state.message);
            } else if (state is CalendarLoaded) {
              return showMonthView ? CalendarMonthViewWidget(state: state) : CalendarViewWidget(state: state);
            } else {
              return const MessageDisplay(message: 'Unexpected State');
            }
          },
        ),
      ]
          .toColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
          )
          .parent(calendarPage),
    );
  }
}
