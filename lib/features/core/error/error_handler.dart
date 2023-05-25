import 'package:doctor_appointment/features/core/error/exception.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';

class ErrorHandler {
  Failure exceptionToFailure(Object? exception) {
    if (exception is ServerException) {
      return ServerFailure('Connection problem');
    } else if (exception is StorageException) {
      return StorageFailure('Storage problem');
    } else {
      return Failure('Unknown problem');
    }
  }
}
