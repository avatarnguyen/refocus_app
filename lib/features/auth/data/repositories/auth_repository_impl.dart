import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';

import 'package:refocus_app/features/auth/data/datasources/aws_auth_data_source.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authDataSource,
  });
  final AuthDataSource authDataSource;

  final log = logger(AuthRepositoryImpl);
  @override
  Future<Either<Failure, UserEntry>> autoLoginAndGetUserEntry() async {
    try {
      final _user = await authDataSource.attemptAutoLogin();
      if (_user != null) {
        final _userEntry = UserEntry.fromJson(_user.toJson());
        return Right(_userEntry);
      } else {
        log.e(
            'Cannot login user automatically. User Sesstion might not be available');
        return Left(ServerFailure());
      }
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntry>> loginAndGetUserEntry(
      AuthCredential authCredential) async {
    try {
      final _user = await authDataSource.login(
        username: authCredential.username ?? '',
        password: authCredential.password ?? '',
      );
      if (_user != null) {
        final _userEntry = UserEntry.fromJson(_user.toJson());
        return Right(_userEntry);
      } else {
        log.e('Cannot find user!');
        return Left(ServerFailure());
      }
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await authDataSource.signOut();
      return const Right(unit);
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntry>> signUpAndGetUserEntry(
      AuthCredential authCredential) async {
    try {
      final _user = await authDataSource.signUp(
        username: authCredential.username ?? '',
        email: authCredential.email ?? '',
        password: authCredential.password ?? '',
      );
      if (_user != null) {
        final _userEntry = UserEntry.fromJson(_user.toJson());
        return Right(_userEntry);
      } else {
        log.e('Cannot find user!');
        return Left(ServerFailure());
      }
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    }
  }
}
