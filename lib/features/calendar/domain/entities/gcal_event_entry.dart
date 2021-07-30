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
    this.start,
    this.end,
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
  final DateTime? start;
  final DateTime? end;
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
        start,
        end,
        organizer,
        timeZone,
      ];
}
