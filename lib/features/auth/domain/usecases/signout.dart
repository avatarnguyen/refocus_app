import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class SignOut implements UseCase<Unit, NoParams> {
  SignOut({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, Unit>> call(NoParams params) async {
    return repository.signOut();
  }
}
