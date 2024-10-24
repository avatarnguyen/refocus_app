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
      bool? isCompleted,
      String? projectID,
      String? calendarID,
      String? colorID,
      String? title,
      String? description,
      @DateSerialiser() DateTime? dueDate,
      @DateSerialiser() DateTime? completedDate,
      @DateTimeSerialiser() DateTime? startDateTime,
      @DateTimeSerialiser() DateTime? endDateTime,
      int? priority,
      bool? isHabit}) {
    return _TaskEntry(
      id: id,
      isCompleted: isCompleted,
      projectID: projectID,
      calendarID: calendarID,
      colorID: colorID,
      title: title,
      description: description,
      dueDate: dueDate,
      completedDate: completedDate,
      startDateTime: startDateTime,
      endDateTime: endDateTime,
      priority: priority,
      isHabit: isHabit,
    );
  }

  TaskEntry fromJson(Map<String, Object?> json) {
    return TaskEntry.fromJson(json);
  }
}

/// @nodoc
const $TaskEntry = _$TaskEntryTearOff();

/// @nodoc
mixin _$TaskEntry {
  String get id => throw _privateConstructorUsedError;
  bool? get isCompleted => throw _privateConstructorUsedError;
  String? get projectID => throw _privateConstructorUsedError;
  String? get calendarID => throw _privateConstructorUsedError;
  String? get colorID => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @DateSerialiser()
  DateTime? get dueDate => throw _privateConstructorUsedError;
  @DateSerialiser()
  DateTime? get completedDate => throw _privateConstructorUsedError;
  @DateTimeSerialiser()
  DateTime? get startDateTime => throw _privateConstructorUsedError;
  @DateTimeSerialiser()
  DateTime? get endDateTime => throw _privateConstructorUsedError;
  int? get priority => throw _privateConstructorUsedError;
  bool? get isHabit => throw _privateConstructorUsedError;

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
      bool? isCompleted,
      String? projectID,
      String? calendarID,
      String? colorID,
      String? title,
      String? description,
      @DateSerialiser() DateTime? dueDate,
      @DateSerialiser() DateTime? completedDate,
      @DateTimeSerialiser() DateTime? startDateTime,
      @DateTimeSerialiser() DateTime? endDateTime,
      int? priority,
      bool? isHabit});
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
    Object? calendarID = freezed,
    Object? colorID = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dueDate = freezed,
    Object? completedDate = freezed,
    Object? startDateTime = freezed,
    Object? endDateTime = freezed,
    Object? priority = freezed,
    Object? isHabit = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      projectID: projectID == freezed
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarID: calendarID == freezed
          ? _value.calendarID
          : calendarID // ignore: cast_nullable_to_non_nullable
              as String?,
      colorID: colorID == freezed
          ? _value.colorID
          : colorID // ignore: cast_nullable_to_non_nullable
              as String?,
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
      completedDate: completedDate == freezed
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDateTime: startDateTime == freezed
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDateTime: endDateTime == freezed
          ? _value.endDateTime
          : endDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: priority == freezed
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      isHabit: isHabit == freezed
          ? _value.isHabit
          : isHabit // ignore: cast_nullable_to_non_nullable
              as bool?,
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
      bool? isCompleted,
      String? projectID,
      String? calendarID,
      String? colorID,
      String? title,
      String? description,
      @DateSerialiser() DateTime? dueDate,
      @DateSerialiser() DateTime? completedDate,
      @DateTimeSerialiser() DateTime? startDateTime,
      @DateTimeSerialiser() DateTime? endDateTime,
      int? priority,
      bool? isHabit});
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
    Object? calendarID = freezed,
    Object? colorID = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dueDate = freezed,
    Object? completedDate = freezed,
    Object? startDateTime = freezed,
    Object? endDateTime = freezed,
    Object? priority = freezed,
    Object? isHabit = freezed,
  }) {
    return _then(_TaskEntry(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: isCompleted == freezed
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool?,
      projectID: projectID == freezed
          ? _value.projectID
          : projectID // ignore: cast_nullable_to_non_nullable
              as String?,
      calendarID: calendarID == freezed
          ? _value.calendarID
          : calendarID // ignore: cast_nullable_to_non_nullable
              as String?,
      colorID: colorID == freezed
          ? _value.colorID
          : colorID // ignore: cast_nullable_to_non_nullable
              as String?,
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
      completedDate: completedDate == freezed
          ? _value.completedDate
          : completedDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      startDateTime: startDateTime == freezed
          ? _value.startDateTime
          : startDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endDateTime: endDateTime == freezed
          ? _value.endDateTime
          : endDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      priority: priority == freezed
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      isHabit: isHabit == freezed
          ? _value.isHabit
          : isHabit // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskEntry implements _TaskEntry {
  _$_TaskEntry(
      {required this.id,
      this.isCompleted,
      this.projectID,
      this.calendarID,
      this.colorID,
      this.title,
      this.description,
      @DateSerialiser() this.dueDate,
      @DateSerialiser() this.completedDate,
      @DateTimeSerialiser() this.startDateTime,
      @DateTimeSerialiser() this.endDateTime,
      this.priority,
      this.isHabit});

  factory _$_TaskEntry.fromJson(Map<String, dynamic> json) =>
      _$$_TaskEntryFromJson(json);

  @override
  final String id;
  @override
  final bool? isCompleted;
  @override
  final String? projectID;
  @override
  final String? calendarID;
  @override
  final String? colorID;
  @override
  final String? title;
  @override
  final String? description;
  @override
  @DateSerialiser()
  final DateTime? dueDate;
  @override
  @DateSerialiser()
  final DateTime? completedDate;
  @override
  @DateTimeSerialiser()
  final DateTime? startDateTime;
  @override
  @DateTimeSerialiser()
  final DateTime? endDateTime;
  @override
  final int? priority;
  @override
  final bool? isHabit;

  @override
  String toString() {
    return 'TaskEntry(id: $id, isCompleted: $isCompleted, projectID: $projectID, calendarID: $calendarID, colorID: $colorID, title: $title, description: $description, dueDate: $dueDate, completedDate: $completedDate, startDateTime: $startDateTime, endDateTime: $endDateTime, priority: $priority, isHabit: $isHabit)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TaskEntry &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.isCompleted, isCompleted) &&
            const DeepCollectionEquality().equals(other.projectID, projectID) &&
            const DeepCollectionEquality()
                .equals(other.calendarID, calendarID) &&
            const DeepCollectionEquality().equals(other.colorID, colorID) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.dueDate, dueDate) &&
            const DeepCollectionEquality()
                .equals(other.completedDate, completedDate) &&
            const DeepCollectionEquality()
                .equals(other.startDateTime, startDateTime) &&
            const DeepCollectionEquality()
                .equals(other.endDateTime, endDateTime) &&
            const DeepCollectionEquality().equals(other.priority, priority) &&
            const DeepCollectionEquality().equals(other.isHabit, isHabit));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(isCompleted),
      const DeepCollectionEquality().hash(projectID),
      const DeepCollectionEquality().hash(calendarID),
      const DeepCollectionEquality().hash(colorID),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(dueDate),
      const DeepCollectionEquality().hash(completedDate),
      const DeepCollectionEquality().hash(startDateTime),
      const DeepCollectionEquality().hash(endDateTime),
      const DeepCollectionEquality().hash(priority),
      const DeepCollectionEquality().hash(isHabit));

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
      bool? isCompleted,
      String? projectID,
      String? calendarID,
      String? colorID,
      String? title,
      String? description,
      @DateSerialiser() DateTime? dueDate,
      @DateSerialiser() DateTime? completedDate,
      @DateTimeSerialiser() DateTime? startDateTime,
      @DateTimeSerialiser() DateTime? endDateTime,
      int? priority,
      bool? isHabit}) = _$_TaskEntry;

  factory _TaskEntry.fromJson(Map<String, dynamic> json) =
      _$_TaskEntry.fromJson;

  @override
  String get id;
  @override
  bool? get isCompleted;
  @override
  String? get projectID;
  @override
  String? get calendarID;
  @override
  String? get colorID;
  @override
  String? get title;
  @override
  String? get description;
  @override
  @DateSerialiser()
  DateTime? get dueDate;
  @override
  @DateSerialiser()
  DateTime? get completedDate;
  @override
  @DateTimeSerialiser()
  DateTime? get startDateTime;
  @override
  @DateTimeSerialiser()
  DateTime? get endDateTime;
  @override
  int? get priority;
  @override
  bool? get isHabit;
  @override
  @JsonKey(ignore: true)
  _$TaskEntryCopyWith<_TaskEntry> get copyWith =>
      throw _privateConstructorUsedError;
}
