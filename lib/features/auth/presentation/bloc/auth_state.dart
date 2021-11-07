part of 'auth_bloc.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.loading() = _AuthLoading;
  const factory AuthState.success(UserEntry userEntry) = _AuthSucceeded;
  const factory AuthState.error() = _AuthError;
  const factory AuthState.isSignedOut() = _AuthIsSignedOut;
}
