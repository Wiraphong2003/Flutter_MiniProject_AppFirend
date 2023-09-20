import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/userM.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      return User.fromJson(jsonData);
    } else {
      throw Exception('Failed to log in');
    }
  }
}
