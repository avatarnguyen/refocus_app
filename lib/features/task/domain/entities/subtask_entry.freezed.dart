// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'subtask_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubTaskEntry _$SubTaskEntryFromJson(Map<String, dynamic> json) {
  return _SubTaskEntry.fromJson(json);
}

/// @nodoc
class _$SubTaskEntryTearOff {
  const _$SubTaskEntryTearOff();

  _SubTaskEntry call(
      {required String id,
      required bool isCompleted,
      required String taskID,
      String? title,
      @DateSerialiser() DateTime? completedDate,
      int? priority}) {
    return _SubTaskEntry(
      id: id,
      isCompleted: isCompleted,
      taskID: taskID,
      title: title,
      completedDate: completedDate,
      priority: priority,
    );
  }

  SubTaskEntry fromJson(Map<String, Object> json) {
    return SubTaskEntry.fromJson(json);
  }
}

/// @nodoc
const $SubTaskEntry = _$SubTaskEntryTearOff();

/// @nodoc
mixin _$SubTaskEntry {
  String get id => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String get taskID => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  @DateSerialiser()
  DateTime? get completedDate => throw _privateConstructorUsedError;
  int? get priority => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubTaskEntryCopyWith<SubTaskEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubTaskEntryCopyWith<$Res> {
  factory $SubTaskEntryCopyWith(
          SubTaskEntry value, $Res Function(SubTaskEntry) then) =
      _$SubTaskEntryCopyWithImpl<$Res>;
  $Res call(
      {String id,
      bool isCompleted,
      String taskID,
      String? title,
      @DateSerialiser() DateTime? completedDate,
      int? priority});
}

/// @nodoc
class _$SubTaskEntryCopyWithImpl<$Res> implements $SubTaskEntryCopyWith<$Res> {
  _$SubTaskEntryCopyWithImpl(this._value, this._then);

  final SubTaskEntry _value;
  // ignore: unused_field
  final $Res Function(SubTaskEntry) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? isCompleted = freezed,
    Object? taskID = freezed,
    Object? title = freezed,
    Object? completedDate = freezed,
    Object? priority = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      taskID: taskID == freezed
          ? _value.taskID
          : taskID // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      completedDate: completedDate == freezed
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: priority == freezed
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$SubTaskEntryCopyWith<$Res>
    implements $SubTaskEntryCopyWith<$Res> {
  factory _$SubTaskEntryCopyWith(
          _SubTaskEntry value, $Res Function(_SubTaskEntry) then) =
      __$SubTaskEntryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      bool isCompleted,
      String taskID,
      String? title,
      @DateSerialiser() DateTime? completedDate,
      int? priority});
}

/// @nodoc
class __$SubTaskEntryCopyWithImpl<$Res> extends _$SubTaskEntryCopyWithImpl<$Res>
    implements _$SubTaskEntryCopyWith<$Res> {
  __$SubTaskEntryCopyWithImpl(
      _SubTaskEntry _value, $Res Function(_SubTaskEntry) _then)
      : super(_value, (v) => _then(v as _SubTaskEntry));

  @override
  _SubTaskEntry get _value => super._value as _SubTaskEntry;

  @override
  $Res call({
    Object? id = freezed,
    Object? isCompleted = freezed,
    Object? taskID = freezed,
    Object? title = freezed,
    Object? completedDate = freezed,
    Object? priority = freezed,
  }) {
    return _then(_SubTaskEntry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      taskID: taskID == freezed
          ? _value.taskID
          : taskID // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      completedDate: completedDate == freezed
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: priority == freezed
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubTaskEntry implements _SubTaskEntry {
  _$_SubTaskEntry(
      {required this.id,
      required this.isCompleted,
      required this.taskID,
      this.title,
      @DateSerialiser() this.completedDate,
      this.priority});

  factory _$_SubTaskEntry.fromJson(Map<String, dynamic> json) =>
      _$$_SubTaskEntryFromJson(json);

  @override
  final String id;
  @override
  final bool isCompleted;
  @override
  final String taskID;
  @override
  final String? title;
  @override
  @DateSerialiser()
  final DateTime? completedDate;
  @override
  final int? priority;

  @override
  String toString() {
    return 'SubTaskEntry(id: $id, isCompleted: $isCompleted, taskID: $taskID, title: $title, completedDate: $completedDate, priority: $priority)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SubTaskEntry &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)) &&
            (identical(other.taskID, taskID) ||
                const DeepCollectionEquality().equals(other.taskID, taskID)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.completedDate, completedDate) ||
                const DeepCollectionEquality()
                    .equals(other.completedDate, completedDate)) &&
            (identical(other.priority, priority) ||
                const DeepCollectionEquality()
                    .equals(other.priority, priority)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isCompleted) ^
      const DeepCollectionEquality().hash(taskID) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(completedDate) ^
      const DeepCollectionEquality().hash(priority);

  @JsonKey(ignore: true)
  @override
  _$SubTaskEntryCopyWith<_SubTaskEntry> get copyWith =>
      __$SubTaskEntryCopyWithImpl<_SubTaskEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubTaskEntryToJson(this);
  }
}

abstract class _SubTaskEntry implements SubTaskEntry {
  factory _SubTaskEntry(
      {required String id,
      required bool isCompleted,
      required String taskID,
      String? title,
      @DateSerialiser() DateTime? completedDate,
      int? priority}) = _$_SubTaskEntry;

  factory _SubTaskEntry.fromJson(Map<String, dynamic> json) =
      _$_SubTaskEntry.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  bool get isCompleted => throw _privateConstructorUsedError;
  @override
  String get taskID => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  @DateSerialiser()
  DateTime? get completedDate => throw _privateConstructorUsedError;
  @override
  int? get priority => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SubTaskEntryCopyWith<_SubTaskEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
