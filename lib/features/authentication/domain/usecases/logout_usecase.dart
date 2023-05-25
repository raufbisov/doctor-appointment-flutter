import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';

class LogoutUsecase implements Usecase<Map<String, dynamic>, NoParams> {
  final IAuthRepository repository;

  LogoutUsecase(this.repository);
  @override
  Future<Either<Failure, Map<String, dynamic>>> call(NoParams params) async {
    return await repository.logout();
  }
}
