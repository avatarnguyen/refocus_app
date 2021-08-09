import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';

class GCalEntryModel extends CalendarEntry {
  const GCalEntryModel({
    required id,
    required summary,
    color,
    primary,
    selected,
    timeZone,
  }) : super(
          id: id,
          name: summary,
          color: color,
          isDefault: primary,
          selected: selected,
          timeZone: timeZone,
        );

  factory GCalEntryModel.fromJson(Map<String, dynamic> json) {
    return GCalEntryModel(
      id: json['id'],
      summary: json['summary'] ?? '',
      color: json['backgroundColor'] ?? json['color'],
      primary: json['primary'],
      selected: json['selected'] ?? true,
      timeZone: json['timeZone'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'summary': name,
        if (color != null) 'color': color,
        if (isDefault != null) 'primary': isDefault,
        'selected': selected ?? true,
        if (timeZone != null) 'timeZone': timeZone,
      };
}
