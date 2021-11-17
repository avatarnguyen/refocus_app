// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'signup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SignupEventTearOff {
  const _$SignupEventTearOff();

  _SignupUsernameChanged usernameChanged(String username) {
    return _SignupUsernameChanged(
      username,
    );
  }

  _SignupEmailChanged emailChanged(String email) {
    return _SignupEmailChanged(
      email,
    );
  }

  _SignupPasswordChanged passwordChanged(String password) {
    return _SignupPasswordChanged(
      password,
    );
  }

  _SignupSubmitted submitted() {
    return const _SignupSubmitted();
  }
}

/// @nodoc
const $SignupEvent = _$SignupEventTearOff();

/// @nodoc
mixin _$SignupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignupUsernameChanged value) usernameChanged,
    required TResult Function(_SignupEmailChanged value) emailChanged,
    required TResult Function(_SignupPasswordChanged value) passwordChanged,
    required TResult Function(_SignupSubmitted value) submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupEventCopyWith<$Res> {
  factory $SignupEventCopyWith(
          SignupEvent value, $Res Function(SignupEvent) then) =
      _$SignupEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$SignupEventCopyWithImpl<$Res> implements $SignupEventCopyWith<$Res> {
  _$SignupEventCopyWithImpl(this._value, this._then);

  final SignupEvent _value;
  // ignore: unused_field
  final $Res Function(SignupEvent) _then;
}

/// @nodoc
abstract class _$SignupUsernameChangedCopyWith<$Res> {
  factory _$SignupUsernameChangedCopyWith(_SignupUsernameChanged value,
          $Res Function(_SignupUsernameChanged) then) =
      __$SignupUsernameChangedCopyWithImpl<$Res>;
  $Res call({String username});
}

/// @nodoc
class __$SignupUsernameChangedCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res>
    implements _$SignupUsernameChangedCopyWith<$Res> {
  __$SignupUsernameChangedCopyWithImpl(_SignupUsernameChanged _value,
      $Res Function(_SignupUsernameChanged) _then)
      : super(_value, (v) => _then(v as _SignupUsernameChanged));

  @override
  _SignupUsernameChanged get _value => super._value as _SignupUsernameChanged;

  @override
  $Res call({
    Object? username = freezed,
  }) {
    return _then(_SignupUsernameChanged(
      username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SignupUsernameChanged implements _SignupUsernameChanged {
  const _$_SignupUsernameChanged(this.username);

  @override
  final String username;

  @override
  String toString() {
    return 'SignupEvent.usernameChanged(username: $username)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SignupUsernameChanged &&
            (identical(other.username, username) ||
                const DeepCollectionEquality()
                    .equals(other.username, username)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(username);

  @JsonKey(ignore: true)
  @override
  _$SignupUsernameChangedCopyWith<_SignupUsernameChanged> get copyWith =>
      __$SignupUsernameChangedCopyWithImpl<_SignupUsernameChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return usernameChanged(username);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return usernameChanged?.call(username);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
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
    required TResult Function(_SignupUsernameChanged value) usernameChanged,
    required TResult Function(_SignupEmailChanged value) emailChanged,
    required TResult Function(_SignupPasswordChanged value) passwordChanged,
    required TResult Function(_SignupSubmitted value) submitted,
  }) {
    return usernameChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
  }) {
    return usernameChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (usernameChanged != null) {
      return usernameChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupUsernameChanged implements SignupEvent {
  const factory _SignupUsernameChanged(String username) =
      _$_SignupUsernameChanged;

  String get username => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SignupUsernameChangedCopyWith<_SignupUsernameChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SignupEmailChangedCopyWith<$Res> {
  factory _$SignupEmailChangedCopyWith(
          _SignupEmailChanged value, $Res Function(_SignupEmailChanged) then) =
      __$SignupEmailChangedCopyWithImpl<$Res>;
  $Res call({String email});
}

/// @nodoc
class __$SignupEmailChangedCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res>
    implements _$SignupEmailChangedCopyWith<$Res> {
  __$SignupEmailChangedCopyWithImpl(
      _SignupEmailChanged _value, $Res Function(_SignupEmailChanged) _then)
      : super(_value, (v) => _then(v as _SignupEmailChanged));

  @override
  _SignupEmailChanged get _value => super._value as _SignupEmailChanged;

  @override
  $Res call({
    Object? email = freezed,
  }) {
    return _then(_SignupEmailChanged(
      email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SignupEmailChanged implements _SignupEmailChanged {
  const _$_SignupEmailChanged(this.email);

  @override
  final String email;

  @override
  String toString() {
    return 'SignupEvent.emailChanged(email: $email)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SignupEmailChanged &&
            (identical(other.email, email) ||
                const DeepCollectionEquality().equals(other.email, email)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(email);

  @JsonKey(ignore: true)
  @override
  _$SignupEmailChangedCopyWith<_SignupEmailChanged> get copyWith =>
      __$SignupEmailChangedCopyWithImpl<_SignupEmailChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return emailChanged(email);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return emailChanged?.call(email);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(email);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignupUsernameChanged value) usernameChanged,
    required TResult Function(_SignupEmailChanged value) emailChanged,
    required TResult Function(_SignupPasswordChanged value) passwordChanged,
    required TResult Function(_SignupSubmitted value) submitted,
  }) {
    return emailChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
  }) {
    return emailChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (emailChanged != null) {
      return emailChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupEmailChanged implements SignupEvent {
  const factory _SignupEmailChanged(String email) = _$_SignupEmailChanged;

  String get email => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SignupEmailChangedCopyWith<_SignupEmailChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SignupPasswordChangedCopyWith<$Res> {
  factory _$SignupPasswordChangedCopyWith(_SignupPasswordChanged value,
          $Res Function(_SignupPasswordChanged) then) =
      __$SignupPasswordChangedCopyWithImpl<$Res>;
  $Res call({String password});
}

/// @nodoc
class __$SignupPasswordChangedCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res>
    implements _$SignupPasswordChangedCopyWith<$Res> {
  __$SignupPasswordChangedCopyWithImpl(_SignupPasswordChanged _value,
      $Res Function(_SignupPasswordChanged) _then)
      : super(_value, (v) => _then(v as _SignupPasswordChanged));

  @override
  _SignupPasswordChanged get _value => super._value as _SignupPasswordChanged;

  @override
  $Res call({
    Object? password = freezed,
  }) {
    return _then(_SignupPasswordChanged(
      password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_SignupPasswordChanged implements _SignupPasswordChanged {
  const _$_SignupPasswordChanged(this.password);

  @override
  final String password;

  @override
  String toString() {
    return 'SignupEvent.passwordChanged(password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SignupPasswordChanged &&
            (identical(other.password, password) ||
                const DeepCollectionEquality()
                    .equals(other.password, password)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$SignupPasswordChangedCopyWith<_SignupPasswordChanged> get copyWith =>
      __$SignupPasswordChangedCopyWithImpl<_SignupPasswordChanged>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return passwordChanged(password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return passwordChanged?.call(password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
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
    required TResult Function(_SignupUsernameChanged value) usernameChanged,
    required TResult Function(_SignupEmailChanged value) emailChanged,
    required TResult Function(_SignupPasswordChanged value) passwordChanged,
    required TResult Function(_SignupSubmitted value) submitted,
  }) {
    return passwordChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
  }) {
    return passwordChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (passwordChanged != null) {
      return passwordChanged(this);
    }
    return orElse();
  }
}

abstract class _SignupPasswordChanged implements SignupEvent {
  const factory _SignupPasswordChanged(String password) =
      _$_SignupPasswordChanged;

  String get password => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  _$SignupPasswordChangedCopyWith<_SignupPasswordChanged> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$SignupSubmittedCopyWith<$Res> {
  factory _$SignupSubmittedCopyWith(
          _SignupSubmitted value, $Res Function(_SignupSubmitted) then) =
      __$SignupSubmittedCopyWithImpl<$Res>;
}

/// @nodoc
class __$SignupSubmittedCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res>
    implements _$SignupSubmittedCopyWith<$Res> {
  __$SignupSubmittedCopyWithImpl(
      _SignupSubmitted _value, $Res Function(_SignupSubmitted) _then)
      : super(_value, (v) => _then(v as _SignupSubmitted));

  @override
  _SignupSubmitted get _value => super._value as _SignupSubmitted;
}

/// @nodoc

class _$_SignupSubmitted implements _SignupSubmitted {
  const _$_SignupSubmitted();

  @override
  String toString() {
    return 'SignupEvent.submitted()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _SignupSubmitted);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String username) usernameChanged,
    required TResult Function(String email) emailChanged,
    required TResult Function(String password) passwordChanged,
    required TResult Function() submitted,
  }) {
    return submitted();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
    TResult Function(String password)? passwordChanged,
    TResult Function()? submitted,
  }) {
    return submitted?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String username)? usernameChanged,
    TResult Function(String email)? emailChanged,
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
    required TResult Function(_SignupUsernameChanged value) usernameChanged,
    required TResult Function(_SignupEmailChanged value) emailChanged,
    required TResult Function(_SignupPasswordChanged value) passwordChanged,
    required TResult Function(_SignupSubmitted value) submitted,
  }) {
    return submitted(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
  }) {
    return submitted?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupUsernameChanged value)? usernameChanged,
    TResult Function(_SignupEmailChanged value)? emailChanged,
    TResult Function(_SignupPasswordChanged value)? passwordChanged,
    TResult Function(_SignupSubmitted value)? submitted,
    required TResult orElse(),
  }) {
    if (submitted != null) {
      return submitted(this);
    }
    return orElse();
  }
}

abstract class _SignupSubmitted implements SignupEvent {
  const factory _SignupSubmitted() = _$_SignupSubmitted;
}

/// @nodoc
class _$SignupStateTearOff {
  const _$SignupStateTearOff();

  _SignupStateCurrent current(
      {FormzStatus? status,
      Username? username,
      Email? email,
      Password? password}) {
    return _SignupStateCurrent(
      status: status,
      username: username,
      email: email,
      password: password,
    );
  }
}

/// @nodoc
const $SignupState = _$SignupStateTearOff();

/// @nodoc
mixin _$SignupState {
  FormzStatus? get status => throw _privateConstructorUsedError;
  Username? get username => throw _privateConstructorUsedError;
  Email? get email => throw _privateConstructorUsedError;
  Password? get password => throw _privateConstructorUsedError;

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FormzStatus? status, Username? username,
            Email? email, Password? password)
        current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(FormzStatus? status, Username? username, Email? email,
            Password? password)?
        current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FormzStatus? status, Username? username, Email? email,
            Password? password)?
        current,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignupStateCurrent value) current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupStateCurrent value)? current,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupStateCurrent value)? current,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupStateCopyWith<SignupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupStateCopyWith<$Res> {
  factory $SignupStateCopyWith(
          SignupState value, $Res Function(SignupState) then) =
      _$SignupStateCopyWithImpl<$Res>;
  $Res call(
      {FormzStatus? status,
      Username? username,
      Email? email,
      Password? password});
}

/// @nodoc
class _$SignupStateCopyWithImpl<$Res> implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._value, this._then);

  final SignupState _value;
  // ignore: unused_field
  final $Res Function(SignupState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? username = freezed,
    Object? email = freezed,
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
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Email?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password?,
    ));
  }
}

/// @nodoc
abstract class _$SignupStateCurrentCopyWith<$Res>
    implements $SignupStateCopyWith<$Res> {
  factory _$SignupStateCurrentCopyWith(
          _SignupStateCurrent value, $Res Function(_SignupStateCurrent) then) =
      __$SignupStateCurrentCopyWithImpl<$Res>;
  @override
  $Res call(
      {FormzStatus? status,
      Username? username,
      Email? email,
      Password? password});
}

/// @nodoc
class __$SignupStateCurrentCopyWithImpl<$Res>
    extends _$SignupStateCopyWithImpl<$Res>
    implements _$SignupStateCurrentCopyWith<$Res> {
  __$SignupStateCurrentCopyWithImpl(
      _SignupStateCurrent _value, $Res Function(_SignupStateCurrent) _then)
      : super(_value, (v) => _then(v as _SignupStateCurrent));

  @override
  _SignupStateCurrent get _value => super._value as _SignupStateCurrent;

  @override
  $Res call({
    Object? status = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? password = freezed,
  }) {
    return _then(_SignupStateCurrent(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as FormzStatus?,
      username: username == freezed
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as Username?,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as Email?,
      password: password == freezed
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as Password?,
    ));
  }
}

/// @nodoc

class _$_SignupStateCurrent implements _SignupStateCurrent {
  const _$_SignupStateCurrent(
      {this.status, this.username, this.email, this.password});

  @override
  final FormzStatus? status;
  @override
  final Username? username;
  @override
  final Email? email;
  @override
  final Password? password;

  @override
  String toString() {
    return 'SignupState.current(status: $status, username: $username, email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _SignupStateCurrent &&
            (identical(other.status, status) ||
                const DeepCollectionEquality().equals(other.status, status)) &&
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
      const DeepCollectionEquality().hash(status) ^
      const DeepCollectionEquality().hash(username) ^
      const DeepCollectionEquality().hash(email) ^
      const DeepCollectionEquality().hash(password);

  @JsonKey(ignore: true)
  @override
  _$SignupStateCurrentCopyWith<_SignupStateCurrent> get copyWith =>
      __$SignupStateCurrentCopyWithImpl<_SignupStateCurrent>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(FormzStatus? status, Username? username,
            Email? email, Password? password)
        current,
  }) {
    return current(status, username, email, password);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(FormzStatus? status, Username? username, Email? email,
            Password? password)?
        current,
  }) {
    return current?.call(status, username, email, password);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(FormzStatus? status, Username? username, Email? email,
            Password? password)?
        current,
    required TResult orElse(),
  }) {
    if (current != null) {
      return current(status, username, email, password);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_SignupStateCurrent value) current,
  }) {
    return current(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_SignupStateCurrent value)? current,
  }) {
    return current?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_SignupStateCurrent value)? current,
    required TResult orElse(),
  }) {
    if (current != null) {
      return current(this);
    }
    return orElse();
  }
}

abstract class _SignupStateCurrent implements SignupState {
  const factory _SignupStateCurrent(
      {FormzStatus? status,
      Username? username,
      Email? email,
      Password? password}) = _$_SignupStateCurrent;

  @override
  FormzStatus? get status => throw _privateConstructorUsedError;
  @override
  Username? get username => throw _privateConstructorUsedError;
  @override
  Email? get email => throw _privateConstructorUsedError;
  @override
  Password? get password => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SignupStateCurrentCopyWith<_SignupStateCurrent> get copyWith =>
      throw _privateConstructorUsedError;
}
