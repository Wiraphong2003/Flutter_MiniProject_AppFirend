import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/group.dart';

import '../API/Service.dart';
import '../models/members.dart';
import '../models/usermodel.dart';

class MainMapPage extends StatefulWidget {
  // const MainMapPage({Key? key}) : super(key: key);
  final Usermodel userModel;
  const MainMapPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  late final Usermodel userModel;
  late final Group group;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel; // Initialize userModel from widget
    // group = widget.group; // Initialize group from widget
  }

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
              child: FutureBuilder<Members>(
                future: ServiceAPI.getmember(userModel.username, "AA"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // แสดง CircularProgressIndicator เมื่อกำลังโหลดข้อมูล
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    final members = snapshot.data?.members;
                    if (members != null && members.isNotEmpty) {
                      // Remove the inner declaration of groups
                      print('Number of groups: ${members.length}');
                      print('First group name: $members');

                      return ListView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: members.length,
                        itemBuilder: (context, index) {
                          final member = members[index];

                          return GestureDetector(
                            // onTap: () {
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => GroupDetailPage(group: group),
                            //     ),
                            //   );
                            // },

                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 0.0),
                              child: Card(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          20.0)), // เพิ่มขอบโค้ง 4 ด้าน
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      ListTile(
                                        leading: CircleAvatar(
                                            backgroundImage:
                                                NetworkImage(member.img)),
                                        title: Text(
                                          member.username,
                                          style: const TextStyle(
                                              fontFamily: 'kanit',
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 16.0),
                                        ),
                                        subtitle: Text(
                                          member.memo,
                                          style: const TextStyle(
                                              fontFamily: 'kanit',
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 14.0),
                                        ),
                                        // trailing:
                                        //     const Icon(Icons.arrow_forward_ios),
                                        // onTap: () {
                                        //   Navigator.of(context).push(MaterialPageRoute(
                                        //       builder: (context) => UserDetail(
                                        //             user: users!.users[index],
                                        //           )));
                                        // },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // child: Card(
                              //   elevation: 2.0,

                              //   shape: const RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.all(
                              //         Radius.circular(20.0)), // เพิ่มขอบโค้ง 4 ด้าน
                              //   ),
                              //   // color: const Color.fromARGB(255, 234, 234, 234),

                              //   child: ListTile(
                              //     contentPadding: const EdgeInsets.all(10.0),
                              //     title: Padding(
                              //       padding: const EdgeInsets.only(left: 16.0),
                              //       child: Row(
                              //         children: [
                              //           const Icon(Icons.group),
                              //           const SizedBox(width: 20),
                              //           Text(
                              //             member.username,
                              //             style: const TextStyle(
                              //                 color: Colors.black,
                              //                 fontFamily: 'kanit',
                              //                 fontSize: 18.0,
                              //                 fontWeight: FontWeight.w300),
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //     subtitle: Text(member.memo,
                              //         style: const TextStyle(
                              //           fontFamily: 'kanit',
                              //         )),
                              //     // trailing: const Icon(Icons.arrow_forward_ios),
                              //   ),
                              // ),
                            ),
                            // child: Padding(
                            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                            //   child: Card(
                            //     elevation: 2.0,
                            //     child: ListTile(
                            //       contentPadding: const EdgeInsets.all(16.0),
                            //       title: Text(
                            //         member.username,
                            //         style: const TextStyle(
                            //           color: Colors.black,
                            //           fontFamily: 'kanit',
                            //           fontSize: 18.0,
                            //         ),
                            //       ),
                            //       subtitle: Text(member.memo),
                            //     ),
                            //   ),
                            // ),
                          );
                        },
                      );
                    } else {
                      return const Text('No products available.');
                    }
                  }
                },
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
