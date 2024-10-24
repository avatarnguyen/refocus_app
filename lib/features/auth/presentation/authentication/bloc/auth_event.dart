part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.authenticationChanged(AuthenticationStatus status) =
      _AuthenticationStatusChanged;
  const factory AuthEvent.signOutRequested() = _AuthSignOutRequested;
  const factory AuthEvent.autoSignInAttempt() = _AuthAutoSignInAttempt;
  const factory AuthEvent.confirmAccount({
    String? username,
    String? password,
    String? confirmCode,
  }) = _AuthConfirmAccount;
}
