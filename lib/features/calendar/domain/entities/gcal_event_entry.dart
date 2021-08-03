import 'package:equatable/equatable.dart';

class GCalEventEntry extends Equatable {
  const GCalEventEntry({
    required this.id,
    required this.subject,
    this.colorId,
    this.notes,
    this.location,
    this.recurrence,
    this.recurringEventId,
    this.startDateTime,
    this.startDate,
    this.endDateTime,
    this.endDate,
    this.organizer,
    this.timeZone,
  });

  final String id;
  final String subject; // Event summary
  final String? colorId;
  final String? notes; // Event description
  final String? location;
  final List<String>? recurrence;
  final String? recurringEventId;
  final DateTime? startDateTime;
  final DateTime? startDate;
  final DateTime? endDateTime;
  final DateTime? endDate;
  final String? organizer;
  final String? timeZone;

  @override
  List<Object?> get props => [
        id,
        colorId,
        notes,
        subject,
        location,
        recurrence,
        recurringEventId,
        startDateTime,
        startDate,
        endDateTime,
        endDate,
        organizer,
        timeZone,
      ];
}
