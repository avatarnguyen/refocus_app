import 'package:equatable/equatable.dart';

import 'package:hive/hive.dart';

part 'calendar_entry.g.dart';

@HiveType(typeId: 2)
class CalendarEntry extends Equatable {
  const CalendarEntry({
    required this.id,
    required this.name,
    this.accountName,
    this.color,
    this.isDefault,
    this.selected,
    this.timeZone,
  });

  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String? color;
  @HiveField(3)
  final bool? isDefault;
  @HiveField(4)
  final String? accountName;
  @HiveField(5)
  final bool? selected;
  @HiveField(6)
  final String? timeZone;

  @override
  List<Object?> get props => [
        id,
        name,
        color,
        isDefault,
        accountName,
        selected,
        timeZone,
      ];

  // ignore: sort_constructors_first
  factory CalendarEntry.fromJson(Map<String, dynamic> json) {
    return CalendarEntry(
      id: json['id'],
      name: json['summary'] ?? '',
      accountName: json.containsKey('accountName') ? json['accountName'] : null,
      color: json.containsKey('colorId')
          ? json['colorId']
              ? json.containsKey('color')
                  ? (json['color'] as int).toString()
                  : null
              : null
          : null,
      isDefault: json.containsKey('primary')
          ? json['primary']
              ? json.containsKey('isDefault')
                  ? json['isDefault']
                  : null
              : null
          : null,
      selected: json.containsKey('selected') ? json['selected'] : null,
      timeZone: json.containsKey('timeZone') ? json['timeZone'] : null,
    );
  }

  Map<String, dynamic> toGCalJson() => {
        'id': id,
        'summary': name,
        if (color != null) 'colorId': color,
        if (isDefault != null) 'primary': isDefault,
        if (selected != null) 'selected': selected,
        if (timeZone != null) 'timeZone': timeZone,
      };
}