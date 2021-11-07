import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entry.freezed.dart';
part 'user_entry.g.dart';

@freezed
class UserEntry with _$UserEntry {
  factory UserEntry({
    required String id,
    String? username,
    String? email,
    String? avatarKey,
  }) = _UserEntry;

  factory UserEntry.fromJson(Map<String, dynamic> json) =>
      _$UserEntryFromJson(json);
}
