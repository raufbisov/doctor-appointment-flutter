import 'package:doctor_appointment/features/core/error/error_handler.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/authentication/data/datasources/auth_remote_datasource_interface.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';

class AuthRepository implements IAuthRepository {
  final IAuthRemoteDatasource remoteDatasource;
  final ErrorHandler errorHandler;

  AuthRepository({required this.remoteDatasource, required this.errorHandler});

  @override
  Future<Either<Failure, Map<String, dynamic>>> login(
      String email, String password) async {
    try {
      return Right(await remoteDatasource.login(email, password));
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> logout() async {
    try {
      return Right(await remoteDatasource.logout());
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, User>> getActiveUser() async {
    try {
      return Right(await remoteDatasource.getActiveUser());
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, bool>> checkAuth() async {
    try {
      return Right(await remoteDatasource.checkAuth());
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Success>> refreshToken() async {
    try {
      return Right(await remoteDatasource.refreshToken());
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, Success>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required int age,
  }) async {
    try {
      return Right(await remoteDatasource.register(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        age: age,
      ));
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }
}
