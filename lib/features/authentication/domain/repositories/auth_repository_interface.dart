import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';

abstract class IAuthRepository {
  Future<Either<Failure, Map<String, dynamic>>> login(
      String email, String password);
  Future<Either<Failure, Map<String, dynamic>>> logout();
  Future<Either<Failure, User>> getActiveUser();
  Future<Either<Failure, bool>> checkAuth();
  Future<Either<Failure, Success>> refreshToken();
  Future<Either<Failure, Success>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required int age,
  });
}
