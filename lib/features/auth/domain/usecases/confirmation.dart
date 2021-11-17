import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:refocus_app/features/auth/domain/usecases/auth_params.dart';

@lazySingleton
class Confirmation implements UseCase<bool, AuthParams> {
  Confirmation({required this.repository});

  final AuthRepository repository;

  @override
  Future<Either<Failure, bool>> call(AuthParams params) async {
    return repository.authConfirmedAccount(
      username: params.username ?? '',
      confirmationCode: params.confirmationCode ?? '',
    );
  }
}
