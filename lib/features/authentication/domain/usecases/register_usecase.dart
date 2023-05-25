import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/authentication/domain/repositories/auth_repository_interface.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:equatable/equatable.dart';

class RegisterUsecase implements Usecase<Success, RegisterParams> {
  final IAuthRepository repository;

  RegisterUsecase(this.repository);
  @override
  Future<Either<Failure, Success>> call(RegisterParams params) async {
    return await repository.register(
      age: params.age,
      email: params.email,
      firstName: params.firstName,
      lastName: params.lastName,
      password: params.password,
      phoneNumber: params.phoneNumber,
    );
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final int age;
  final Gender gender;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.age,
    required this.gender,
  });

  @override
  List<Object?> get props => [];
}
