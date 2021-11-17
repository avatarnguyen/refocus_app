part of 'signup_bloc.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState.current({
    FormzStatus? status,
    Username? username,
    Email? email,
    Password? password,
  }) = _SignupStateCurrent;
}
