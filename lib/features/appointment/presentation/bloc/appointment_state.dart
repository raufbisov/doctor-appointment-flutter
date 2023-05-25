part of 'appointment_bloc.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();

  @override
  List<Object> get props => [];
}

class Empty extends AppointmentState {}

class Loading extends AppointmentState {}

class Loaded extends AppointmentState {
  final List<Appointment> appointmentList;
  final List<User> doctorList;

  const Loaded({
    required this.appointmentList,
    required this.doctorList,
  });
}

class AppointmentError extends AppointmentState {}
