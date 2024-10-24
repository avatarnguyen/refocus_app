import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/auth/domain/entities/auth_credential.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';

@lazySingleton
class SignUp implements UseCase<Unit, AuthParams> {
  SignUp({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(AuthParams params) async {
    final _auth = AuthCredential(
      email: params.email,
      password: params.password,
      username: params.username,
    );
    return repository.authSignUp(_auth);
  }
}
