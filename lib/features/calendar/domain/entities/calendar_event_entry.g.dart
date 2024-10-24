// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_event_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarEventEntryAdapter extends TypeAdapter<CalendarEventEntry> {
  @override
  final int typeId = 1;

  @override
  CalendarEventEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarEventEntry(
      subject: fields[0] as String,
      id: fields[1] as String?,
      calendarId: fields[2] as String?,
      colorId: fields[3] as String?,
      notes: fields[4] as String?,
      location: fields[5] as String?,
      recurrence: (fields[6] as List?)?.cast<String>(),
      recurringEventId: fields[7] as String?,
      startDateTime: fields[8] as DateTime?,
      startDate: fields[9] as DateTime?,
      endDateTime: fields[10] as DateTime?,
      endDate: fields[11] as DateTime?,
      allDay: fields[12] as bool?,
      organizer: fields[13] as String?,
      timeZone: fields[14] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarEventEntry obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.calendarId)
      ..writeByte(3)
      ..write(obj.colorId)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.recurrence)
      ..writeByte(7)
      ..write(obj.recurringEventId)
      ..writeByte(8)
      ..write(obj.startDateTime)
      ..writeByte(9)
      ..write(obj.startDate)
      ..writeByte(10)
      ..write(obj.endDateTime)
      ..writeByte(11)
      ..write(obj.endDate)
      ..writeByte(12)
      ..write(obj.allDay)
      ..writeByte(13)
      ..write(obj.organizer)
      ..writeByte(14)
      ..write(obj.timeZone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEventEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
