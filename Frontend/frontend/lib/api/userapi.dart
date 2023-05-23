// ignore_for_file: constant_identifier_names, unused_local_variable, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserService {
  static const REGISTER_USER =
      'http://192.168.199.32:8000/register-mobile-user';
  static const LOGIN_USER = 'http://192.168.199.32:8000/login-mobile-user';

  Future<Map<String, dynamic>> register(String username, String password,
      String email, String gender, String age, String phoneNumber) async {
    final response = await http.post(
      Uri.parse(REGISTER_USER),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
        'email': email,
        'userdata': {
          'gender': gender,
          'age': age,
          'phonenumber': phoneNumber,
        },
      }),
    );

    print("Registeruser Called>>" + response.body);

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      final responseBody = jsonDecode(response.body);
      print(response.statusCode);
      throw Exception('Failed to register user: ${response.reasonPhrase}');
    }
  }

  Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(LOGIN_USER),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    print("Login Called>>" + response.body);
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return responseBody;
    } else {
      final responseBody = jsonDecode(response.body);
      print(response.statusCode);
      print(responseBody);
      throw Exception('Failed to login user: ${response.reasonPhrase}');
    }
  }
}
