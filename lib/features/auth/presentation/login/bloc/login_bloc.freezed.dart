// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$LoginEventTearOff {
  const _$LoginEventTearOff();

  _LoginUsernameChanged usernameChanged(String username) {
    return _LoginUsernameChanged(
      username,
    );
  }

  _LoginPasswordChanged passwordChanged(String password) {
    return _LoginPasswordChanged(
      password,
    );
  }

  _LoginSubmitted submitted() {
    return const _LoginSubmitted();
  }
}

/// @nodoc
const $LoginEvent = _$LoginEventTearOff();

/// @nodoc
mixin _$LoginEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginUsernameChanged value) usernameChanged,
    required TResult Function(_LoginPasswordChanged value) passwordChanged,
    required TResult Function(_LoginSubmitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginEventCopyWith<$Res> {
  factory $LoginEventCopyWith(
          LoginEvent value, $Res Function(LoginEvent) then) =
      _$LoginEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$LoginEventCopyWithImpl<$Res> implements $LoginEventCopyWith<$Res> {
  _$LoginEventCopyWithImpl(this._value, this._then);

  final LoginEvent _value;
  // ignore: unused_field
  final $Res Function(LoginEvent) _then;
}

/// @nodoc
abstract class _$LoginUsernameChangedCopyWith<$Res> {
  factory _$LoginUsernameChangedCopyWith(_LoginUsernameChanged value,
          $Res Function(_LoginUsernameChanged) then) =
      __$LoginUsernameChangedCopyWithImpl<$Res>;
  $Res call({String username});
}

/// @nodoc
class __$LoginUsernameChangedCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res>
    implements _$LoginUsernameChangedCopyWith<$Res> {
  __$LoginUsernameChangedCopyWithImpl(
      _LoginUsernameChanged _value, $Res Function(_LoginUsernameChanged) _then)
      : super(_value, (v) => _then(v as _LoginUsernameChanged));

  @override
  _LoginUsernameChanged get _value => super._value as _LoginUsernameChanged;

  @override
  $Res call({
    Object? username = freezed,
  }) {
    return _then(_LoginUsernameChanged(
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginUsernameChanged implements _LoginUsernameChanged {
  const _$_LoginUsernameChanged(this.username);

  @override
  final String username;

  @override
  String toString() {
    return 'LoginEvent.usernameChanged(username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginUsernameChanged &&
            const DeepCollectionEquality().equals(other.username, username));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(username));

  @JsonKey(ignore: true)
  @override
  _$LoginUsernameChangedCopyWith<_LoginUsernameChanged> get copyWith =>
      __$LoginUsernameChangedCopyWithImpl<_LoginUsernameChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return usernameChanged(username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return usernameChanged?.call(username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (usernameChanged != null) {
      return usernameChanged(username);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginUsernameChanged value) usernameChanged,
    required TResult Function(_LoginPasswordChanged value) passwordChanged,
    required TResult Function(_LoginSubmitted value) submitted,
  }) {
    return usernameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
  }) {
    return usernameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (usernameChanged != null) {
      return usernameChanged(this);
    }
    return orElse();
  }
}

abstract class _LoginUsernameChanged implements LoginEvent {
  const factory _LoginUsernameChanged(String username) =
      _$_LoginUsernameChanged;

  String get username;
  @JsonKey(ignore: true)
  _$LoginUsernameChangedCopyWith<_LoginUsernameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoginPasswordChangedCopyWith<$Res> {
  factory _$LoginPasswordChangedCopyWith(_LoginPasswordChanged value,
          $Res Function(_LoginPasswordChanged) then) =
      __$LoginPasswordChangedCopyWithImpl<$Res>;
  $Res call({String password});
}

/// @nodoc
class __$LoginPasswordChangedCopyWithImpl<$Res>
    extends _$LoginEventCopyWithImpl<$Res>
    implements _$LoginPasswordChangedCopyWith<$Res> {
  __$LoginPasswordChangedCopyWithImpl(
      _LoginPasswordChanged _value, $Res Function(_LoginPasswordChanged) _then)
      : super(_value, (v) => _then(v as _LoginPasswordChanged));

  @override
  _LoginPasswordChanged get _value => super._value as _LoginPasswordChanged;

  @override
  $Res call({
    Object? password = freezed,
  }) {
    return _then(_LoginPasswordChanged(
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginPasswordChanged implements _LoginPasswordChanged {
  const _$_LoginPasswordChanged(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'LoginEvent.passwordChanged(password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginPasswordChanged &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$LoginPasswordChangedCopyWith<_LoginPasswordChanged> get copyWith =>
      __$LoginPasswordChangedCopyWithImpl<_LoginPasswordChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return passwordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return passwordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginUsernameChanged value) usernameChanged,
    required TResult Function(_LoginPasswordChanged value) passwordChanged,
    required TResult Function(_LoginSubmitted value) submitted,
  }) {
    return passwordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
  }) {
    return passwordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(this);
    }
    return orElse();
  }
}

abstract class _LoginPasswordChanged implements LoginEvent {
  const factory _LoginPasswordChanged(String password) =
      _$_LoginPasswordChanged;

  String get password;
  @JsonKey(ignore: true)
  _$LoginPasswordChangedCopyWith<_LoginPasswordChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$LoginSubmittedCopyWith<$Res> {
  factory _$LoginSubmittedCopyWith(
          _LoginSubmitted value, $Res Function(_LoginSubmitted) then) =
      __$LoginSubmittedCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoginSubmittedCopyWithImpl<$Res> extends _$LoginEventCopyWithImpl<$Res>
    implements _$LoginSubmittedCopyWith<$Res> {
  __$LoginSubmittedCopyWithImpl(
      _LoginSubmitted _value, $Res Function(_LoginSubmitted) _then)
      : super(_value, (v) => _then(v as _LoginSubmitted));

  @override
  _LoginSubmitted get _value => super._value as _LoginSubmitted;
}

/// @nodoc

class _$_LoginSubmitted implements _LoginSubmitted {
  const _$_LoginSubmitted();

  @override
  String toString() {
    return 'LoginEvent.submitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _LoginSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginUsernameChanged value) usernameChanged,
    required TResult Function(_LoginPasswordChanged value) passwordChanged,
    required TResult Function(_LoginSubmitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginUsernameChanged value)? usernameChanged,
    TResult Function(_LoginPasswordChanged value)? passwordChanged,
    TResult Function(_LoginSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _LoginSubmitted implements LoginEvent {
  const factory _LoginSubmitted() = _$_LoginSubmitted;
}

/// @nodoc
class _$LoginStateTearOff {
  const _$LoginStateTearOff();

  _LoginStateCurrent current(
      {FormzStatus? status, Username? username, Password? password}) {
    return _LoginStateCurrent(
      status: status,
      username: username,
      password: password,
    );
  }
}

/// @nodoc
const $LoginState = _$LoginStateTearOff();

/// @nodoc
mixin _$LoginState {
  FormzStatus? get status => throw _privateConstructorUsedError;
  Username? get username => throw _privateConstructorUsedError;
  Password? get password => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            FormzStatus? status, Username? username, Password? password)
        current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            FormzStatus? status, Username? username, Password? password)?
        current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            FormzStatus? status, Username? username, Password? password)?
        current,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginStateCurrent value) current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginStateCurrent value)? current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginStateCurrent value)? current,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginStateCopyWith<LoginState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginStateCopyWith<$Res> {
  factory $LoginStateCopyWith(
          LoginState value, $Res Function(LoginState) then) =
      _$LoginStateCopyWithImpl<$Res>;
  $Res call({FormzStatus? status, Username? username, Password? password});
}

/// @nodoc
class _$LoginStateCopyWithImpl<$Res> implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._value, this._then);

  final LoginState _value;
  // ignore: unused_field
  final $Res Function(LoginState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzStatus?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password?,
    ));
  }
}

/// @nodoc
abstract class _$LoginStateCurrentCopyWith<$Res>
    implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCurrentCopyWith(
          _LoginStateCurrent value, $Res Function(_LoginStateCurrent) then) =
      __$LoginStateCurrentCopyWithImpl<$Res>;
  @override
  $Res call({FormzStatus? status, Username? username, Password? password});
}

/// @nodoc
class __$LoginStateCurrentCopyWithImpl<$Res>
    extends _$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCurrentCopyWith<$Res> {
  __$LoginStateCurrentCopyWithImpl(
      _LoginStateCurrent _value, $Res Function(_LoginStateCurrent) _then)
      : super(_value, (v) => _then(v as _LoginStateCurrent));

  @override
  _LoginStateCurrent get _value => super._value as _LoginStateCurrent;

  @override
  $Res call({
    Object? status = freezed,
    Object? username = freezed,
    Object? password = freezed,
  }) {
    return _then(_LoginStateCurrent(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzStatus?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password?,
    ));
  }
}

/// @nodoc

class _$_LoginStateCurrent implements _LoginStateCurrent {
  const _$_LoginStateCurrent({this.status, this.username, this.password});

  @override
  final FormzStatus? status;
  @override
  final Username? username;
  @override
  final Password? password;

  @override
  String toString() {
    return 'LoginState.current(status: $status, username: $username, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LoginStateCurrent &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.username, username) &&
            const DeepCollectionEquality().equals(other.password, password));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(username),
      const DeepCollectionEquality().hash(password));

  @JsonKey(ignore: true)
  @override
  _$LoginStateCurrentCopyWith<_LoginStateCurrent> get copyWith =>
      __$LoginStateCurrentCopyWithImpl<_LoginStateCurrent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            FormzStatus? status, Username? username, Password? password)
        current,
  }) {
    return current(status, username, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(
            FormzStatus? status, Username? username, Password? password)?
        current,
  }) {
    return current?.call(status, username, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            FormzStatus? status, Username? username, Password? password)?
        current,
    required TResult orElse(),
  }) {
    if (current != null) {
      return current(status, username, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_LoginStateCurrent value) current,
  }) {
    return current(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_LoginStateCurrent value)? current,
  }) {
    return current?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_LoginStateCurrent value)? current,
    required TResult orElse(),
  }) {
    if (current != null) {
      return current(this);
    }
    return orElse();
  }
}

abstract class _LoginStateCurrent implements LoginState {
  const factory _LoginStateCurrent(
      {FormzStatus? status,
      Username? username,
      Password? password}) = _$_LoginStateCurrent;

  @override
  FormzStatus? get status;
  @override
  Username? get username;
  @override
  Password? get password;
  @override
  @JsonKey(ignore: true)
  _$LoginStateCurrentCopyWith<_LoginStateCurrent> get copyWith =>
      throw _privateConstructorUsedError;
}
