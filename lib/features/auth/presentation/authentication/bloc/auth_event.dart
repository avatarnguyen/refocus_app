part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.signUp(
      {String? username, String? email, String? password}) = _AuthSignUpEvent;
  const factory AuthEvent.login({String? username, String? password}) =
      _AuthLoginEvent;
  const factory AuthEvent.signOut() = _AuthSignOutEvent;
}
