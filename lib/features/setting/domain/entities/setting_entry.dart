import 'package:freezed_annotation/freezed_annotation.dart';

part 'setting_entry.freezed.dart';
part 'setting_entry.g.dart';

@freezed
class SettingEntry with _$SettingEntry {
  factory SettingEntry({
    required String id,
    String? data,
  }) = _SettingEntry;

  factory SettingEntry.fromJson(Map<String, dynamic> json) =>
      _$SettingEntryFromJson(json);
}
