import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/core/util/ui/widget_helpers.dart';
import 'package:refocus_app/features/calendar/domain/entities/calendar_event_entry.dart';
import 'package:refocus_app/features/calendar/domain/usecases/add_event.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';

import '../bloc/gcal_bloc.dart';
import '../widgets/widgets.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GcalBloc>(
      create: (context) => getIt<GcalBloc>(),
      child: const CalendarWidget(),
    );
  }
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

  Uuid uuid = Uuid();

  @override
  void initState() {
    super.initState();

    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      print('Init Google Sign In');

      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        BlocProvider.of<GcalBloc>(context, listen: false)
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Page'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () =>
              BlocProvider.of<GcalBloc>(context, listen: false).add(
                AddCalendarEvent(EventParams(
                  eventEntry: CalendarEventEntry(
                    subject: 'Test Event from Momant',
                    startDateTime: DateTime.parse('2021-08-05T16:45:00+02:00'),
                    endDateTime: DateTime.parse('2021-08-05T18:30:00+02:00'),
                    organizer: 'Test Dev',
                  ),
                )),
              )),
      body: <Widget>[
        BlocBuilder<GcalBloc, GcalState>(
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
              return SizedBox(
                height: 700,
                child: SfCalendar(
                  view: CalendarView.month,
                  dataSource: state.calendarData,
                  monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment,
                  ),
                ).center(),
              );
            } else {
              return const MessageDisplay(
                message: 'Unexpected State',
              );
            }
          },
        ),
        const SizedBox(height: 15),
      ].toColumn().parent((scrollablePage)),
    );
  }
}
