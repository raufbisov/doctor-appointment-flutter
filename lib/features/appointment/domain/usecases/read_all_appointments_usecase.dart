import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_appointment/features/appointment/domain/repositories/appointment_repository_interface.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/core/usecase.dart';

class ReadAllAppointmentsUsecase
    implements Usecase<List<Appointment>, NoParams> {
  final IAppointmentRepository repository;

  ReadAllAppointmentsUsecase(this.repository);

  @override
  Future<Either<Failure, List<Appointment>>> call(NoParams params) async {
    return await repository.readAllAppointments();
  }
}
