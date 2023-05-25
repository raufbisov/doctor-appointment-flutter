import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';

class CheckAuthUsecase implements Usecase<bool, NoParams> {
  final IAuthRepository repository;

  CheckAuthUsecase(this.repository);
  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.checkAuth();
  }
}
