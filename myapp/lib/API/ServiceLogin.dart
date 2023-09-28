import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/index.dart';
import 'package:myapp/src/Navber.dart';

// class ServiceLogin {
//   static const String apiUrl = "https://plain-ruby-piranha.cyclic.app/login";

//   static get http => null; // เปลี่ยน URL ให้เป็น URL ของ API การเข้าสู่ระบบ

//   static Future<Map<String, dynamic>> login(
//       String username, String password) async {
//     final Map<String, String> data = {
//       "username": username,
//       "password": password,
//     };

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(data),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       return responseData;
//     } else {
//       throw Exception('Failed to log in'); // จัดการข้อผิดพลาดในการเข้าสู่ระบบ
//     }
//   }
// }

// class ServiceLogin {
//   static const String apiUrl = "https://plain-ruby-piranha.cyclic.app/login";

//   static Future<Usermodel>? get userModel => null;

//   static Future<Usermodel> login(
//       BuildContext context, String username, String password) async {
//     final Map<String, String> data = {
//       "username": username,
//       "password": password,
//     };

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: json.encode(data),
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       final userModel = Usermodel.fromJson(responseData);

//       // ทำการนำทางไปยังหน้า NavbarPage
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) => NavbarPage(userModels: userModel),
//         ),
//       );

//       return userModel;
//     } else {
//       throw Exception('Failed to log in');
//     }
//   }
// }

class ServiceLogin {
  static const String apiUrl = "https://plain-ruby-piranha.cyclic.app/login";
  Usermodel? _cachedUserModel;

  // Method to get the userModel
  Future<Usermodel> getUserModel(BuildContext context) async {
    // If the userModel is already cached, return it
    if (_cachedUserModel != null) {
      return _cachedUserModel!;
    }

    // If not cached, perform a login (you may want to add login checks here)
    final userModel = await login(context, "username", "password");

    // Cache the userModel
    _cachedUserModel = userModel;

    return userModel;
  }

  // Your login method
  static Future<Usermodel> login(
      BuildContext context, String username, String password) async {
    final Map<String, String> data = {
      "username": username,
      "password": password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final userModel = Usermodel.fromJson(responseData);

      // ทำการนำทางไปยังหน้า NavbarPage
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => NavbarPage(userModel: userModel),
        ),
      );

      return userModel;
    } else {
      throw Exception('Failed to log in');
    }
  }
}
