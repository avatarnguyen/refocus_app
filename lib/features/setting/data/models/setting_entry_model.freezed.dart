// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'setting_entry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SettingEntryModel _$SettingEntryModelFromJson(Map<String, dynamic> json) {
  return _SettingEntryModel.fromJson(json);
}

/// @nodoc
class _$SettingEntryModelTearOff {
  const _$SettingEntryModelTearOff();

  _SettingEntryModel call({required SettingEntry settingEntry}) {
    return _SettingEntryModel(
      settingEntry: settingEntry,
    );
  }

  SettingEntryModel fromJson(Map<String, Object> json) {
    return SettingEntryModel.fromJson(json);
  }
}

/// @nodoc
const $SettingEntryModel = _$SettingEntryModelTearOff();

/// @nodoc
mixin _$SettingEntryModel {
  SettingEntry get settingEntry => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SettingEntryModelCopyWith<SettingEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingEntryModelCopyWith<$Res> {
  factory $SettingEntryModelCopyWith(
          SettingEntryModel value, $Res Function(SettingEntryModel) then) =
      _$SettingEntryModelCopyWithImpl<$Res>;
  $Res call({SettingEntry settingEntry});

  $SettingEntryCopyWith<$Res> get settingEntry;
}

/// @nodoc
class _$SettingEntryModelCopyWithImpl<$Res>
    implements $SettingEntryModelCopyWith<$Res> {
  _$SettingEntryModelCopyWithImpl(this._value, this._then);

  final SettingEntryModel _value;
  // ignore: unused_field
  final $Res Function(SettingEntryModel) _then;

  @override
  $Res call({
    Object? settingEntry = freezed,
  }) {
    return _then(_value.copyWith(
      settingEntry: settingEntry == freezed
          ? _value.settingEntry
          : settingEntry // ignore: cast_nullable_to_non_nullable
              as SettingEntry,
    ));
  }

  @override
  $SettingEntryCopyWith<$Res> get settingEntry {
    return $SettingEntryCopyWith<$Res>(_value.settingEntry, (value) {
      return _then(_value.copyWith(settingEntry: value));
    });
  }
}

/// @nodoc
abstract class _$SettingEntryModelCopyWith<$Res>
    implements $SettingEntryModelCopyWith<$Res> {
  factory _$SettingEntryModelCopyWith(
          _SettingEntryModel value, $Res Function(_SettingEntryModel) then) =
      __$SettingEntryModelCopyWithImpl<$Res>;
  @override
  $Res call({SettingEntry settingEntry});

  @override
  $SettingEntryCopyWith<$Res> get settingEntry;
}

/// @nodoc
class __$SettingEntryModelCopyWithImpl<$Res>
    extends _$SettingEntryModelCopyWithImpl<$Res>
    implements _$SettingEntryModelCopyWith<$Res> {
  __$SettingEntryModelCopyWithImpl(
      _SettingEntryModel _value, $Res Function(_SettingEntryModel) _then)
      : super(_value, (v) => _then(v as _SettingEntryModel));

  @override
  _SettingEntryModel get _value => super._value as _SettingEntryModel;

  @override
  $Res call({
    Object? settingEntry = freezed,
  }) {
    return _then(_SettingEntryModel(
      settingEntry: settingEntry == freezed
          ? _value.settingEntry
          : settingEntry // ignore: cast_nullable_to_non_nullable
              as SettingEntry,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SettingEntryModel implements _SettingEntryModel {
  _$_SettingEntryModel({required this.settingEntry});

  factory _$_SettingEntryModel.fromJson(Map<String, dynamic> json) =>
      _$$_SettingEntryModelFromJson(json);

  @override
  final SettingEntry settingEntry;

  @override
  String toString() {
    return 'SettingEntryModel(settingEntry: $settingEntry)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SettingEntryModel &&
            (identical(other.settingEntry, settingEntry) ||
                const DeepCollectionEquality()
                    .equals(other.settingEntry, settingEntry)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(settingEntry);

  @JsonKey(ignore: true)
  @override
  _$SettingEntryModelCopyWith<_SettingEntryModel> get copyWith =>
      __$SettingEntryModelCopyWithImpl<_SettingEntryModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SettingEntryModelToJson(this);
  }
}

abstract class _SettingEntryModel implements SettingEntryModel {
  factory _SettingEntryModel({required SettingEntry settingEntry}) =
      _$_SettingEntryModel;

  factory _SettingEntryModel.fromJson(Map<String, dynamic> json) =
      _$_SettingEntryModel.fromJson;

  @override
  SettingEntry get settingEntry => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SettingEntryModelCopyWith<_SettingEntryModel> get copyWith =>
      throw _privateConstructorUsedError;
}
