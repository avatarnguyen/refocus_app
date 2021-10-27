import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

class DateSerialiser implements JsonConverter<DateTime?, String?> {
  const DateSerialiser();

  @override
  DateTime? fromJson(String? json) {
    return json != null ? DateTime.parse(json) : null;
  }

  @override
  String? toJson(DateTime? object) {
    return object != null ? DateFormat('yyyy-MM-dd').format(object) : null;
  }
}
