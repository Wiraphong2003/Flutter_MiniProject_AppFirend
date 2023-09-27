import 'package:flutter/material.dart';
import 'package:myapp/src/login.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/', // กำหนดหน้าแรกของแอป
      routes: {
        '/': (context) => const MyApp(), // เส้นทางหน้า Login
        // '/mainmap': (context) => const MapSample(), // เส้นทางหน้า MainMap
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.ห
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter, // จุดเริ่มต้นของ Gradient
              end: Alignment.bottomCenter, // จุดสิ้นสุดของ Gradient
              colors: [
                Color(0xFFF2BE22), // สีแรก
                Color(0xFFF29727), // สีที่สอง
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment
                  .center, // จัดการตำแหน่งแนวตั้งของส่วนของ Column
              children: [
                // const Image(
                //   image: AssetImage('https://i.ibb.co/vZkB255/icon-fraind.png'),
                //   width: 200,
                //   height: 200,
                // ),
                Image.network(
                  'https://i.ibb.co/vZkB255/icon-fraind.png',
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 20), // ระยะห่างระหว่างรูปภาพกับข้อความ
                const Text(
                  'FRIENDS',
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) =>
                //               const LoginPage()), // ใช้ LoginPage() แทน Login()
                //     );
                //   },
                //   child: const Text('Text Button'),
                // ),

                Container(
                  width: 200,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(
                        244, 255, 255, 255), // ตั้งค่าสีพื้นหลังเป็นสีขาว
                    borderRadius:
                        BorderRadius.circular(30), // กำหนดรูปร่างของปุ่ม
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5), // ตั้งค่าสีเงา
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // ตำแหน่งของเงา
                      ),
                    ],
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Start',
                      style: TextStyle(
                        color: Colors.black, // ตั้งค่าสีของข้อความ
                        fontSize: 16, // ตั้งค่าขนาดของข้อความ
                        fontWeight: FontWeight.bold, // ตั้งค่าความหนาของข้อความ
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
