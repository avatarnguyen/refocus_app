import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/exceptions.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/util/helpers/logging.dart';
import 'package:refocus_app/enum/authetication_status.dart';

import 'package:refocus_app/features/auth/data/datasources/aws_auth_data_source.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:rxdart/subjects.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required this.authDataSource,
  });
  final AuthDataSource authDataSource;

  final log = logger(AuthRepositoryImpl);
  @override
  Future<Either<Failure, bool>> authAutoLogin() async {
    try {
      final result = await authDataSource.attemptAutoLogin();
      return Right(result);
    } on ServerException {
      log.e('Cannot access Remote Datasource');
      return Left(ServerFailure());
    } on NotConfirmedException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> authLogin(AuthCredential authCredential) async {
    try {
      final result = await authDataSource.login(
        username: authCredential.username ?? '',
        password: authCredential.password ?? '',
      );
      return Right(result);
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    } on NotConfirmedException {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> authSignOut() async {
    try {
      await authDataSource.signOut();
      return const Right(unit);
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> authSignUp(
      AuthCredential authCredential) async {
    try {
      await authDataSource.signUp(
        username: authCredential.username ?? '',
        email: authCredential.email ?? '',
        password: authCredential.password ?? '',
      );
      return const Right(unit);
    } on ServerException {
      log.e('Cannot access AWS');
      return Left(ServerFailure());
    }
  }

  @override
  Stream<Either<Failure, AuthenticationStatus>> getAuthStatus() async* {
    // var currentStatus = const Right<Failure, AuthenticationStatus>(
    //     AuthenticationStatus.unknown);
    // ignore: omit_local_variable_types
    final BehaviorSubject<Either<Failure, AuthenticationStatus>> _authStatus =
        BehaviorSubject.seeded(const Right<Failure, AuthenticationStatus>(
            AuthenticationStatus.unknown));
    try {
      final _result = authDataSource.getAuthStatus();
      // log.d(_result);
      _result.listen((status) {
        log.i('New Status Received: $status');
        // currentStatus = Right<Failure, AuthenticationStatus>(status);
        _authStatus.add(Right<Failure, AuthenticationStatus>(status));
      });

      yield _authStatus.stream.value;
    } on ServerException catch (e) {
      log.e('Cannot access AWS: $e');
      yield Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> authConfirmedAccount(
      {required String username, required String confirmationCode}) async {
    try {
      final _isConfirmed = await authDataSource.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );

      return Right(_isConfirmed);
    } on ServerException {
      log.e('Cannot access AWS Server');
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserEntry>> getAuthUser() async {
    try {
      final _user = await authDataSource.getUserModelFromDataStore();
      if (_user != null) {
        final _userEntry = UserEntry.fromJson(_user.toJson());
        return Right(_userEntry);
      } else {
        log.d('No User Found');
        return Left(AuthFailure());
      }
    } on ServerException catch (e) {
      log.e('Cannot access Remote Datasoure: $e');
      return Left(ServerFailure());
    }
  }
}
