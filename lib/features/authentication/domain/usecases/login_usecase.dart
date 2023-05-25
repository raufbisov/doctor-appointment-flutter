import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:equatable/equatable.dart';

class LoginUsecase implements Usecase<Map<String, dynamic>, LoginParams> {
  final IAuthRepository userRepository;

  LoginUsecase(this.userRepository);

  @override
  Future<Either<Failure, Map<String, dynamic>>> call(LoginParams params) async {
    return await userRepository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object?> get props => [];
}
