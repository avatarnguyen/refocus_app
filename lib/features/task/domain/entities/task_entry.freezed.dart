// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'task_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskEntry _$TaskEntryFromJson(Map<String, dynamic> json) {
  return _TaskEntry.fromJson(json);
}

/// @nodoc
class _$TaskEntryTearOff {
  const _$TaskEntryTearOff();

  _TaskEntry call(
      {required String id,
      required bool isCompleted,
      required String projectID,
      String? title,
      String? description,
      @DateTimeSerialiser() DateTime? dueDate,
      @ListDateTimeSerialiser() List<DateTime>? startDateTime,
      @ListDateTimeSerialiser() List<DateTime>? endDateTime,
      List<String>? recurrentDays,
      int? priority}) {
    return _TaskEntry(
      id: id,
      isCompleted: isCompleted,
      projectID: projectID,
      title: title,
      description: description,
      dueDate: dueDate,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      recurrentDays: recurrentDays,
      priority: priority,
    );
  }

  TaskEntry fromJson(Map<String, Object> json) {
    return TaskEntry.fromJson(json);
  }
}

/// @nodoc
const $TaskEntry = _$TaskEntryTearOff();

/// @nodoc
mixin _$TaskEntry {
  String get id => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String get projectID => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @DateTimeSerialiser()
  DateTime? get dueDate => throw _privateConstructorUsedError;
  @ListDateTimeSerialiser()
  List<DateTime>? get startDateTime => throw _privateConstructorUsedError;
  @ListDateTimeSerialiser()
  List<DateTime>? get endDateTime => throw _privateConstructorUsedError;
  List<String>? get recurrentDays => throw _privateConstructorUsedError;
  int? get priority => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskEntryCopyWith<TaskEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskEntryCopyWith<$Res> {
  factory $TaskEntryCopyWith(TaskEntry value, $Res Function(TaskEntry) then) =
      _$TaskEntryCopyWithImpl<$Res>;
  $Res call(
      {String id,
      bool isCompleted,
      String projectID,
      String? title,
      String? description,
      @DateTimeSerialiser() DateTime? dueDate,
      @ListDateTimeSerialiser() List<DateTime>? startDateTime,
      @ListDateTimeSerialiser() List<DateTime>? endDateTime,
      List<String>? recurrentDays,
      int? priority});
}

/// @nodoc
class _$TaskEntryCopyWithImpl<$Res> implements $TaskEntryCopyWith<$Res> {
  _$TaskEntryCopyWithImpl(this._value, this._then);

  final TaskEntry _value;
  // ignore: unused_field
  final $Res Function(TaskEntry) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? isCompleted = freezed,
    Object? projectID = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dueDate = freezed,
    Object? startDateTime = freezed,
    Object? endDateTime = freezed,
    Object? recurrentDays = freezed,
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
      projectID: projectID == freezed
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dueDate: dueDate == freezed
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDateTime: startDateTime == freezed
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      endDateTime: endDateTime == freezed
          ? _value.endDateTime
          : endDateTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      recurrentDays: recurrentDays == freezed
          ? _value.recurrentDays
          : recurrentDays // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      priority: priority == freezed
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
abstract class _$TaskEntryCopyWith<$Res> implements $TaskEntryCopyWith<$Res> {
  factory _$TaskEntryCopyWith(
          _TaskEntry value, $Res Function(_TaskEntry) then) =
      __$TaskEntryCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      bool isCompleted,
      String projectID,
      String? title,
      String? description,
      @DateTimeSerialiser() DateTime? dueDate,
      @ListDateTimeSerialiser() List<DateTime>? startDateTime,
      @ListDateTimeSerialiser() List<DateTime>? endDateTime,
      List<String>? recurrentDays,
      int? priority});
}

/// @nodoc
class __$TaskEntryCopyWithImpl<$Res> extends _$TaskEntryCopyWithImpl<$Res>
    implements _$TaskEntryCopyWith<$Res> {
  __$TaskEntryCopyWithImpl(_TaskEntry _value, $Res Function(_TaskEntry) _then)
      : super(_value, (v) => _then(v as _TaskEntry));

  @override
  _TaskEntry get _value => super._value as _TaskEntry;

  @override
  $Res call({
    Object? id = freezed,
    Object? isCompleted = freezed,
    Object? projectID = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dueDate = freezed,
    Object? startDateTime = freezed,
    Object? endDateTime = freezed,
    Object? recurrentDays = freezed,
    Object? priority = freezed,
  }) {
    return _then(_TaskEntry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      projectID: projectID == freezed
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      dueDate: dueDate == freezed
          ? _value.dueDate
          : dueDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDateTime: startDateTime == freezed
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      endDateTime: endDateTime == freezed
          ? _value.endDateTime
          : endDateTime // ignore: cast_nullable_to_non_nullable
              as List<DateTime>?,
      recurrentDays: recurrentDays == freezed
          ? _value.recurrentDays
          : recurrentDays // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      priority: priority == freezed
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskEntry implements _TaskEntry {
  _$_TaskEntry(
      {required this.id,
      required this.isCompleted,
      required this.projectID,
      this.title,
      this.description,
      @DateTimeSerialiser() this.dueDate,
      @ListDateTimeSerialiser() this.startDateTime,
      @ListDateTimeSerialiser() this.endDateTime,
      this.recurrentDays,
      this.priority});

  factory _$_TaskEntry.fromJson(Map<String, dynamic> json) =>
      _$$_TaskEntryFromJson(json);

  @override
  final String id;
  @override
  final bool isCompleted;
  @override
  final String projectID;
  @override
  final String? title;
  @override
  final String? description;
  @override
  @DateTimeSerialiser()
  final DateTime? dueDate;
  @override
  @ListDateTimeSerialiser()
  final List<DateTime>? startDateTime;
  @override
  @ListDateTimeSerialiser()
  final List<DateTime>? endDateTime;
  @override
  final List<String>? recurrentDays;
  @override
  final int? priority;

  @override
  String toString() {
    return 'TaskEntry(id: $id, isCompleted: $isCompleted, projectID: $projectID, title: $title, description: $description, dueDate: $dueDate, startDateTime: $startDateTime, endDateTime: $endDateTime, recurrentDays: $recurrentDays, priority: $priority)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _TaskEntry &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.isCompleted, isCompleted) ||
                const DeepCollectionEquality()
                    .equals(other.isCompleted, isCompleted)) &&
            (identical(other.projectID, projectID) ||
                const DeepCollectionEquality()
                    .equals(other.projectID, projectID)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.dueDate, dueDate) ||
                const DeepCollectionEquality()
                    .equals(other.dueDate, dueDate)) &&
            (identical(other.startDateTime, startDateTime) ||
                const DeepCollectionEquality()
                    .equals(other.startDateTime, startDateTime)) &&
            (identical(other.endDateTime, endDateTime) ||
                const DeepCollectionEquality()
                    .equals(other.endDateTime, endDateTime)) &&
            (identical(other.recurrentDays, recurrentDays) ||
                const DeepCollectionEquality()
                    .equals(other.recurrentDays, recurrentDays)) &&
            (identical(other.priority, priority) ||
                const DeepCollectionEquality()
                    .equals(other.priority, priority)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(isCompleted) ^
      const DeepCollectionEquality().hash(projectID) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(dueDate) ^
      const DeepCollectionEquality().hash(startDateTime) ^
      const DeepCollectionEquality().hash(endDateTime) ^
      const DeepCollectionEquality().hash(recurrentDays) ^
      const DeepCollectionEquality().hash(priority);

  @JsonKey(ignore: true)
  @override
  _$TaskEntryCopyWith<_TaskEntry> get copyWith =>
      __$TaskEntryCopyWithImpl<_TaskEntry>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskEntryToJson(this);
  }
}

abstract class _TaskEntry implements TaskEntry {
  factory _TaskEntry(
      {required String id,
      required bool isCompleted,
      required String projectID,
      String? title,
      String? description,
      @DateTimeSerialiser() DateTime? dueDate,
      @ListDateTimeSerialiser() List<DateTime>? startDateTime,
      @ListDateTimeSerialiser() List<DateTime>? endDateTime,
      List<String>? recurrentDays,
      int? priority}) = _$_TaskEntry;

  factory _TaskEntry.fromJson(Map<String, dynamic> json) =
      _$_TaskEntry.fromJson;

  @override
  String get id => throw _privateConstructorUsedError;
  @override
  bool get isCompleted => throw _privateConstructorUsedError;
  @override
  String get projectID => throw _privateConstructorUsedError;
  @override
  String? get title => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  @DateTimeSerialiser()
  DateTime? get dueDate => throw _privateConstructorUsedError;
  @override
  @ListDateTimeSerialiser()
  List<DateTime>? get startDateTime => throw _privateConstructorUsedError;
  @override
  @ListDateTimeSerialiser()
  List<DateTime>? get endDateTime => throw _privateConstructorUsedError;
  @override
  List<String>? get recurrentDays => throw _privateConstructorUsedError;
  @override
  int? get priority => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$TaskEntryCopyWith<_TaskEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
