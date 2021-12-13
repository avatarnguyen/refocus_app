// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'subtask_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SubtaskStateTearOff {
  const _$SubtaskStateTearOff();

  _Initial initial() {
    return const _Initial();
  }

  _SubTaskLoaded loaded(List<SubTaskEntry> subtasks) {
    return _SubTaskLoaded(
      subtasks,
    );
  }

  _SubTaskError error(String errorMessage) {
    return _SubTaskError(
      errorMessage,
    );
  }
}

/// @nodoc
const $SubtaskState = _$SubtaskStateTearOff();

/// @nodoc
mixin _$SubtaskState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SubTaskEntry> subtasks) loaded,
    required TResult Function(String errorMessage) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SubTaskLoaded value) loaded,
    required TResult Function(_SubTaskError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubtaskStateCopyWith<$Res> {
  factory $SubtaskStateCopyWith(
          SubtaskState value, $Res Function(SubtaskState) then) =
      _$SubtaskStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$SubtaskStateCopyWithImpl<$Res> implements $SubtaskStateCopyWith<$Res> {
  _$SubtaskStateCopyWithImpl(this._value, this._then);

  final SubtaskState _value;
  // ignore: unused_field
  final $Res Function(SubtaskState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$SubtaskStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'SubtaskState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SubTaskEntry> subtasks) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
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
    required TResult Function(_Initial value) initial,
    required TResult Function(_SubTaskLoaded value) loaded,
    required TResult Function(_SubTaskError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SubtaskState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$SubTaskLoadedCopyWith<$Res> {
  factory _$SubTaskLoadedCopyWith(
          _SubTaskLoaded value, $Res Function(_SubTaskLoaded) then) =
      __$SubTaskLoadedCopyWithImpl<$Res>;
  $Res call({List<SubTaskEntry> subtasks});
}

/// @nodoc
class __$SubTaskLoadedCopyWithImpl<$Res>
    extends _$SubtaskStateCopyWithImpl<$Res>
    implements _$SubTaskLoadedCopyWith<$Res> {
  __$SubTaskLoadedCopyWithImpl(
      _SubTaskLoaded _value, $Res Function(_SubTaskLoaded) _then)
      : super(_value, (v) => _then(v as _SubTaskLoaded));

  @override
  _SubTaskLoaded get _value => super._value as _SubTaskLoaded;

  @override
  $Res call({
    Object? subtasks = freezed,
  }) {
    return _then(_SubTaskLoaded(
      subtasks == freezed
          ? _value.subtasks
          : subtasks // ignore: cast_nullable_to_non_nullable
              as List<SubTaskEntry>,
    ));
  }
}

/// @nodoc

class _$_SubTaskLoaded implements _SubTaskLoaded {
  const _$_SubTaskLoaded(this.subtasks);

  @override
  final List<SubTaskEntry> subtasks;

  @override
  String toString() {
    return 'SubtaskState.loaded(subtasks: $subtasks)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubTaskLoaded &&
            const DeepCollectionEquality().equals(other.subtasks, subtasks));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(subtasks));

  @JsonKey(ignore: true)
  @override
  _$SubTaskLoadedCopyWith<_SubTaskLoaded> get copyWith =>
      __$SubTaskLoadedCopyWithImpl<_SubTaskLoaded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SubTaskEntry> subtasks) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return loaded(subtasks);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
  }) {
    return loaded?.call(subtasks);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(subtasks);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SubTaskLoaded value) loaded,
    required TResult Function(_SubTaskError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _SubTaskLoaded implements SubtaskState {
  const factory _SubTaskLoaded(List<SubTaskEntry> subtasks) = _$_SubTaskLoaded;

  List<SubTaskEntry> get subtasks;
  @JsonKey(ignore: true)
  _$SubTaskLoadedCopyWith<_SubTaskLoaded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SubTaskErrorCopyWith<$Res> {
  factory _$SubTaskErrorCopyWith(
          _SubTaskError value, $Res Function(_SubTaskError) then) =
      __$SubTaskErrorCopyWithImpl<$Res>;
  $Res call({String errorMessage});
}

/// @nodoc
class __$SubTaskErrorCopyWithImpl<$Res> extends _$SubtaskStateCopyWithImpl<$Res>
    implements _$SubTaskErrorCopyWith<$Res> {
  __$SubTaskErrorCopyWithImpl(
      _SubTaskError _value, $Res Function(_SubTaskError) _then)
      : super(_value, (v) => _then(v as _SubTaskError));

  @override
  _SubTaskError get _value => super._value as _SubTaskError;

  @override
  $Res call({
    Object? errorMessage = freezed,
  }) {
    return _then(_SubTaskError(
      errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SubTaskError implements _SubTaskError {
  const _$_SubTaskError(this.errorMessage);

  @override
  final String errorMessage;

  @override
  String toString() {
    return 'SubtaskState.error(errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubTaskError &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  _$SubTaskErrorCopyWith<_SubTaskError> get copyWith =>
      __$SubTaskErrorCopyWithImpl<_SubTaskError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function(List<SubTaskEntry> subtasks) loaded,
    required TResult Function(String errorMessage) error,
  }) {
    return error(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
  }) {
    return error?.call(errorMessage);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function(List<SubTaskEntry> subtasks)? loaded,
    TResult Function(String errorMessage)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(errorMessage);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_SubTaskLoaded value) loaded,
    required TResult Function(_SubTaskError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_SubTaskLoaded value)? loaded,
    TResult Function(_SubTaskError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _SubTaskError implements SubtaskState {
  const factory _SubTaskError(String errorMessage) = _$_SubTaskError;

  String get errorMessage;
  @JsonKey(ignore: true)
  _$SubTaskErrorCopyWith<_SubTaskError> get copyWith =>
      throw _privateConstructorUsedError;
}
