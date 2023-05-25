import 'package:doctor_appointment/features/authentication/data/datasources/auth_remote_datasource_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Get refresh token', () async {
    Uri url = Uri.http('localhost:8000', '/appointments/');
    var response =
        await http.post(url, body: {'email': '0@gmail.com', 'password': '0'});
    debugPrint(response.headers.toString());
    debugPrint(getRefreshToken(response));
  });
}
