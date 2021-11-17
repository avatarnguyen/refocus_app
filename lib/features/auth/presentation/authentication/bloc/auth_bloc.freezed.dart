// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$AuthEventTearOff {
  const _$AuthEventTearOff();

  _AuthenticationStatusChanged authenticationChanged(
      AuthenticationStatus status) {
    return _AuthenticationStatusChanged(
      status,
    );
  }

  _AuthSignOutRequested signOutRequested() {
    return const _AuthSignOutRequested();
  }

  _AuthAutoSignInAttempt autoSignInAttempt() {
    return const _AuthAutoSignInAttempt();
  }
}

/// @nodoc
const $AuthEvent = _$AuthEventTearOff();

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationChanged,
    required TResult Function() signOutRequested,
    required TResult Function() autoSignInAttempt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationChanged,
    required TResult Function(_AuthSignOutRequested value) signOutRequested,
    required TResult Function(_AuthAutoSignInAttempt value) autoSignInAttempt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res> implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  final AuthEvent _value;
  // ignore: unused_field
  final $Res Function(AuthEvent) _then;
}

/// @nodoc
abstract class _$AuthenticationStatusChangedCopyWith<$Res> {
  factory _$AuthenticationStatusChangedCopyWith(
          _AuthenticationStatusChanged value,
          $Res Function(_AuthenticationStatusChanged) then) =
      __$AuthenticationStatusChangedCopyWithImpl<$Res>;
  $Res call({AuthenticationStatus status});
}

/// @nodoc
class __$AuthenticationStatusChangedCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$AuthenticationStatusChangedCopyWith<$Res> {
  __$AuthenticationStatusChangedCopyWithImpl(
      _AuthenticationStatusChanged _value,
      $Res Function(_AuthenticationStatusChanged) _then)
      : super(_value, (v) => _then(v as _AuthenticationStatusChanged));

  @override
  _AuthenticationStatusChanged get _value =>
      super._value as _AuthenticationStatusChanged;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_AuthenticationStatusChanged(
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticationStatus,
    ));
  }
}

/// @nodoc

class _$_AuthenticationStatusChanged implements _AuthenticationStatusChanged {
  const _$_AuthenticationStatusChanged(this.status);

  @override
  final AuthenticationStatus status;

  @override
  String toString() {
    return 'AuthEvent.authenticationChanged(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthenticationStatusChanged &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(status);

  @JsonKey(ignore: true)
  @override
  _$AuthenticationStatusChangedCopyWith<_AuthenticationStatusChanged>
      get copyWith => __$AuthenticationStatusChangedCopyWithImpl<
          _AuthenticationStatusChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationChanged,
    required TResult Function() signOutRequested,
    required TResult Function() autoSignInAttempt,
  }) {
    return authenticationChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
  }) {
    return authenticationChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
    required TResult orElse(),
  }) {
    if (authenticationChanged != null) {
      return authenticationChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationChanged,
    required TResult Function(_AuthSignOutRequested value) signOutRequested,
    required TResult Function(_AuthAutoSignInAttempt value) autoSignInAttempt,
  }) {
    return authenticationChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
  }) {
    return authenticationChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
    required TResult orElse(),
  }) {
    if (authenticationChanged != null) {
      return authenticationChanged(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationStatusChanged implements AuthEvent {
  const factory _AuthenticationStatusChanged(AuthenticationStatus status) =
      _$_AuthenticationStatusChanged;

  AuthenticationStatus get status => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthenticationStatusChangedCopyWith<_AuthenticationStatusChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthSignOutRequestedCopyWith<$Res> {
  factory _$AuthSignOutRequestedCopyWith(_AuthSignOutRequested value,
          $Res Function(_AuthSignOutRequested) then) =
      __$AuthSignOutRequestedCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthSignOutRequestedCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$AuthSignOutRequestedCopyWith<$Res> {
  __$AuthSignOutRequestedCopyWithImpl(
      _AuthSignOutRequested _value, $Res Function(_AuthSignOutRequested) _then)
      : super(_value, (v) => _then(v as _AuthSignOutRequested));

  @override
  _AuthSignOutRequested get _value => super._value as _AuthSignOutRequested;
}

/// @nodoc

class _$_AuthSignOutRequested implements _AuthSignOutRequested {
  const _$_AuthSignOutRequested();

  @override
  String toString() {
    return 'AuthEvent.signOutRequested()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthSignOutRequested);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationChanged,
    required TResult Function() signOutRequested,
    required TResult Function() autoSignInAttempt,
  }) {
    return signOutRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
  }) {
    return signOutRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationChanged,
    required TResult Function(_AuthSignOutRequested value) signOutRequested,
    required TResult Function(_AuthAutoSignInAttempt value) autoSignInAttempt,
  }) {
    return signOutRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
  }) {
    return signOutRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
    required TResult orElse(),
  }) {
    if (signOutRequested != null) {
      return signOutRequested(this);
    }
    return orElse();
  }
}

abstract class _AuthSignOutRequested implements AuthEvent {
  const factory _AuthSignOutRequested() = _$_AuthSignOutRequested;
}

/// @nodoc
abstract class _$AuthAutoSignInAttemptCopyWith<$Res> {
  factory _$AuthAutoSignInAttemptCopyWith(_AuthAutoSignInAttempt value,
          $Res Function(_AuthAutoSignInAttempt) then) =
      __$AuthAutoSignInAttemptCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthAutoSignInAttemptCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$AuthAutoSignInAttemptCopyWith<$Res> {
  __$AuthAutoSignInAttemptCopyWithImpl(_AuthAutoSignInAttempt _value,
      $Res Function(_AuthAutoSignInAttempt) _then)
      : super(_value, (v) => _then(v as _AuthAutoSignInAttempt));

  @override
  _AuthAutoSignInAttempt get _value => super._value as _AuthAutoSignInAttempt;
}

/// @nodoc

class _$_AuthAutoSignInAttempt implements _AuthAutoSignInAttempt {
  const _$_AuthAutoSignInAttempt();

  @override
  String toString() {
    return 'AuthEvent.autoSignInAttempt()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthAutoSignInAttempt);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationChanged,
    required TResult Function() signOutRequested,
    required TResult Function() autoSignInAttempt,
  }) {
    return autoSignInAttempt();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
  }) {
    return autoSignInAttempt?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationChanged,
    TResult Function()? signOutRequested,
    TResult Function()? autoSignInAttempt,
    required TResult orElse(),
  }) {
    if (autoSignInAttempt != null) {
      return autoSignInAttempt();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationChanged,
    required TResult Function(_AuthSignOutRequested value) signOutRequested,
    required TResult Function(_AuthAutoSignInAttempt value) autoSignInAttempt,
  }) {
    return autoSignInAttempt(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
  }) {
    return autoSignInAttempt?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)? authenticationChanged,
    TResult Function(_AuthSignOutRequested value)? signOutRequested,
    TResult Function(_AuthAutoSignInAttempt value)? autoSignInAttempt,
    required TResult orElse(),
  }) {
    if (autoSignInAttempt != null) {
      return autoSignInAttempt(this);
    }
    return orElse();
  }
}

abstract class _AuthAutoSignInAttempt implements AuthEvent {
  const factory _AuthAutoSignInAttempt() = _$_AuthAutoSignInAttempt;
}

/// @nodoc
class _$AuthStateTearOff {
  const _$AuthStateTearOff();

  _AuthUnknown unknown() {
    return const _AuthUnknown();
  }

  _AuthAuthenticated authenticated(UserEntry userEntry) {
    return _AuthAuthenticated(
      userEntry,
    );
  }

  _AuthUnauthenticated unauthenticated() {
    return const _AuthUnauthenticated();
  }

  _AuthLoading loading() {
    return const _AuthLoading();
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(UserEntry userEntry) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function() loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthUnknown value) unknown,
    required TResult Function(_AuthAuthenticated value) authenticated,
    required TResult Function(_AuthUnauthenticated value) unauthenticated,
    required TResult Function(_AuthLoading value) loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;
}

/// @nodoc
abstract class _$AuthUnknownCopyWith<$Res> {
  factory _$AuthUnknownCopyWith(
          _AuthUnknown value, $Res Function(_AuthUnknown) then) =
      __$AuthUnknownCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthUnknownCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthUnknownCopyWith<$Res> {
  __$AuthUnknownCopyWithImpl(
      _AuthUnknown _value, $Res Function(_AuthUnknown) _then)
      : super(_value, (v) => _then(v as _AuthUnknown));

  @override
  _AuthUnknown get _value => super._value as _AuthUnknown;
}

/// @nodoc

class _$_AuthUnknown implements _AuthUnknown {
  const _$_AuthUnknown();

  @override
  String toString() {
    return 'AuthState.unknown()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthUnknown);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(UserEntry userEntry) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function() loading,
  }) {
    return unknown();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
  }) {
    return unknown?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthUnknown value) unknown,
    required TResult Function(_AuthAuthenticated value) authenticated,
    required TResult Function(_AuthUnauthenticated value) unauthenticated,
    required TResult Function(_AuthLoading value) loading,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class _AuthUnknown implements AuthState {
  const factory _AuthUnknown() = _$_AuthUnknown;
}

/// @nodoc
abstract class _$AuthAuthenticatedCopyWith<$Res> {
  factory _$AuthAuthenticatedCopyWith(
          _AuthAuthenticated value, $Res Function(_AuthAuthenticated) then) =
      __$AuthAuthenticatedCopyWithImpl<$Res>;
  $Res call({UserEntry userEntry});

  $UserEntryCopyWith<$Res> get userEntry;
}

/// @nodoc
class __$AuthAuthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthAuthenticatedCopyWith<$Res> {
  __$AuthAuthenticatedCopyWithImpl(
      _AuthAuthenticated _value, $Res Function(_AuthAuthenticated) _then)
      : super(_value, (v) => _then(v as _AuthAuthenticated));

  @override
  _AuthAuthenticated get _value => super._value as _AuthAuthenticated;

  @override
  $Res call({
    Object? userEntry = freezed,
  }) {
    return _then(_AuthAuthenticated(
      userEntry == freezed
          ? _value.userEntry
          : userEntry // ignore: cast_nullable_to_non_nullable
              as UserEntry,
    ));
  }

  @override
  $UserEntryCopyWith<$Res> get userEntry {
    return $UserEntryCopyWith<$Res>(_value.userEntry, (value) {
      return _then(_value.copyWith(userEntry: value));
    });
  }
}

/// @nodoc

class _$_AuthAuthenticated implements _AuthAuthenticated {
  const _$_AuthAuthenticated(this.userEntry);

  @override
  final UserEntry userEntry;

  @override
  String toString() {
    return 'AuthState.authenticated(userEntry: $userEntry)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthAuthenticated &&
            (identical(other.userEntry, userEntry) ||
                const DeepCollectionEquality()
                    .equals(other.userEntry, userEntry)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userEntry);

  @JsonKey(ignore: true)
  @override
  _$AuthAuthenticatedCopyWith<_AuthAuthenticated> get copyWith =>
      __$AuthAuthenticatedCopyWithImpl<_AuthAuthenticated>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(UserEntry userEntry) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function() loading,
  }) {
    return authenticated(userEntry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
  }) {
    return authenticated?.call(userEntry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(userEntry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthUnknown value) unknown,
    required TResult Function(_AuthAuthenticated value) authenticated,
    required TResult Function(_AuthUnauthenticated value) unauthenticated,
    required TResult Function(_AuthLoading value) loading,
  }) {
    return authenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
  }) {
    return authenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
    required TResult orElse(),
  }) {
    if (authenticated != null) {
      return authenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthAuthenticated implements AuthState {
  const factory _AuthAuthenticated(UserEntry userEntry) = _$_AuthAuthenticated;

  UserEntry get userEntry => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthAuthenticatedCopyWith<_AuthAuthenticated> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthUnauthenticatedCopyWith<$Res> {
  factory _$AuthUnauthenticatedCopyWith(_AuthUnauthenticated value,
          $Res Function(_AuthUnauthenticated) then) =
      __$AuthUnauthenticatedCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthUnauthenticatedCopyWithImpl<$Res>
    extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthUnauthenticatedCopyWith<$Res> {
  __$AuthUnauthenticatedCopyWithImpl(
      _AuthUnauthenticated _value, $Res Function(_AuthUnauthenticated) _then)
      : super(_value, (v) => _then(v as _AuthUnauthenticated));

  @override
  _AuthUnauthenticated get _value => super._value as _AuthUnauthenticated;
}

/// @nodoc

class _$_AuthUnauthenticated implements _AuthUnauthenticated {
  const _$_AuthUnauthenticated();

  @override
  String toString() {
    return 'AuthState.unauthenticated()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthUnauthenticated);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(UserEntry userEntry) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function() loading,
  }) {
    return unauthenticated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
  }) {
    return unauthenticated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthUnknown value) unknown,
    required TResult Function(_AuthAuthenticated value) authenticated,
    required TResult Function(_AuthUnauthenticated value) unauthenticated,
    required TResult Function(_AuthLoading value) loading,
  }) {
    return unauthenticated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
  }) {
    return unauthenticated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
    required TResult orElse(),
  }) {
    if (unauthenticated != null) {
      return unauthenticated(this);
    }
    return orElse();
  }
}

abstract class _AuthUnauthenticated implements AuthState {
  const factory _AuthUnauthenticated() = _$_AuthUnauthenticated;
}

/// @nodoc
abstract class _$AuthLoadingCopyWith<$Res> {
  factory _$AuthLoadingCopyWith(
          _AuthLoading value, $Res Function(_AuthLoading) then) =
      __$AuthLoadingCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthLoadingCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthLoadingCopyWith<$Res> {
  __$AuthLoadingCopyWithImpl(
      _AuthLoading _value, $Res Function(_AuthLoading) _then)
      : super(_value, (v) => _then(v as _AuthLoading));

  @override
  _AuthLoading get _value => super._value as _AuthLoading;
}

/// @nodoc

class _$_AuthLoading implements _AuthLoading {
  const _$_AuthLoading();

  @override
  String toString() {
    return 'AuthState.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthLoading);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() unknown,
    required TResult Function(UserEntry userEntry) authenticated,
    required TResult Function() unauthenticated,
    required TResult Function() loading,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? unknown,
    TResult Function(UserEntry userEntry)? authenticated,
    TResult Function()? unauthenticated,
    TResult Function()? loading,
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
    required TResult Function(_AuthUnknown value) unknown,
    required TResult Function(_AuthAuthenticated value) authenticated,
    required TResult Function(_AuthUnauthenticated value) unauthenticated,
    required TResult Function(_AuthLoading value) loading,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthUnknown value)? unknown,
    TResult Function(_AuthAuthenticated value)? authenticated,
    TResult Function(_AuthUnauthenticated value)? unauthenticated,
    TResult Function(_AuthLoading value)? loading,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _AuthLoading implements AuthState {
  const factory _AuthLoading() = _$_AuthLoading;
}
