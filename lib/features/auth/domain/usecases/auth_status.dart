import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:refocus_app/core/error/failures.dart';
import 'package:refocus_app/enum/authetication_status.dart';
import 'package:refocus_app/features/auth/domain/repositories/auth_repository.dart';

@lazySingleton
class AuthStatus {
  AuthStatus({required this.repository});

  final AuthRepository repository;

  Stream<Either<Failure, AuthenticationStatus>> call() {
    print('[AuthStatus]: AuthStatus Stream Called');
    return repository.getAuthStatus();
  }
}
