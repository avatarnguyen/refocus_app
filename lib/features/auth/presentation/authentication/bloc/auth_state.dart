part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.unknown() = _AuthUnknown;
  const factory AuthState.authenticated(UserEntry userEntry) =
      _AuthAuthenticated;
  const factory AuthState.unauthenticated() = _AuthUnauthenticated;
  const factory AuthState.loading() = _AuthLoading;
  const factory AuthState.confirmationRequired() = _AuthConfirmationRequired;
}
