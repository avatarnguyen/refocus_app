// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'setting_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingEntry _$SettingEntryFromJson(Map<String, dynamic> json) {
  return _SettingEntry.fromJson(json);
}

/// @nodoc
class _$SettingEntryTearOff {
  const _$SettingEntryTearOff();

  _SettingEntry call({required String id, String? data}) {
    return _SettingEntry(
      id: id,
      data: data,
    );
  }

  SettingEntry fromJson(Map<String, Object> json) {
    return SettingEntry.fromJson(json);
  }
}

/// @nodoc
const $SettingEntry = _$SettingEntryTearOff();

/// @nodoc
mixin _$SettingEntry {
  String get id => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingEntryCopyWith<SettingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingEntryCopyWith<$Res> {
  factory $SettingEntryCopyWith(
          SettingEntry value, $Res Function(SettingEntry) then) =
      _$SettingEntryCopyWithImpl<$Res>;
  $Res call({String id, String? data});
}

/// @nodoc
class _$SettingEntryCopyWithImpl<$Res> implements $SettingEntryCopyWith<$Res> {
  _$SettingEntryCopyWithImpl(this._value, this._then);

  final SettingEntry _value;
  // ignore: unused_field
  final $Res Function(SettingEntry) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$SettingEntryCopyWith<$Res>
    implements $SettingEntryCopyWith<$Res> {
  factory _$SettingEntryCopyWith(
          _SettingEntry value, $Res Function(_SettingEntry) then) =
      __$SettingEntryCopyWithImpl<$Res>;
  @override
  $Res call({String id, String? data});
}

/// @nodoc
class __$SettingEntryCopyWithImpl<$Res> extends _$SettingEntryCopyWithImpl<$Res>
    implements _$SettingEntryCopyWith<$Res> {
  __$SettingEntryCopyWithImpl(
      _SettingEntry _value, $Res Function(_SettingEntry) _then)
      : super(_value, (v) => _then(v as _SettingEntry));

  @override
  _SettingEntry get _value => super._value as _SettingEntry;

  @override
  $Res call({
    Object? id = freezed,
    Object? data = freezed,
  }) {
    return _then(_SettingEntry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SettingEntry implements _SettingEntry {
  _$_SettingEntry({required this.id, this.data});

  factory _$_SettingEntry.fromJson(Map<String, dynamic> json) =>
      _$$_SettingEntryFromJson(json);

  @override
  final String id;
  @override
  final String? data;

  @override
  String toString() {
    return 'SettingEntry(id: $id, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SettingEntry &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  _$SettingEntryCopyWith<_SettingEntry> get copyWith =>
      __$SettingEntryCopyWithImpl<_SettingEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingEntryToJson(this);
  }
}

abstract class _SettingEntry implements SettingEntry {
  factory _SettingEntry({required String id, String? data}) = _$_SettingEntry;

  factory _SettingEntry.fromJson(Map<String, dynamic> json) =
      _$_SettingEntry.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  String? get data => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SettingEntryCopyWith<_SettingEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
