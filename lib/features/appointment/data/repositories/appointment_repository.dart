import 'package:dartz/dartz.dart';
import 'package:doctor_appointment/features/appointment/data/datasources/appointment_remote_datasource.dart';
import 'package:doctor_appointment/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_appointment/features/appointment/domain/repositories/appointment_repository_interface.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/core/error/error_handler.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/create_appointment_usecase.dart';

class AppointmentRepository implements IAppointmentRepository {
  final IAppointmentRemoteDatasource datasource;
  final ErrorHandler errorHandler;

  AppointmentRepository({required this.datasource, required this.errorHandler});

  @override
  Future<Either<Failure, Success>> createAppointment(
      CreateAppointmentParams params) async {
    try {
      return Right(await datasource.createAppointment(params));
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<Appointment>>> readAllAppointments() async {
    try {
      return Right(await datasource.readAllAppointments());
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllDoctors() async {
    try {
      return Right(await datasource.getAllDoctors());
    } catch (e) {
      return Left(errorHandler.exceptionToFailure(e));
    }
  }
}
