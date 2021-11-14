part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.usernameChanged(String username) =
      _LoginUsernameChanged;
  const factory LoginEvent.passwordChanged(String password) =
      _LoginPasswordChanged;
  const factory LoginEvent.submitted() = _LoginSubmitted;
}
