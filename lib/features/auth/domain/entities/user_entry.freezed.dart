// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserEntry _$UserEntryFromJson(Map<String, dynamic> json) {
  return _UserEntry.fromJson(json);
}

/// @nodoc
class _$UserEntryTearOff {
  const _$UserEntryTearOff();

  _UserEntry call(
      {required String id,
      String? username,
      String? email,
      String? avatarKey}) {
    return _UserEntry(
      id: id,
      username: username,
      email: email,
      avatarKey: avatarKey,
    );
  }

  UserEntry fromJson(Map<String, Object> json) {
    return UserEntry.fromJson(json);
  }
}

/// @nodoc
const $UserEntry = _$UserEntryTearOff();

/// @nodoc
mixin _$UserEntry {
  String get id => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get avatarKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserEntryCopyWith<UserEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEntryCopyWith<$Res> {
  factory $UserEntryCopyWith(UserEntry value, $Res Function(UserEntry) then) =
      _$UserEntryCopyWithImpl<$Res>;
  $Res call({String id, String? username, String? email, String? avatarKey});
}

/// @nodoc
class _$UserEntryCopyWithImpl<$Res> implements $UserEntryCopyWith<$Res> {
  _$UserEntryCopyWithImpl(this._value, this._then);

  final UserEntry _value;
  // ignore: unused_field
  final $Res Function(UserEntry) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? avatarKey = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarKey: avatarKey == freezed
          ? _value.avatarKey
          : avatarKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$UserEntryCopyWith<$Res> implements $UserEntryCopyWith<$Res> {
  factory _$UserEntryCopyWith(
          _UserEntry value, $Res Function(_UserEntry) then) =
      __$UserEntryCopyWithImpl<$Res>;
  @override
  $Res call({String id, String? username, String? email, String? avatarKey});
}

/// @nodoc
class __$UserEntryCopyWithImpl<$Res> extends _$UserEntryCopyWithImpl<$Res>
    implements _$UserEntryCopyWith<$Res> {
  __$UserEntryCopyWithImpl(_UserEntry _value, $Res Function(_UserEntry) _then)
      : super(_value, (v) => _then(v as _UserEntry));

  @override
  _UserEntry get _value => super._value as _UserEntry;

  @override
  $Res call({
    Object? id = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? avatarKey = freezed,
  }) {
    return _then(_UserEntry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      avatarKey: avatarKey == freezed
          ? _value.avatarKey
          : avatarKey // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserEntry implements _UserEntry {
  _$_UserEntry({required this.id, this.username, this.email, this.avatarKey});

  factory _$_UserEntry.fromJson(Map<String, dynamic> json) =>
      _$$_UserEntryFromJson(json);

  @override
  final String id;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? avatarKey;

  @override
  String toString() {
    return 'UserEntry(id: $id, username: $username, email: $email, avatarKey: $avatarKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserEntry &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.avatarKey, avatarKey) ||
                const DeepCollectionEquality()
                    .equals(other.avatarKey, avatarKey)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(avatarKey);

  @JsonKey(ignore: true)
  @override
  _$UserEntryCopyWith<_UserEntry> get copyWith =>
      __$UserEntryCopyWithImpl<_UserEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserEntryToJson(this);
  }
}

abstract class _UserEntry implements UserEntry {
  factory _UserEntry(
      {required String id,
      String? username,
      String? email,
      String? avatarKey}) = _$_UserEntry;

  factory _UserEntry.fromJson(Map<String, dynamic> json) =
      _$_UserEntry.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String? get username => throw _privateConstructorUsedError;
  @override
  String? get email => throw _privateConstructorUsedError;
  @override
  String? get avatarKey => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$UserEntryCopyWith<_UserEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
