import 'package:equatable/equatable.dart';
import 'package:googleapis/calendar/v3.dart' as google_api;

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
  });

  final String id;
  final String subject; // Event summary
  final String? colorId;
  final String? notes; // Event description
  final String? location;
  final List<String>? recurrence;
  final String? recurringEventId;
  final Map<String, dynamic>? start;
  final Map<String, dynamic>? end;

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
        end
      ];
}
