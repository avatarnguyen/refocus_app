import 'package:freezed_annotation/freezed_annotation.dart';

class DateTimeSerialiser implements JsonConverter<DateTime?, String?> {
  const DateTimeSerialiser();

  @override
  DateTime? fromJson(String? json) {
    return json != null ? DateTime.parse(json) : null;
  }

  @override
  String? toJson(DateTime? object) {
    return object?.toUtc().toIso8601String();
  }
}
