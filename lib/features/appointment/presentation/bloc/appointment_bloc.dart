import 'package:doctor_appointment/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/create_appointment_usecase.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/get_all_doctors_usecase.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/read_all_appointments_usecase.dart';
import 'package:doctor_appointment/features/core/usecase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../authentication/domain/entities/user.dart';

part 'appointment_event.dart';
part 'appointment_state.dart';

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  final CreateAppointmentUsecase createAppointmentUsecase;
  final ReadAllAppointmentsUsecase readAllAppointmentsUsecase;
  final GetAllDoctorsUsecase getAllDoctorsUsecase;
  AppointmentBloc({
    required this.createAppointmentUsecase,
    required this.readAllAppointmentsUsecase,
    required this.getAllDoctorsUsecase,
  }) : super(Empty()) {
    on<CreateAppointmentEvent>((event, emit) async {
      debugPrint('create');
      emit(Loading());
      var response = await createAppointmentUsecase(CreateAppointmentParams(
          title: event.title,
          startTime: event.startTime,
          endTime: event.endTime,
          employeeId: event.employeeId,
          patientId: event.patientId));
      response.fold((l) => emit(AppointmentError()),
          (r) => add(ReadAllAppointmentsEvent()));
    });
    on<ReadAllAppointmentsEvent>((event, emit) async {
      debugPrint('start');
      emit(Loading());
      var response = await readAllAppointmentsUsecase(NoParams());

      response.fold(
          (l) => emit(AppointmentError()), (r) => add(GetAllDoctorsEvent(r)));
    });
    on<GetAllDoctorsEvent>((event, emit) async {
      var response = await getAllDoctorsUsecase(NoParams());

      response.fold(
          (l) => emit(AppointmentError()),
          (r) => emit(
              Loaded(appointmentList: event.appointmentList, doctorList: r)));
    });
  }
}
