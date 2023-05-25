import 'dart:convert';
import 'package:doctor_appointment/features/authentication/data/models/user_model.dart';
import 'package:doctor_appointment/features/authentication/domain/entities/user.dart';
import 'package:doctor_appointment/features/core/error/exception.dart';
import 'package:doctor_appointment/features/core/error/failure.dart';
import 'package:flutter/foundation.dart';
import 'package:http/browser_client.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class IAuthRemoteDatasource {
  Future<Map<String, dynamic>> login(String email, String password);
  Future<Map<String, dynamic>> logout();
  Future<User> getActiveUser();
  Future<bool> checkAuth();
  Future<Success> refreshToken();
  Future<Success> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required int age,
  });
}

class AuthRemoteDatasource implements IAuthRemoteDatasource {
  final FlutterSecureStorage storage;

  AuthRemoteDatasource(this.storage);

  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    Uri url = Uri.http('localhost:8000', '/auth/login/');
    http.Response response;
    try {
      response =
          await http.post(url, body: {'email': email, 'password': password});
    } catch (e) {
      throw ServerException();
    }

    String accessToken = jsonDecode(response.body)['token'];
    String refreshToken = getRefreshToken(response);
    try {
      await storage.write(key: 'access', value: accessToken);
      await storage.write(key: 'refresh', value: refreshToken);
    } catch (e) {
      throw StorageException();
    }

    return {'status': 'ok'};
  }

  @override
  Future<Map<String, dynamic>> logout() async {
    String refreshToken = '';
    try {
      refreshToken = await storage.read(key: 'refresh').then((value) => value!);
    } catch (e) {
      throw StorageException();
    }

    Uri url = Uri.http('localhost:8000', '/auth/logout/');
    try {
      await http.post(url, headers: {'cookie': 'refreshToken=$refreshToken'});
    } catch (e) {
      throw ServerException();
    }

    try {
      await storage.delete(key: 'access');
      await storage.delete(key: 'refresh');
    } catch (e) {
      throw StorageException();
    }

    return {'status': 'ok'};
  }

  @override
  Future<User> getActiveUser() async {
    String accessToken;
    try {
      accessToken = await storage.read(key: 'access').then((value) => value!);
    } catch (e) {
      throw StorageException();
    }

    Uri url = Uri.http('localhost:8000', 'auth/user/');

    http.Response response;
    try {
      response = await http
          .get(url, headers: {'Authorization': 'Bearer $accessToken'});
    } catch (e) {
      throw ServerException();
    }

    Map<String, dynamic> json;
    try {
      json = jsonDecode(response.body);
      return UserModel.fromJson(json);
    } catch (e) {
      throw ModelException();
    }
  }

  @override
  Future<bool> checkAuth() async {
    try {
      return await storage.containsKey(key: 'refresh');
    } catch (e) {
      throw StorageException();
    }
  }

  @override
  Future<Success> refreshToken() async {
    String refreshToken = '';
    try {
      refreshToken = await storage.read(key: 'refresh').then((value) => value!);
      await storage.readAll().then((value) => debugPrint('$value'));
      debugPrint(refreshToken);
    } catch (e) {
      throw StorageException();
    }

    final http.Client client = http.Client();

    Uri url = Uri.http('localhost:8000', '/auth/refresh/');
    http.Response response;
    try {
      if (client is BrowserClient) {
        client.withCredentials = true;
        response = await client
            .post(url, headers: {'Cookie': 'refreshToken=$refreshToken;'});
      } else {
        response = await http
            .post(url, headers: {'Cookie': 'refreshToken=$refreshToken;'});
      }
    } catch (e) {
      throw ServerException();
    }

    debugPrint(response.body);

    refreshToken = getRefreshToken(response);
    String accessToken = jsonDecode(response.body)['token'];
    try {
      await storage.write(key: 'access', value: accessToken);
      await storage.write(key: 'refresh', value: refreshToken);
    } catch (e) {
      throw StorageException();
    }

    return Success();
  }

  @override
  Future<Success> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,
    required int age,
  }) async {
    Uri url = Uri.http('localhost:8000', '/auth/register/');
    http.Response response;
    try {
      response = await http.post(url, body: {
        'email': email,
        'password': password,
        'first_name': firstName,
        'last_name': lastName,
        'phone_number': phoneNumber,
        'age': '$age',
      });
    } catch (e) {
      throw ServerException();
    }

    String accessToken = jsonDecode(response.body)['token'];
    String refreshToken = getRefreshToken(response);
    try {
      await storage.write(key: 'access', value: accessToken);
      await storage.write(key: 'refresh', value: refreshToken);
    } catch (e) {
      throw StorageException();
    }

    return Success();
  }
}

String getRefreshToken(http.Response response) {
  var rawCookie = response.headers['Set-Cookie'];

  debugPrint(rawCookie);

  if (rawCookie != null) {
    int index = rawCookie.indexOf(';');
    return (index == -1)
        ? ''
        : rawCookie.substring(0, index).replaceAll('refreshToken=', '');
  } else {
    return '';
  }
}
