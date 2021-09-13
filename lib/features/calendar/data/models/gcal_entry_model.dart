import 'package:refocus_app/features/calendar/domain/entities/calendar_entry.dart';

// ignore_for_file: implicit_dynamic_map_literal
class GCalEntryModel extends CalendarEntry {
  const GCalEntryModel({
    required String id,
    required String summary,
    String? color,
    bool? primary,
    bool? selected,
    String? timeZone,
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
      id: json['id'] as String,
      summary: json['summary'] as String? ?? '',
      color: json['backgroundColor'] as String? ?? json['color'] as String?,
      primary: json['primary'] as bool?,
      selected: json['selected'] as bool? ?? true,
      timeZone: json['timeZone'] as String?,
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
