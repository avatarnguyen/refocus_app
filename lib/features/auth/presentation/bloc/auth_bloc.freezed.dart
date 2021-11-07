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

  _AuthLoginEvent login(String? username, String? password) {
    return _AuthLoginEvent(
      username,
      password,
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
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AuthLoginEvent implements _AuthLoginEvent {
  const _$_AuthLoginEvent(this.username, this.password);

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
  const factory _AuthLoginEvent(String? username, String? password) =
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

  _AuthLoading loading() {
    return const _AuthLoading();
  }

  _AuthSucceeded success(UserEntry userEntry) {
    return _AuthSucceeded(
      userEntry,
    );
  }

  _AuthError error() {
    return const _AuthError();
  }

  _AuthIsSignedOut isSignedOut() {
    return const _AuthIsSignedOut();
  }
}

/// @nodoc
const $AuthState = _$AuthStateTearOff();

/// @nodoc
mixin _$AuthState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserEntry userEntry) success,
    required TResult Function() error,
    required TResult Function() isSignedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthSucceeded value) success,
    required TResult Function(_AuthError value) error,
    required TResult Function(_AuthIsSignedOut value) isSignedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
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
    required TResult Function() loading,
    required TResult Function(UserEntry userEntry) success,
    required TResult Function() error,
    required TResult Function() isSignedOut,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
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
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthSucceeded value) success,
    required TResult Function(_AuthError value) error,
    required TResult Function(_AuthIsSignedOut value) isSignedOut,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
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

/// @nodoc
abstract class _$AuthSucceededCopyWith<$Res> {
  factory _$AuthSucceededCopyWith(
          _AuthSucceeded value, $Res Function(_AuthSucceeded) then) =
      __$AuthSucceededCopyWithImpl<$Res>;
  $Res call({UserEntry userEntry});

  $UserEntryCopyWith<$Res> get userEntry;
}

/// @nodoc
class __$AuthSucceededCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthSucceededCopyWith<$Res> {
  __$AuthSucceededCopyWithImpl(
      _AuthSucceeded _value, $Res Function(_AuthSucceeded) _then)
      : super(_value, (v) => _then(v as _AuthSucceeded));

  @override
  _AuthSucceeded get _value => super._value as _AuthSucceeded;

  @override
  $Res call({
    Object? userEntry = freezed,
  }) {
    return _then(_AuthSucceeded(
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

class _$_AuthSucceeded implements _AuthSucceeded {
  const _$_AuthSucceeded(this.userEntry);

  @override
  final UserEntry userEntry;

  @override
  String toString() {
    return 'AuthState.success(userEntry: $userEntry)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _AuthSucceeded &&
            (identical(other.userEntry, userEntry) ||
                const DeepCollectionEquality()
                    .equals(other.userEntry, userEntry)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(userEntry);

  @JsonKey(ignore: true)
  @override
  _$AuthSucceededCopyWith<_AuthSucceeded> get copyWith =>
      __$AuthSucceededCopyWithImpl<_AuthSucceeded>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserEntry userEntry) success,
    required TResult Function() error,
    required TResult Function() isSignedOut,
  }) {
    return success(userEntry);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
  }) {
    return success?.call(userEntry);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(userEntry);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthSucceeded value) success,
    required TResult Function(_AuthError value) error,
    required TResult Function(_AuthIsSignedOut value) isSignedOut,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _AuthSucceeded implements AuthState {
  const factory _AuthSucceeded(UserEntry userEntry) = _$_AuthSucceeded;

  UserEntry get userEntry => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$AuthSucceededCopyWith<_AuthSucceeded> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$AuthErrorCopyWith<$Res> {
  factory _$AuthErrorCopyWith(
          _AuthError value, $Res Function(_AuthError) then) =
      __$AuthErrorCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthErrorCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthErrorCopyWith<$Res> {
  __$AuthErrorCopyWithImpl(_AuthError _value, $Res Function(_AuthError) _then)
      : super(_value, (v) => _then(v as _AuthError));

  @override
  _AuthError get _value => super._value as _AuthError;
}

/// @nodoc

class _$_AuthError implements _AuthError {
  const _$_AuthError();

  @override
  String toString() {
    return 'AuthState.error()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserEntry userEntry) success,
    required TResult Function() error,
    required TResult Function() isSignedOut,
  }) {
    return error();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
  }) {
    return error?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthSucceeded value) success,
    required TResult Function(_AuthError value) error,
    required TResult Function(_AuthIsSignedOut value) isSignedOut,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _AuthError implements AuthState {
  const factory _AuthError() = _$_AuthError;
}

/// @nodoc
abstract class _$AuthIsSignedOutCopyWith<$Res> {
  factory _$AuthIsSignedOutCopyWith(
          _AuthIsSignedOut value, $Res Function(_AuthIsSignedOut) then) =
      __$AuthIsSignedOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$AuthIsSignedOutCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$AuthIsSignedOutCopyWith<$Res> {
  __$AuthIsSignedOutCopyWithImpl(
      _AuthIsSignedOut _value, $Res Function(_AuthIsSignedOut) _then)
      : super(_value, (v) => _then(v as _AuthIsSignedOut));

  @override
  _AuthIsSignedOut get _value => super._value as _AuthIsSignedOut;
}

/// @nodoc

class _$_AuthIsSignedOut implements _AuthIsSignedOut {
  const _$_AuthIsSignedOut();

  @override
  String toString() {
    return 'AuthState.isSignedOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _AuthIsSignedOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(UserEntry userEntry) success,
    required TResult Function() error,
    required TResult Function() isSignedOut,
  }) {
    return isSignedOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
  }) {
    return isSignedOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(UserEntry userEntry)? success,
    TResult Function()? error,
    TResult Function()? isSignedOut,
    required TResult orElse(),
  }) {
    if (isSignedOut != null) {
      return isSignedOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthLoading value) loading,
    required TResult Function(_AuthSucceeded value) success,
    required TResult Function(_AuthError value) error,
    required TResult Function(_AuthIsSignedOut value) isSignedOut,
  }) {
    return isSignedOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
  }) {
    return isSignedOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthLoading value)? loading,
    TResult Function(_AuthSucceeded value)? success,
    TResult Function(_AuthError value)? error,
    TResult Function(_AuthIsSignedOut value)? isSignedOut,
    required TResult orElse(),
  }) {
    if (isSignedOut != null) {
      return isSignedOut(this);
    }
    return orElse();
  }
}

abstract class _AuthIsSignedOut implements AuthState {
  const factory _AuthIsSignedOut() = _$_AuthIsSignedOut;
}
