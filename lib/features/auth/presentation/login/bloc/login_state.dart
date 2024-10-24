part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.current({
    FormzStatus? status,
    Username? username,
    Password? password,
  }) = _LoginStateCurrent;
}
