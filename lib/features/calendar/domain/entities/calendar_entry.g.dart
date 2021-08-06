// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarEntryAdapter extends TypeAdapter<CalendarEntry> {
  @override
  final int typeId = 2;

  @override
  CalendarEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarEntry(
      id: fields[0] as String,
      name: fields[1] as String,
      accountName: fields[4] as String?,
      color: fields[2] as String?,
      isDefault: fields[3] as bool?,
      selected: fields[5] as bool?,
      timeZone: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarEntry obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.isDefault)
      ..writeByte(4)
      ..write(obj.accountName)
      ..writeByte(5)
      ..write(obj.selected)
      ..writeByte(6)
      ..write(obj.timeZone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
