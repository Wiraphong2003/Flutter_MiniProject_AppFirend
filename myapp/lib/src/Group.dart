import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:http/http.dart' as http;
import 'package:myapp/API/Service.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/src/createGroup.dart';
import 'package:myapp/src/memberGroup.dart';

class GroupPage extends StatefulWidget {
  // const GroupPage({super.key});

  final Usermodel userModel;

  const GroupPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _GroupPageState createState() => _GroupPageState();
}

class _GroupPageState extends State<GroupPage> {
  late final Usermodel userModel;
  bool isLoading = true;
  Users? users;
  Groups? groups;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    fetchData();
    // refreshData();
  }

  Future<void> fetchData() async {
    try {
      final retrievedGroups = await ServiceAPI.getGroup(userModel.username);
      setState(() {
        groups = retrievedGroups;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching groups: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> refreshData() async {
    setState(() {
      isLoading = true;
    });

    try {
      final retrievedGroups = await ServiceAPI.getGroup(userModel.username);
      setState(() {
        groups = retrievedGroups;
        isLoading = false;
      });
    } catch (error) {
      print('Error fetching groups: $error');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[700],
        title: const Text(
          "Group",
          style: TextStyle(
              fontFamily: 'kanit', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateGroupPage(
                    userModel: userModel,
                  ),
                ),
              );
              // refreshData();
            },
            icon: const Icon(Icons.add_box_outlined),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : groups != null && groups!.groups.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(5.0),
                  itemCount: groups!.groups.length,
                  itemBuilder: (context, index) {
                    final group = groups!.groups[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MemberGroupPage(
                                group: group, usermodel: userModel),
                          ),
                        );
                        print(group.groupid);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: ListTile(
                            title: Text(
                              group.name,
                              style: const TextStyle(
                                fontFamily: 'kanit',
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 16.0,
                              ),
                            ),
                            // เพิ่ม PopupMenuButton สำหรับตัวเลือกในส่วนของ trailing
                            trailing: PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'delete') {
                                  // ตรวจสอบก่อนว่า group ไม่ใช่ null
                                  final deleteUrl =
                                      'https://fair-mite-gaiters.cyclic.cloud/deleteGroup/${userModel.username}/${group.groupid}';
                                  http
                                      .delete(Uri.parse(deleteUrl))
                                      .then((response) {
                                    if (response.statusCode == 200) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('สำเร็จ'),
                                            content: const Text(
                                                'การดำเนินการเสร็จสมบูรณ์!'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // ปิด Popup
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    } else {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Not Found'),
                                            content: const Text(
                                                'Not Fount Error a Delete!'),
                                            actions: <Widget>[
                                              TextButton(
                                                child: const Text('OK'),
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // ปิด Popup
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                      print(
                                          'ลบไม่สำเร็จ: ${response.reasonPhrase}');
                                    }
                                  }).catchError((error) {
                                    print(
                                        'เกิดข้อผิดพลาดในการส่งคำขอลบ: $error');
                                  });
                                } else if (value == 'updateName') {
                                  // แสดง dialog เพื่อรับชื่อใหม่
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String newName =
                                          group.name; // ชื่อเริ่มต้น
                                      return AlertDialog(
                                        title: const Text('อัปเดตชื่อกลุ่ม'),
                                        content: TextField(
                                          onChanged: (value) {
                                            newName = value;
                                          },
                                          decoration: const InputDecoration(
                                              hintText: 'ชื่อใหม่ของกลุ่ม'),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('ยกเลิก'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text('บันทึก'),
                                            onPressed: () {
                                              // ส่งคำขอ HTTP สำหรับการอัปเดตชื่อกลุ่ม

                                              const updateUrl =
                                                  'https://fair-mite-gaiters.cyclic.cloud/updatenamegroup';
                                              final requestBody = {
                                                "username": userModel.username,
                                                "name": newName,
                                                "id": group.groupid.toString()
                                              };
                                              http
                                                  .put(Uri.parse(updateUrl),
                                                      body: requestBody)
                                                  .then((response) {
                                                if (response.statusCode ==
                                                    200) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Update Seccess'),
                                                        content: const Text(
                                                            'แก้ไขชื่อกลุ่มสำเร็จ!'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text(
                                                                'OK'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // ปิด Popup
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'Update Not Found'),
                                                        content: const Text(
                                                            'แก้ไขชื่อกลุ่มไม่สำเร็จสำเร็จ!'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            child: const Text(
                                                                'OK'),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop(); // ปิด Popup
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                  print(
                                                      'อัปเดตชื่อไม่สำเร็จ: ${response.reasonPhrase}');
                                                }
                                              }).catchError((error) {
                                                print(
                                                    'เกิดข้อผิดพลาดในการส่งคำขออัปเดต: $error');
                                              });
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  const PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Text('Delete Group'),
                                  ),
                                  const PopupMenuItem<String>(
                                    value: 'updateName',
                                    child: Text('Update Name'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Text('No products available.'),
                ),
    );
  }
}
