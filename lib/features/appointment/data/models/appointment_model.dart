import 'package:doctor_appointment/features/appointment/domain/entities/appointment.dart';

class AppointmentModel extends Appointment {
  const AppointmentModel({
    required super.title,
    required super.startTime,
    required super.endTime,
    required super.employeeId,
    required super.patientId,
  });

  factory AppointmentModel.fromJson(json) {
    return AppointmentModel(
      title: json['title'],
      startTime: DateTime.parse(json['start']),
      endTime: DateTime.parse(json['end']),
      patientId: json['patient_id'],
      employeeId: json['employee_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'start': startTime.toIso8601String(),
      'end': endTime.toIso8601String(),
      'patient_id': patientId
    };
  }
}
