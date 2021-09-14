import 'package:freezed_annotation/freezed_annotation.dart';

class ListDateTimeSerialiser
    implements JsonConverter<List<DateTime>?, List<String>?> {
  const ListDateTimeSerialiser();

  @override
  List<DateTime>? fromJson(List<String>? json) {
    return json != null ? json.map(DateTime.parse).toList() : [];
  }

  @override
  List<String>? toJson(List<DateTime>? object) {
    return object != null
        ? object.map((e) => e.toUtc().toIso8601String()).toList()
        : [];
  }
}
