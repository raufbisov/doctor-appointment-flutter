import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/appointment/domain/repositories/appointment_repository_interface.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:equatable/equatable.dart';

class CreateAppointmentUsecase
    implements Usecase<Success, CreateAppointmentParams> {
  final IAppointmentRepository repository;
  CreateAppointmentUsecase(this.repository);

  @override
  Future<Either<Failure, Success>> call(CreateAppointmentParams params) async {
    return await repository.createAppointment(params);
  }
}

class CreateAppointmentParams extends Equatable {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String employeeId;
  final String patientId;

  const CreateAppointmentParams({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.employeeId,
    required this.patientId,
  });

  @override
  List<Object?> get props => [];
}
