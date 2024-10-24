import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

// General Failures
class ServerFailure extends Failure {}

class AuthFailure extends Failure {}

class ArgumentFailure extends Failure {}

class CacheFailure extends Failure {}
