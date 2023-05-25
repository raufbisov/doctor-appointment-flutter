import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';

class GetActiveUserUsecase implements Usecase<User, NoParams> {
  final IAuthRepository repository;

  GetActiveUserUsecase(this.repository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return await repository.getActiveUser();
  }
}
