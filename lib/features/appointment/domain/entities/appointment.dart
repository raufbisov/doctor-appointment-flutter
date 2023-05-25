import 'package:equatable/equatable.dart';

class Appointment extends Equatable {
  final String title;
  final DateTime startTime;
  final DateTime endTime;
  final String patientId;
  final String employeeId;

  const Appointment({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.employeeId,
    required this.patientId,
  });

  @override
  List<Object?> get props => [];
}
