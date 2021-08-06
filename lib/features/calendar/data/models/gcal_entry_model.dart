import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';

class GCalEntryModel extends CalendarEntry {
  const GCalEntryModel({
    required id,
    required summary,
    colorId,
    primary,
    selected,
    timeZone,
  }) : super(
          id: id,
          name: summary,
          color: colorId,
          isDefault: primary,
          selected: selected,
          timeZone: timeZone,
        );

  factory GCalEntryModel.fromJson(Map<String, dynamic> json) {
    return GCalEntryModel(
      id: json['id'],
      summary: json['summary'] ?? '',
      colorId: json['colorId'],
      primary: json['primary'],
      selected: json['selected'],
      timeZone: json['timeZone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'summary': name,
        if (color != null) 'colorId': color,
        if (isDefault != null) 'primary': isDefault,
        if (selected != null) 'selected': selected,
        if (timeZone != null) 'timeZone': timeZone,
      };
}
