import 'package:flutter/material.dart';
import 'package:myapp/API/ServiceLogin.dart';

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
                    ServiceLogin.login(context, username, password)
                        .then((userModel) {
                      print("Username: ${userModel.username}");
                      print("Email: ${userModel.email}");

                      // ทำการนำทางไปยังหน้าอื่นหลังจากล็อกอินเรียบร้อยแล้ว
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) => const NavbarPage(),
                      //   ),
                      // );
                    }).catchError((error) {
                      print("Error: $error");
                    });
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
