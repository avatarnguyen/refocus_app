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

  Map<String, dynamic> toGCalJson() => <String, dynamic>{
        'id': id,
        'summary': name,
        if (color != null) 'color': color,
        if (isDefault != null) 'primary': isDefault,
        if (selected != null) 'selected': selected,
        if (timeZone != null) 'timeZone': timeZone,
      };

  CalendarEntry copyWith({
    String? id,
    String? name,
    String? color,
    bool? isDefault,
    String? accountName,
    bool? selected,
    String? timeZone,
  }) {
    return CalendarEntry(
      id: id ?? this.id,
      name: name ?? this.name,
      color: color ?? this.color,
      isDefault: isDefault ?? this.isDefault,
      accountName: accountName ?? this.accountName,
      selected: selected ?? this.selected,
      timeZone: timeZone ?? this.timeZone,
    );
  }
}
