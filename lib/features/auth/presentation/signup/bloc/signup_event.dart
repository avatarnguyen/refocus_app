part of 'signup_bloc.dart';

@freezed
class SignupEvent with _$SignupEvent {
  const factory SignupEvent.usernameChanged(String username) =
      _SignupUsernameChanged;
  const factory SignupEvent.emailChanged(String email) = _SignupEmailChanged;
  const factory SignupEvent.passwordChanged(String password) =
      _SignupPasswordChanged;
  const factory SignupEvent.submitted() = _SignupSubmitted;
}
