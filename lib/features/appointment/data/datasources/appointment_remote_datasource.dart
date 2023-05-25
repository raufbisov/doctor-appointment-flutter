import 'dart:convert';

import 'package:doctor_appointment/features/appointment/data/models/appointment_model.dart';
import 'package:doctor_appointment/features/appointment/domain/entities/appointment.dart';
import 'package:doctor_appointment/features/appointment/domain/usecases/create_appointment_usecase.dart';
import 'package:doctor_appointment/features/authentication/data/models/user_model.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/core/error/exception.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

abstract class IAppointmentRemoteDatasource {
  Future<Success> createAppointment(CreateAppointmentParams params);
  Future<List<Appointment>> readAllAppointments();
  Future<List<User>> getAllDoctors();
}

class AppointmentRemoteDatasource implements IAppointmentRemoteDatasource {
  final FlutterSecureStorage storage;

  AppointmentRemoteDatasource(this.storage);
  @override
  Future<Success> createAppointment(CreateAppointmentParams params) async {
    Uri url = Uri.http('localhost:8000', '/appointments/crud/');
    String? accessToken;

    try {
      accessToken = await storage.read(key: 'access');
    } catch (e) {
      throw StorageException();
    }

    debugPrint('${params.startTime}\n${params.endTime}');

    try {
      await http.post(url, body: {
        'title': params.title,
        'start': params.startTime.toIso8601String(),
        'end': params.endTime.toIso8601String(),
        'employee_id': params.employeeId,
        'patient_id': params.patientId,
      }, headers: {
        'Authorization': 'Bearer $accessToken'
      });
    } catch (e) {
      throw ServerException();
    }

    return Success();
  }

  @override
  Future<List<Appointment>> readAllAppointments() async {
    Uri url = Uri.http('localhost:8000', '/appointments/crud/');
    String? accessToken;

    try {
      accessToken = await storage.read(key: 'access');
    } catch (e) {
      throw StorageException();
    }

    http.Response response;
    List<Appointment> appList = [];

    try {
      response = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});
    } catch (e) {
      throw ServerException();
    }

    try {
      Map<String, dynamic> json = jsonDecode(response.body);
      for (var app in json['details']) {
        appList.add(AppointmentModel.fromJson(app));
      }
    } catch (e) {
      throw Exception();
    }

    return appList;
  }

  @override
  Future<List<User>> getAllDoctors() async {
    http.Response response;
    Uri url = Uri.http('localhost:8000', '/appointments/getAllDoctors/');

    List<User> data = [];

    String? accessToken;

    try {
      accessToken = await storage.read(key: 'access');
    } catch (e) {
      throw StorageException();
    }

    try {
      response = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});
    } catch (e) {
      throw ServerException();
    }

    for (var doctor in jsonDecode(response.body)) {
      data.add(UserModel.fromJson(doctor));
    }

    return data;
  }
}
