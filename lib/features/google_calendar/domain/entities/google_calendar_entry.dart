import 'package:equatable/equatable.dart';

class GoogleCalendarEntry extends Equatable {
  const GoogleCalendarEntry({required this.title});

  final String title;

  @override
  List<Object?> get props => [title];
}
