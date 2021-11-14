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

  _AuthSignUpEvent signUp({String? username, String? email, String? password}) {
    return _AuthSignUpEvent(
      username: username,
      email: email,
      password: password,
    );
  }

  _AuthLoginEvent login({String? username, String? password}) {
    return _AuthLoginEvent(
      username: username,
      password: password,
    );
  }

  _AuthSignOutEvent signOut() {
    return const _AuthSignOutEvent();
  }
}

/// @nodoc
const $AuthEvent = _$AuthEventTearOff();

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? username, String? email, String? password)
        signUp,
    required TResult Function(String? username, String? password) login,
    required TResult Function() signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthSignUpEvent value) signUp,
    required TResult Function(_AuthLoginEvent value) login,
    required TResult Function(_AuthSignOutEvent value) signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
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
abstract class _$AuthSignUpEventCopyWith<$Res> {
  factory _$AuthSignUpEventCopyWith(
          _AuthSignUpEvent value, $Res Function(_AuthSignUpEvent) then) =
      __$AuthSignUpEventCopyWithImpl<$Res>;
  $Res call({String? username, String? email, String? password});
}

/// @nodoc
class __$AuthSignUpEventCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res>
    implements _$AuthSignUpEventCopyWith<$Res> {
  __$AuthSignUpEventCopyWithImpl(
      _AuthSignUpEvent _value, $Res Function(_AuthSignUpEvent) _then)
      : super(_value, (v) => _then(v as _AuthSignUpEvent));

  @override
  _AuthSignUpEvent get _value => super._value as _AuthSignUpEvent;

  @override
  $Res call({
    Object? username = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_AuthSignUpEvent(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthSignUpEvent implements _AuthSignUpEvent {
  const _$_AuthSignUpEvent({this.username, this.email, this.password});

  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? password;

  @override
  String toString() {
    return 'AuthEvent.signUp(username: $username, email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthSignUpEvent &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$AuthSignUpEventCopyWith<_AuthSignUpEvent> get copyWith =>
      __$AuthSignUpEventCopyWithImpl<_AuthSignUpEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? username, String? email, String? password)
        signUp,
    required TResult Function(String? username, String? password) login,
    required TResult Function() signOut,
  }) {
    return signUp(username, email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
  }) {
    return signUp?.call(username, email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(username, email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthSignUpEvent value) signUp,
    required TResult Function(_AuthLoginEvent value) login,
    required TResult Function(_AuthSignOutEvent value) signOut,
  }) {
    return signUp(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
  }) {
    return signUp?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
    required TResult orElse(),
  }) {
    if (signUp != null) {
      return signUp(this);
    }
    return orElse();
  }
}

abstract class _AuthSignUpEvent implements AuthEvent {
  const factory _AuthSignUpEvent(
      {String? username, String? email, String? password}) = _$_AuthSignUpEvent;

  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthSignUpEventCopyWith<_AuthSignUpEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthLoginEventCopyWith<$Res> {
  factory _$AuthLoginEventCopyWith(
          _AuthLoginEvent value, $Res Function(_AuthLoginEvent) then) =
      __$AuthLoginEventCopyWithImpl<$Res>;
  $Res call({String? username, String? password});
}

/// @nodoc
class __$AuthLoginEventCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res>
    implements _$AuthLoginEventCopyWith<$Res> {
  __$AuthLoginEventCopyWithImpl(
      _AuthLoginEvent _value, $Res Function(_AuthLoginEvent) _then)
      : super(_value, (v) => _then(v as _AuthLoginEvent));

  @override
  _AuthLoginEvent get _value => super._value as _AuthLoginEvent;

  @override
  $Res call({
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_AuthLoginEvent(
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthLoginEvent implements _AuthLoginEvent {
  const _$_AuthLoginEvent({this.username, this.password});

  @override
  final String? username;
  @override
  final String? password;

  @override
  String toString() {
    return 'AuthEvent.login(username: $username, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthLoginEvent &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)) &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$AuthLoginEventCopyWith<_AuthLoginEvent> get copyWith =>
      __$AuthLoginEventCopyWithImpl<_AuthLoginEvent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? username, String? email, String? password)
        signUp,
    required TResult Function(String? username, String? password) login,
    required TResult Function() signOut,
  }) {
    return login(username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
  }) {
    return login?.call(username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthSignUpEvent value) signUp,
    required TResult Function(_AuthLoginEvent value) login,
    required TResult Function(_AuthSignOutEvent value) signOut,
  }) {
    return login(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
  }) {
    return login?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
    required TResult orElse(),
  }) {
    if (login != null) {
      return login(this);
    }
    return orElse();
  }
}

abstract class _AuthLoginEvent implements AuthEvent {
  const factory _AuthLoginEvent({String? username, String? password}) =
      _$_AuthLoginEvent;

  String? get username => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthLoginEventCopyWith<_AuthLoginEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthSignOutEventCopyWith<$Res> {
  factory _$AuthSignOutEventCopyWith(
          _AuthSignOutEvent value, $Res Function(_AuthSignOutEvent) then) =
      __$AuthSignOutEventCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthSignOutEventCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$AuthSignOutEventCopyWith<$Res> {
  __$AuthSignOutEventCopyWithImpl(
      _AuthSignOutEvent _value, $Res Function(_AuthSignOutEvent) _then)
      : super(_value, (v) => _then(v as _AuthSignOutEvent));

  @override
  _AuthSignOutEvent get _value => super._value as _AuthSignOutEvent;
}

/// @nodoc

class _$_AuthSignOutEvent implements _AuthSignOutEvent {
  const _$_AuthSignOutEvent();

  @override
  String toString() {
    return 'AuthEvent.signOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthSignOutEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String? username, String? email, String? password)
        signUp,
    required TResult Function(String? username, String? password) login,
    required TResult Function() signOut,
  }) {
    return signOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
  }) {
    return signOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String? username, String? email, String? password)? signUp,
    TResult Function(String? username, String? password)? login,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthSignUpEvent value) signUp,
    required TResult Function(_AuthLoginEvent value) login,
    required TResult Function(_AuthSignOutEvent value) signOut,
  }) {
    return signOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
  }) {
    return signOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthSignUpEvent value)? signUp,
    TResult Function(_AuthLoginEvent value)? login,
    TResult Function(_AuthSignOutEvent value)? signOut,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut(this);
    }
    return orElse();
  }
}

abstract class _AuthSignOutEvent implements AuthEvent {
  const factory _AuthSignOutEvent() = _$_AuthSignOutEvent;
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
