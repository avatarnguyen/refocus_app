import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/enum/authetication_status.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';

abstract class AuthRepository {
  Future<Either<Failure, Unit>> authSignUp(
    AuthCredential authCredential,
  );
  Future<Either<Failure, Unit>> authLogin(
    AuthCredential authCredential,
  );
  Future<Either<Failure, Unit>> authAutoLogin();
  Future<Either<Failure, Unit>> authSignOut();
  Future<Either<Failure, bool>> authConfirmedAccount({
    required String username,
    required String confirmationCode,
  });
  Future<Either<Failure, UserEntry>> getAuthUser();
  Stream<Either<Failure, AuthenticationStatus>> getAuthStatus();
}
