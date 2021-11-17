import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/core/usecases/usecase.dart';
import 'package:refocus_app/features/auth/domain/entities/user_entry.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class GetUser implements UseCase<UserEntry, NoParams> {
  GetUser({
    required this.repository,
  });

  final AuthRepository repository;

  @override
  Future<Either<Failure, UserEntry>> call(NoParams params) async {
    return repository.getAuthUser();
  }
}
