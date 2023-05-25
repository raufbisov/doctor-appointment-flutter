import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/core/usecase.dart';

class RefreshTokenUsecase extends Usecase<Success, NoParams> {
  final IAuthRepository repository;

  RefreshTokenUsecase(this.repository);

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return await repository.refreshToken();
  }
}
