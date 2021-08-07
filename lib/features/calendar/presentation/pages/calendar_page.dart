import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:refocus_app/core/util/ui/style_helpers.dart';
import 'package:refocus_app/core/util/ui/ui_helpers.dart';
import 'package:refocus_app/core/util/ui/widget_helpers.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/helpers/event_params.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendar_monthview_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/calendarview_widget.dart';
import 'package:refocus_app/features/calendar/presentation/widgets/datepicker_widget.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';

import 'package:uuid/uuid.dart';

import '../bloc/calendar_bloc.dart';
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
  final GoogleSignIn _googleSignIn = getIt<GoogleSignIn>();
  GoogleSignInAccount? _currentUser;

  Uuid uuid = const Uuid();

  bool showMonthView = false;

  @override
  void initState() {
    super.initState();

    // _getCurrentUser();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _getCurrentUser();
  }

  void _getCurrentUser() {
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print('Init Google Sign In');

      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        BlocProvider.of<CalendarBloc>(context, listen: false)
            .add(GetCalendarEntries());
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
    } catch (error) {
      print(error);
    }
  }

  String returnMonth(DateTime date) {
    return DateFormat.MMMM().format(date);
  }

  @override
  Widget build(BuildContext context) {
    var testEvent = EventParams(
      calendarId: 'primary',
      eventEntry: CalendarEventEntry(
        id: 'jihijjs8ba46eqh4r53kfhbvds',
        subject: 'Test Event from Momant',
        startDateTime: DateTime.parse('2021-08-05T16:45:00+02:00'),
        endDateTime: DateTime.parse('2021-08-05T18:30:00+02:00'),
        organizer: 'Test Dev',
      ),
    );

    final today = DateTime.now();

    return Scaffold(
      backgroundColor: kcLightBackground,
      // appBar: AppBar(
      //   title: const Text('Calendar Page'),
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(onPressed: () {
        return BlocProvider.of<CalendarBloc>(context, listen: false).add(
          DeleteCalendarEvent(testEvent),
        );
      }),
      body: <Widget>[
        [
          verticalSpaceMedium,
          Text(
            returnMonth(today),
            style: kHeadline2StyleBold,
          ),
          [
            Text(
              today.year.toString(),
              style: kHeadline5StyleRegular,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  showMonthView = !showMonthView;
                });
              },
              child: Icon(
                Icons.calendar_today_rounded,
                size: 24,
                color: showMonthView ? kcPrimary800 : kcPrimary500,
              )
                  .decorated(
                    color: showMonthView ? kcPrimary300 : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                  )
                  .constrained(height: 40, width: 40),
            )
          ].toRow(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
          )
        ]
            .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
            .parent(headerContainer),
        // verticalSpaceSmall,
        if (!showMonthView) const DatePickerWidget(),
        if (!showMonthView) verticalSpaceMedium,
        // Calendar View
        BlocBuilder<CalendarBloc, CalendarState>(
          builder: (context, state) {
            if (state is GcalInitial) {
              return [
                MessageDisplay(message: 'Sign In'),
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
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start).parent((page)),
    );
  }
}
