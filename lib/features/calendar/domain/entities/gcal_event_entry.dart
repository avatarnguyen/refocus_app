import 'package:equatable/equatable.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

class GCalEventEntry extends Equatable {
  const GCalEventEntry({required this.appointment});

  final google_api.Event appointment;

  @override
  List<Object?> get props => [appointment];
}
