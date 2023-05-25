import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/create_appointment_usecase.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';

abstract class IAppointmentRepository {
  Future<Either<Failure, Success>> createAppointment(
      CreateAppointmentParams params);
  Future<Either<Failure, List<Appointment>>> readAllAppointments();
  Future<Either<Failure, List<User>>> getAllDoctors();
}
