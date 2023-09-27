import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Navber.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    String username = ''; // สร้างตัวแปรเพื่อเก็บค่า username ที่ผู้ใช้กรอก
    String password = ''; // สร้างตัวแปรเพื่อเก็บค่า password ที่ผู้ใช้กรอก
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                onChanged: (value) {
                  // เมื่อผู้ใช้กรอกข้อมูล username ให้เก็บค่าในตัวแปร username
                  username = value;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  // เมื่อผู้ใช้กรอกข้อมูล password ให้เก็บค่าในตัวแปร password
                  password = value;
                },
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot your password?'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () async {
                    // void login(String username, password) async {
                    //   try {
                    //     Response response = await post(
                    //         Uri.parse(
                    //             'https://plain-ruby-piranha.cyclic.app/login'),
                    //         body: {"username": "Max", "password": "1234"});
                    //     // print(response);
                    //     if (response.statusCode == 200) {
                    //       var data = jsonDecode(response.body.toString());
                    //       Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => const NavbarPage(),
                    //         ),
                    //       );
                    //       print(data['token']);
                    //       print('Login successfully');
                    //     } else {
                    //       print('failed');
                    //     }
                    //   } catch (e) {
                    //     print(e.toString());
                    //   }
                    // }

                    void login(String username, password) async {
                      try {
                        const String url =
                            "https://plain-ruby-piranha.cyclic.app/login";
                        Map<String, String> headers = {
                          "accept": "*/*",
                        };

                        Response response = await post(
                          Uri.parse(url),
                          headers: headers,
                          body: {"username": username, "password": password},
                        );

                        if (response.statusCode == 200) {
                          var data = jsonDecode(response.body.toString());
                          print(data);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NavbarPage(),
                            ),
                          );
                          print('Login successfully');
                        } else if (response.statusCode == 401) {
                          print('Invalid username or password');
                        } else {
                          print(
                              'Request failed with status code ${response.statusCode}');
                        }
                      } catch (e) {
                        print('Error during login: $e');
                      }
                    }

                    login(username, password);

                    // try {

                    //   var data = {'username': username, 'password': password};

                    //   // Starting Web API Call.
                    //   var response = await http.post(url,
                    //       body: json.encode(data)); // REMOVED [email]
                    //   print(data);

                    //   if (response.statusCode == 200) {
                    //     // ทำตามขั้นตอนที่คุณต้องการหลังจากเรียก API สำเร็จ
                    //     Navigator.pushReplacement(
                    //       context,
                    //       MaterialPageRoute(
                    //         builder: (context) => const NavbarPage(),
                    //       ),
                    //     );
                    //   } else {
                    //     // กรณีเกิดข้อผิดพลาดในการเรียก API
                    //     // ให้ทำการแสดงข้อความหรือจัดการข้อผิดพลาดตามที่คุณต้องการ
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(
                    //         content: Text('Login failed. Please try again.'),
                    //       ),
                    //     );
                    //   }
                    // } catch (error) {
                    //   // กรณีเกิดข้อผิดพลาดในการเชื่อมต่อ
                    //   // ให้ทำการแสดงข้อความหรือจัดการข้อผิดพลาดตามที่คุณต้องการ
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //     const SnackBar(
                    //       content: Text(
                    //           'An error occurred. Please try again later.'),
                    //     ),
                    //   );
                    // }
                  },
                  style: ButtonStyle(
                    fixedSize:
                        MaterialStateProperty.all<Size>(const Size(600, 40)),
                  ),
                  child: const Text('Login')),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // ใส่โค้ดสำหรับการทำงานเมื่อกดปุ่ม Login with Facebook ที่นี่
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color(0xFF1877F2)), // สีของ Facebook
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.facebook, color: Colors.white), // ไอคอน Facebook
                    SizedBox(width: 10),
                    Text(
                      'Login with Facebook',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text("Don't have an account yet? Subscribe"),
            ],
          ),
        ),
      ),
    );
  }
}
