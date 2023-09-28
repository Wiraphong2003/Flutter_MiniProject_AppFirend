import 'package:flutter/material.dart';
import 'package:myapp/models/index.dart';

import '../API/Service.dart';

// ignore: camel_case_types

class memberGroupPage extends StatelessWidget {
  final Group group; // เพิ่มตัวแปรสมาชิกเพื่อรับข้อมูลกลุ่ม
  final Usermodel usermodel;

  const memberGroupPage(
      {Key? key, required this.group, required this.usermodel})
      : super(key: key);

  void _openMemberGroupPage(BuildContext context) async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String username = ""; // ตัวแปรสำหรับเก็บ username ที่ผู้ใช้กรอก

        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0), // เพิ่มขอบโค้ง 10 พิกเซล
          ),
          title: const Text(
            "ADD Friend",
            style: TextStyle(
              fontFamily: 'kanit',
              fontSize: 30,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          content: TextField(
            onChanged: (value) {
              username = value; // เมื่อผู้ใช้กรอก username ใหม่
            },
            decoration: const InputDecoration(
              hintText: "Username",
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.green),
              ),
              child: const Text("OK"),
              onPressed: () {
                // ทำสิ่งที่คุณต้องการเมื่อปุ่ม "OK" ถูกคลิก
                // เช่น นำ username ไปใช้งานตามต้องการ
                print("Username: $username");
                ServiceAPI.addfriend(usermodel.username, group.name, username);
                // ปิด Dialog และส่งข้อมูลกลับไปยังหน้าที่เรียก Dialog
                // Navigator.of(context).pop(username);

                // ปิด Dialog
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text("Cancel"),
              onPressed: () {
                // ปิด Dialog โดยไม่ทำอะไร
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
    // if (result != null) {
    //   // Reload the data by calling the provider
    //   context.read(reloadDataProvider)();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: Text(
          group.name,
          style: const TextStyle(
            fontFamily: 'kanit',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _openMemberGroupPage(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<Members>(
        future: ServiceAPI.getmember(usermodel.username, group.name),
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
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)), // เพิ่มขอบโค้ง 4 ด้าน
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: NetworkImage(member.img)),
                                title: Text(
                                  member.username,
                                  style: const TextStyle(
                                      fontFamily: 'kanit',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16.0),
                                ),
                                subtitle: Text(
                                  member.memo,
                                  style: const TextStyle(
                                      fontFamily: 'kanit',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0),
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios),
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
    );
  }
}
