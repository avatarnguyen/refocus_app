import 'package:equatable/equatable.dart';

class GoogleCalendarEntry extends Equatable {
  const GoogleCalendarEntry({required this.summary});

  final String summary;

  @override
  List<Object?> get props => [summary];
}
