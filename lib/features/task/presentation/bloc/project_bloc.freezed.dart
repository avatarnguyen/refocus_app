// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'project_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ProjectEventTearOff {
  const _$ProjectEventTearOff();

  _ProjectGetEvent get() {
    return const _ProjectGetEvent();
  }

  _ProjectCreateEvent create({required ProjectParams project}) {
    return _ProjectCreateEvent(
      project: project,
    );
  }

  _ProjectUpdateEvent update({required ProjectParams project}) {
    return _ProjectUpdateEvent(
      project: project,
    );
  }

  _ProjectDeleteEvent delete({required ProjectParams project}) {
    return _ProjectDeleteEvent(
      project: project,
    );
  }
}

/// @nodoc
const $ProjectEvent = _$ProjectEventTearOff();

/// @nodoc
mixin _$ProjectEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function(ProjectParams project) create,
    required TResult Function(ProjectParams project) update,
    required TResult Function(ProjectParams project) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectGetEvent value) get,
    required TResult Function(_ProjectCreateEvent value) create,
    required TResult Function(_ProjectUpdateEvent value) update,
    required TResult Function(_ProjectDeleteEvent value) delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectEventCopyWith<$Res> {
  factory $ProjectEventCopyWith(
          ProjectEvent value, $Res Function(ProjectEvent) then) =
      _$ProjectEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProjectEventCopyWithImpl<$Res> implements $ProjectEventCopyWith<$Res> {
  _$ProjectEventCopyWithImpl(this._value, this._then);

  final ProjectEvent _value;
  // ignore: unused_field
  final $Res Function(ProjectEvent) _then;
}

/// @nodoc
abstract class _$ProjectGetEventCopyWith<$Res> {
  factory _$ProjectGetEventCopyWith(
          _ProjectGetEvent value, $Res Function(_ProjectGetEvent) then) =
      __$ProjectGetEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$ProjectGetEventCopyWithImpl<$Res>
    extends _$ProjectEventCopyWithImpl<$Res>
    implements _$ProjectGetEventCopyWith<$Res> {
  __$ProjectGetEventCopyWithImpl(
      _ProjectGetEvent _value, $Res Function(_ProjectGetEvent) _then)
      : super(_value, (v) => _then(v as _ProjectGetEvent));

  @override
  _ProjectGetEvent get _value => super._value as _ProjectGetEvent;
}

/// @nodoc

class _$_ProjectGetEvent implements _ProjectGetEvent {
  const _$_ProjectGetEvent();

  @override
  String toString() {
    return 'ProjectEvent.get()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ProjectGetEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function(ProjectParams project) create,
    required TResult Function(ProjectParams project) update,
    required TResult Function(ProjectParams project) delete,
  }) {
    return get();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
  }) {
    return get?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
    required TResult orElse(),
  }) {
    if (get != null) {
      return get();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectGetEvent value) get,
    required TResult Function(_ProjectCreateEvent value) create,
    required TResult Function(_ProjectUpdateEvent value) update,
    required TResult Function(_ProjectDeleteEvent value) delete,
  }) {
    return get(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
  }) {
    return get?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (get != null) {
      return get(this);
    }
    return orElse();
  }
}

abstract class _ProjectGetEvent implements ProjectEvent {
  const factory _ProjectGetEvent() = _$_ProjectGetEvent;
}

/// @nodoc
abstract class _$ProjectCreateEventCopyWith<$Res> {
  factory _$ProjectCreateEventCopyWith(
          _ProjectCreateEvent value, $Res Function(_ProjectCreateEvent) then) =
      __$ProjectCreateEventCopyWithImpl<$Res>;
  $Res call({ProjectParams project});
}

/// @nodoc
class __$ProjectCreateEventCopyWithImpl<$Res>
    extends _$ProjectEventCopyWithImpl<$Res>
    implements _$ProjectCreateEventCopyWith<$Res> {
  __$ProjectCreateEventCopyWithImpl(
      _ProjectCreateEvent _value, $Res Function(_ProjectCreateEvent) _then)
      : super(_value, (v) => _then(v as _ProjectCreateEvent));

  @override
  _ProjectCreateEvent get _value => super._value as _ProjectCreateEvent;

  @override
  $Res call({
    Object? project = freezed,
  }) {
    return _then(_ProjectCreateEvent(
      project: project == freezed
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectParams,
    ));
  }
}

/// @nodoc

class _$_ProjectCreateEvent implements _ProjectCreateEvent {
  const _$_ProjectCreateEvent({required this.project});

  @override
  final ProjectParams project;

  @override
  String toString() {
    return 'ProjectEvent.create(project: $project)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectCreateEvent &&
            const DeepCollectionEquality().equals(other.project, project));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(project));

  @JsonKey(ignore: true)
  @override
  _$ProjectCreateEventCopyWith<_ProjectCreateEvent> get copyWith =>
      __$ProjectCreateEventCopyWithImpl<_ProjectCreateEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function(ProjectParams project) create,
    required TResult Function(ProjectParams project) update,
    required TResult Function(ProjectParams project) delete,
  }) {
    return create(project);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
  }) {
    return create?.call(project);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(project);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectGetEvent value) get,
    required TResult Function(_ProjectCreateEvent value) create,
    required TResult Function(_ProjectUpdateEvent value) update,
    required TResult Function(_ProjectDeleteEvent value) delete,
  }) {
    return create(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
  }) {
    return create?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (create != null) {
      return create(this);
    }
    return orElse();
  }
}

abstract class _ProjectCreateEvent implements ProjectEvent {
  const factory _ProjectCreateEvent({required ProjectParams project}) =
      _$_ProjectCreateEvent;

  ProjectParams get project;
  @JsonKey(ignore: true)
  _$ProjectCreateEventCopyWith<_ProjectCreateEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ProjectUpdateEventCopyWith<$Res> {
  factory _$ProjectUpdateEventCopyWith(
          _ProjectUpdateEvent value, $Res Function(_ProjectUpdateEvent) then) =
      __$ProjectUpdateEventCopyWithImpl<$Res>;
  $Res call({ProjectParams project});
}

/// @nodoc
class __$ProjectUpdateEventCopyWithImpl<$Res>
    extends _$ProjectEventCopyWithImpl<$Res>
    implements _$ProjectUpdateEventCopyWith<$Res> {
  __$ProjectUpdateEventCopyWithImpl(
      _ProjectUpdateEvent _value, $Res Function(_ProjectUpdateEvent) _then)
      : super(_value, (v) => _then(v as _ProjectUpdateEvent));

  @override
  _ProjectUpdateEvent get _value => super._value as _ProjectUpdateEvent;

  @override
  $Res call({
    Object? project = freezed,
  }) {
    return _then(_ProjectUpdateEvent(
      project: project == freezed
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectParams,
    ));
  }
}

/// @nodoc

class _$_ProjectUpdateEvent implements _ProjectUpdateEvent {
  const _$_ProjectUpdateEvent({required this.project});

  @override
  final ProjectParams project;

  @override
  String toString() {
    return 'ProjectEvent.update(project: $project)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectUpdateEvent &&
            const DeepCollectionEquality().equals(other.project, project));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(project));

  @JsonKey(ignore: true)
  @override
  _$ProjectUpdateEventCopyWith<_ProjectUpdateEvent> get copyWith =>
      __$ProjectUpdateEventCopyWithImpl<_ProjectUpdateEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function(ProjectParams project) create,
    required TResult Function(ProjectParams project) update,
    required TResult Function(ProjectParams project) delete,
  }) {
    return update(project);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
  }) {
    return update?.call(project);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(project);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectGetEvent value) get,
    required TResult Function(_ProjectCreateEvent value) create,
    required TResult Function(_ProjectUpdateEvent value) update,
    required TResult Function(_ProjectDeleteEvent value) delete,
  }) {
    return update(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
  }) {
    return update?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (update != null) {
      return update(this);
    }
    return orElse();
  }
}

abstract class _ProjectUpdateEvent implements ProjectEvent {
  const factory _ProjectUpdateEvent({required ProjectParams project}) =
      _$_ProjectUpdateEvent;

  ProjectParams get project;
  @JsonKey(ignore: true)
  _$ProjectUpdateEventCopyWith<_ProjectUpdateEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ProjectDeleteEventCopyWith<$Res> {
  factory _$ProjectDeleteEventCopyWith(
          _ProjectDeleteEvent value, $Res Function(_ProjectDeleteEvent) then) =
      __$ProjectDeleteEventCopyWithImpl<$Res>;
  $Res call({ProjectParams project});
}

/// @nodoc
class __$ProjectDeleteEventCopyWithImpl<$Res>
    extends _$ProjectEventCopyWithImpl<$Res>
    implements _$ProjectDeleteEventCopyWith<$Res> {
  __$ProjectDeleteEventCopyWithImpl(
      _ProjectDeleteEvent _value, $Res Function(_ProjectDeleteEvent) _then)
      : super(_value, (v) => _then(v as _ProjectDeleteEvent));

  @override
  _ProjectDeleteEvent get _value => super._value as _ProjectDeleteEvent;

  @override
  $Res call({
    Object? project = freezed,
  }) {
    return _then(_ProjectDeleteEvent(
      project: project == freezed
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as ProjectParams,
    ));
  }
}

/// @nodoc

class _$_ProjectDeleteEvent implements _ProjectDeleteEvent {
  const _$_ProjectDeleteEvent({required this.project});

  @override
  final ProjectParams project;

  @override
  String toString() {
    return 'ProjectEvent.delete(project: $project)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectDeleteEvent &&
            const DeepCollectionEquality().equals(other.project, project));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(project));

  @JsonKey(ignore: true)
  @override
  _$ProjectDeleteEventCopyWith<_ProjectDeleteEvent> get copyWith =>
      __$ProjectDeleteEventCopyWithImpl<_ProjectDeleteEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() get,
    required TResult Function(ProjectParams project) create,
    required TResult Function(ProjectParams project) update,
    required TResult Function(ProjectParams project) delete,
  }) {
    return delete(project);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
  }) {
    return delete?.call(project);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? get,
    TResult Function(ProjectParams project)? create,
    TResult Function(ProjectParams project)? update,
    TResult Function(ProjectParams project)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(project);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectGetEvent value) get,
    required TResult Function(_ProjectCreateEvent value) create,
    required TResult Function(_ProjectUpdateEvent value) update,
    required TResult Function(_ProjectDeleteEvent value) delete,
  }) {
    return delete(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
  }) {
    return delete?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectGetEvent value)? get,
    TResult Function(_ProjectCreateEvent value)? create,
    TResult Function(_ProjectUpdateEvent value)? update,
    TResult Function(_ProjectDeleteEvent value)? delete,
    required TResult orElse(),
  }) {
    if (delete != null) {
      return delete(this);
    }
    return orElse();
  }
}

abstract class _ProjectDeleteEvent implements ProjectEvent {
  const factory _ProjectDeleteEvent({required ProjectParams project}) =
      _$_ProjectDeleteEvent;

  ProjectParams get project;
  @JsonKey(ignore: true)
  _$ProjectDeleteEventCopyWith<_ProjectDeleteEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
class _$ProjectStateTearOff {
  const _$ProjectStateTearOff();

  _ProjectInitial initial() {
    return const _ProjectInitial();
  }

  _ProjectLoading loading() {
    return const _ProjectLoading();
  }

  _ProjectError error(String message) {
    return _ProjectError(
      message,
    );
  }

  _ProjectLoaded loaded({List<ProjectEntry>? project}) {
    return _ProjectLoaded(
      project: project,
    );
  }
}

/// @nodoc
const $ProjectState = _$ProjectStateTearOff();

/// @nodoc
mixin _$ProjectState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<ProjectEntry>? project) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectInitial value) initial,
    required TResult Function(_ProjectLoading value) loading,
    required TResult Function(_ProjectError value) error,
    required TResult Function(_ProjectLoaded value) loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStateCopyWith<$Res> {
  factory $ProjectStateCopyWith(
          ProjectState value, $Res Function(ProjectState) then) =
      _$ProjectStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$ProjectStateCopyWithImpl<$Res> implements $ProjectStateCopyWith<$Res> {
  _$ProjectStateCopyWithImpl(this._value, this._then);

  final ProjectState _value;
  // ignore: unused_field
  final $Res Function(ProjectState) _then;
}

/// @nodoc
abstract class _$ProjectInitialCopyWith<$Res> {
  factory _$ProjectInitialCopyWith(
          _ProjectInitial value, $Res Function(_ProjectInitial) then) =
      __$ProjectInitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$ProjectInitialCopyWithImpl<$Res>
    extends _$ProjectStateCopyWithImpl<$Res>
    implements _$ProjectInitialCopyWith<$Res> {
  __$ProjectInitialCopyWithImpl(
      _ProjectInitial _value, $Res Function(_ProjectInitial) _then)
      : super(_value, (v) => _then(v as _ProjectInitial));

  @override
  _ProjectInitial get _value => super._value as _ProjectInitial;
}

/// @nodoc

class _$_ProjectInitial implements _ProjectInitial {
  const _$_ProjectInitial();

  @override
  String toString() {
    return 'ProjectState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ProjectInitial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<ProjectEntry>? project) loaded,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectInitial value) initial,
    required TResult Function(_ProjectLoading value) loading,
    required TResult Function(_ProjectError value) error,
    required TResult Function(_ProjectLoaded value) loaded,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _ProjectInitial implements ProjectState {
  const factory _ProjectInitial() = _$_ProjectInitial;
}

/// @nodoc
abstract class _$ProjectLoadingCopyWith<$Res> {
  factory _$ProjectLoadingCopyWith(
          _ProjectLoading value, $Res Function(_ProjectLoading) then) =
      __$ProjectLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$ProjectLoadingCopyWithImpl<$Res>
    extends _$ProjectStateCopyWithImpl<$Res>
    implements _$ProjectLoadingCopyWith<$Res> {
  __$ProjectLoadingCopyWithImpl(
      _ProjectLoading _value, $Res Function(_ProjectLoading) _then)
      : super(_value, (v) => _then(v as _ProjectLoading));

  @override
  _ProjectLoading get _value => super._value as _ProjectLoading;
}

/// @nodoc

class _$_ProjectLoading implements _ProjectLoading {
  const _$_ProjectLoading();

  @override
  String toString() {
    return 'ProjectState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ProjectLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<ProjectEntry>? project) loaded,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectInitial value) initial,
    required TResult Function(_ProjectLoading value) loading,
    required TResult Function(_ProjectError value) error,
    required TResult Function(_ProjectLoaded value) loaded,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _ProjectLoading implements ProjectState {
  const factory _ProjectLoading() = _$_ProjectLoading;
}

/// @nodoc
abstract class _$ProjectErrorCopyWith<$Res> {
  factory _$ProjectErrorCopyWith(
          _ProjectError value, $Res Function(_ProjectError) then) =
      __$ProjectErrorCopyWithImpl<$Res>;
  $Res call({String message});
}

/// @nodoc
class __$ProjectErrorCopyWithImpl<$Res> extends _$ProjectStateCopyWithImpl<$Res>
    implements _$ProjectErrorCopyWith<$Res> {
  __$ProjectErrorCopyWithImpl(
      _ProjectError _value, $Res Function(_ProjectError) _then)
      : super(_value, (v) => _then(v as _ProjectError));

  @override
  _ProjectError get _value => super._value as _ProjectError;

  @override
  $Res call({
    Object? message = freezed,
  }) {
    return _then(_ProjectError(
      message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ProjectError implements _ProjectError {
  const _$_ProjectError(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'ProjectState.error(message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectError &&
            const DeepCollectionEquality().equals(other.message, message));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(message));

  @JsonKey(ignore: true)
  @override
  _$ProjectErrorCopyWith<_ProjectError> get copyWith =>
      __$ProjectErrorCopyWithImpl<_ProjectError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<ProjectEntry>? project) loaded,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectInitial value) initial,
    required TResult Function(_ProjectLoading value) loading,
    required TResult Function(_ProjectError value) error,
    required TResult Function(_ProjectLoaded value) loaded,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _ProjectError implements ProjectState {
  const factory _ProjectError(String message) = _$_ProjectError;

  String get message;
  @JsonKey(ignore: true)
  _$ProjectErrorCopyWith<_ProjectError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$ProjectLoadedCopyWith<$Res> {
  factory _$ProjectLoadedCopyWith(
          _ProjectLoaded value, $Res Function(_ProjectLoaded) then) =
      __$ProjectLoadedCopyWithImpl<$Res>;
  $Res call({List<ProjectEntry>? project});
}

/// @nodoc
class __$ProjectLoadedCopyWithImpl<$Res>
    extends _$ProjectStateCopyWithImpl<$Res>
    implements _$ProjectLoadedCopyWith<$Res> {
  __$ProjectLoadedCopyWithImpl(
      _ProjectLoaded _value, $Res Function(_ProjectLoaded) _then)
      : super(_value, (v) => _then(v as _ProjectLoaded));

  @override
  _ProjectLoaded get _value => super._value as _ProjectLoaded;

  @override
  $Res call({
    Object? project = freezed,
  }) {
    return _then(_ProjectLoaded(
      project: project == freezed
          ? _value.project
          : project // ignore: cast_nullable_to_non_nullable
              as List<ProjectEntry>?,
    ));
  }
}

/// @nodoc

class _$_ProjectLoaded implements _ProjectLoaded {
  const _$_ProjectLoaded({this.project});

  @override
  final List<ProjectEntry>? project;

  @override
  String toString() {
    return 'ProjectState.loaded(project: $project)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ProjectLoaded &&
            const DeepCollectionEquality().equals(other.project, project));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(project));

  @JsonKey(ignore: true)
  @override
  _$ProjectLoadedCopyWith<_ProjectLoaded> get copyWith =>
      __$ProjectLoadedCopyWithImpl<_ProjectLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(String message) error,
    required TResult Function(List<ProjectEntry>? project) loaded,
  }) {
    return loaded(project);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
  }) {
    return loaded?.call(project);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(String message)? error,
    TResult Function(List<ProjectEntry>? project)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(project);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_ProjectInitial value) initial,
    required TResult Function(_ProjectLoading value) loading,
    required TResult Function(_ProjectError value) error,
    required TResult Function(_ProjectLoaded value) loaded,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_ProjectInitial value)? initial,
    TResult Function(_ProjectLoading value)? loading,
    TResult Function(_ProjectError value)? error,
    TResult Function(_ProjectLoaded value)? loaded,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _ProjectLoaded implements ProjectState {
  const factory _ProjectLoaded({List<ProjectEntry>? project}) =
      _$_ProjectLoaded;

  List<ProjectEntry>? get project;
  @JsonKey(ignore: true)
  _$ProjectLoadedCopyWith<_ProjectLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}
