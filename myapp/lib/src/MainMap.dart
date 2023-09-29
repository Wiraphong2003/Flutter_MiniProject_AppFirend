import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/groups.dart';

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

  late final Groups groups;

  String? selectedValue;
  // @override
  // void initState() {
  //   super.initState();
  //   userModel = widget.userModel; // Initialize userModel from widget
  // }
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel; // Initialize userModel from widget
    // เรียกใช้ ServiceAPI.getGroup เพื่อดึงข้อมูลกลุ่ม
    ServiceAPI.getGroup(userModel.username).then((retrievedGroups) {
      setState(() {
        groups = retrievedGroups;
      });
    }).catchError((error) {
      // จัดการข้อผิดพลาดในกรณีที่เกิดข้อผิดพลาดในการดึงข้อมูล
      print('Error fetching groups: $error');
    });
    print(groups.name[0]);
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const SizedBox(width: 20),
                  const Column(
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
                  const SizedBox(width: 120.0),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.horizontal_rule_outlined,
                        size: 50,
                        color: Color.fromARGB(196, 196, 196, 196),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // DropdownButton<String>(
                      //   value: selectedValue,
                      //   onChanged: (String? newValue) {
                      //     if (newValue != null) {
                      //       setState(() {
                      //         selectedValue = newValue;
                      //       });
                      //     }
                      //   },
                      //   items: <String>[
                      //     'กินข้าว',
                      //     'AA',
                      //     'ทำงาน',
                      //   ].map<DropdownMenuItem<String>>((String value) {
                      //     return DropdownMenuItem<String>(
                      //       value: value,
                      //       child: Text(value),
                      //     );
                      //   }).toList(),
                      // ),
                      DropdownButton<String>(
                        value: selectedValue,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              selectedValue = newValue;
                            });
                          }
                        },
                        items: groups.groups.isNotEmpty
                            ? groups.groups
                                .map<DropdownMenuItem<String>>((group) {
                                return DropdownMenuItem<String>(
                                  value: group.name,
                                  child: Text(group.name),
                                );
                              }).toList()
                            : [],
                      ),
                    ],
                  )
                ],
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                color:
                    Color.fromARGB(255, 255, 255, 255), // เพิ่มสีให้กับ Header
              ),
              child: FutureBuilder<Members>(
                future:
                    ServiceAPI.getmember(userModel.username, "$selectedValue"),
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
                            ),
                          );
                        },
                      );
                    } else {
                      return const Text('No products available.');
                    }
                  }
                },
              ),
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
