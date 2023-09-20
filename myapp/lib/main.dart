import 'package:flutter/material.dart';

void main() {
  final apiService = ApiService('https://your-api-url.com');
  runApp(MyApp(apiService));
}

class MyApp extends StatelessWidget {
  final ApiService apiService;

  const MyApp(this.apiService, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: LoginScreen(apiService),
    );
  }
}
