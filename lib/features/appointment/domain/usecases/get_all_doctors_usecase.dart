import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/appointment/domain/repositories/appointment_repository_interface.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/core/usecase.dart';

class GetAllDoctorsUsecase implements Usecase<List<User>, NoParams> {
  final IAppointmentRepository repository;

  GetAllDoctorsUsecase(this.repository);
  @override
  Future<Either<Failure, List<User>>> call(NoParams params) async {
    return await repository.getAllDoctors();
  }
}
