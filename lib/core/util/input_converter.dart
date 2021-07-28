import 'package:dartz/dartz.dart';
import 'package:refocus_app/core/error/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String str) {
    // TODO: Implement this later for Date Filtering
    return Left(InvalidInputFailure());
  }
}

class InvalidInputFailure extends Failure {}
