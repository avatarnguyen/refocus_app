import 'package:refocus_app/features/google_calendar/domain/entities/google_calendar_entry.dart';

class GoogleCalendarEntryModel extends GoogleCalendarEntry {
  const GoogleCalendarEntryModel({
    required String summary,
  }) : super(summary: summary);

  factory GoogleCalendarEntryModel.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List;
    final currentItem = items[0] as Map<String, dynamic>;
    return GoogleCalendarEntryModel(
      summary: currentItem['summary'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': [
        {'summary': summary}
      ]
    };
  }
}
