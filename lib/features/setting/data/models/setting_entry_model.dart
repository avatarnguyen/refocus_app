import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:refocus_app/features/setting/domain/entities/setting_entry.dart';

part 'setting_entry_model.freezed.dart';
part 'setting_entry_model.g.dart';

// Issue: https://github.com/rrousselGit/freezed/issues/464

@freezed
class SettingEntryModel with _$SettingEntryModel {
  factory SettingEntryModel({
    required SettingEntry settingEntry,
  }) = _SettingEntryModel;

  factory SettingEntryModel.fromJson(Map<String, dynamic> json) =>
      _$SettingEntryModelFromJson(json);
}
