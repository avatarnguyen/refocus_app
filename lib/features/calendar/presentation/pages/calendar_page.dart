import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:refocus_app/core/util/ui/widget_helpers.dart';
import 'package:refocus_app/injection.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
            .add(GetAllCalendarEntries());
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
                  view: CalendarView.day,
                  dataSource: state.calendarData,
                  // monthViewSettings: const MonthViewSettings(
                  //   appointmentDisplayMode:
                  //       MonthAppointmentDisplayMode.appointment,
                  // ),
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
