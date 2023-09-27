import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';

class MainMapPage extends StatefulWidget {
  const MainMapPage({Key? key}) : super(key: key);

  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        ClipRRect(
          child: BottomDrawer(
            header: Container(
              decoration: const BoxDecoration(
                color:
                    Color.fromARGB(255, 255, 255, 255), // เพิ่มสีให้กับ Header
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50.0),
                  topRight: Radius.circular(50.0),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  SizedBox(width: 20),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        // child: Align(
                        //   alignment: Alignment.bottomCenter, // ชิดขอบล่าง
                        //   child: FloatingActionButton(
                        //     // onPressed: () {
                        //     //   _updateUserLocationOnMap();
                        //     // },
                        //     child: Icon(Icons.my_location),
                        //   ),
                        // ),
                      ),
                    ],
                  ),
                  SizedBox(width: 120.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.horizontal_rule_outlined,
                        size: 50,
                        color: Color.fromARGB(196, 196, 196, 196),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                color:
                    Color.fromARGB(255, 255, 255, 255), // เพิ่มสีให้กับ Header
              ),
              // child: ListView.builder(
              //   itemCount: usersData != null ? usersData!.users.length : 0,
              //   itemBuilder: (BuildContext context, int index) {
              //     return InkWell(
              //       onTap: () {
              //         // Handle onTap logic
              //       },
              //       child: Padding(
              //         padding: const EdgeInsets.symmetric(
              //           vertical: 8.0,
              //           horizontal: 16.0,
              //         ),
              //         child: ListTileTheme(
              //           contentPadding: EdgeInsets.zero,
              //           child: ListTile(
              //             leading: CircleAvatar(
              //               radius: 30.0, // ปรับขนาดรูปภาพตามที่คุณต้องการ
              //               backgroundImage:
              //                   NetworkImage(usersData!.users[index].img),
              //             ),
              //             title: Text(
              //               usersData!.users[index].name,
              //               style: const TextStyle(
              //                 color: Color.fromARGB(255, 0, 0, 0),
              //                 fontSize: 18.0,
              //               ),
              //             ),
              //             subtitle: Text(
              //               "Email: ${usersData!.users[index].email}",
              //               style: const TextStyle(
              //                 color: Color.fromARGB(255, 0, 0, 0),
              //                 fontSize: 14.0,
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //     );
              //   },
              // ),
            ),
            headerHeight: 200,
            drawerHeight: 350,
            color: const Color.fromARGB(0, 0, 0, 0),
            // controller: controller,
          ),
        ),
      ],
    );
  }
}
