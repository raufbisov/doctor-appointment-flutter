part of 'appointment_bloc.dart';

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();

  @override
  List<Object> get props => [];
}

class CreateAppointmentEvent extends AppointmentEvent {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String employeeId;
  final String patientId;

  const CreateAppointmentEvent({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.employeeId,
    required this.patientId,
  });
}

class ReadAllAppointmentsEvent extends AppointmentEvent {}

class GetAllDoctorsEvent extends AppointmentEvent {
  final List<Appointment> appointmentList;

  const GetAllDoctorsEvent(this.appointmentList);
}
