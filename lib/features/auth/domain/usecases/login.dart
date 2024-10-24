import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';

/// Call AuthRepository Login Methods
/// login with username and password
/// attempt to login automatically in case username and password is not given
@lazySingleton
class Login implements UseCase<bool, AuthParams> {
  Login({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(AuthParams params) async {
    if (params.username != null && params.password != null) {
      final _auth = AuthCredential(
        // email: params.email,
        password: params.password,
        username: params.username,
      );
      return repository.authLogin(_auth);
    } else {
      return repository.authAutoLogin();
    }
  }
}
