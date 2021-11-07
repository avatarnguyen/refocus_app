import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntry>> signUpAndGetUserEntry(
    AuthCredential authCredential,
  );
  Future<Either<Failure, UserEntry>> loginAndGetUserEntry(
    AuthCredential authCredential,
  );
  Future<Either<Failure, UserEntry>> autoLoginAndGetUserEntry();
  Future<Either<Failure, Unit>> signOut();
}
