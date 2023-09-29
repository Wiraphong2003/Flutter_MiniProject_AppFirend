import 'package:flutter/material.dart';
import 'package:myapp/models/index.dart';

import '../API/Service.dart';

class CreateGroupPage extends StatefulWidget {
  final Usermodel userModel;
  // final Group group;

  const CreateGroupPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _CreateGroupPageState createState() =>
      _CreateGroupPageState(usermodel: userModel);
}

class _CreateGroupPageState extends State<CreateGroupPage> {
  final TextEditingController _groupnameController = TextEditingController();
  final Usermodel usermodel;

  _CreateGroupPageState({required this.usermodel});
  @override
  Widget build(BuildContext context) {
    Future<void> _showAlertDialog(String title, String message) async {
      return showDialog<void>(
        context: context,
        barrierDismissible:
            false, // ไม่สามารถปิด AlertDialog ได้โดยการแตะที่พื้นหลัง
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(message),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop(); // ปิด AlertDialog
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //       builder: (context) => GroupPage(userModel: usermodel)),
                  // );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Member'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _groupnameController,
              decoration: const InputDecoration(
                hintText: 'Groupname',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String groupname = _groupnameController.text;

                try {
                  // เรียกใช้งาน API
                  final response = await ServiceAPI.createGroup(
                      usermodel.username, groupname);
                  // print(response);
                  // final Map<String, dynamic> data = json.decode(response);

                  if (response) {
                    // หากสำเร็จแสดง AlertDialog สำเร็จ
                    _showAlertDialog('Success', 'Friend added successfully');
                  } else {
                    // หากไม่สำเร็จแสดง AlertDialog ไม่สำเร็จ
                    _showAlertDialog('Error', 'Failed to add friend');
                  }
                } catch (error) {
                  // หากมีข้อผิดพลาดในการเรียก API แสดง AlertDialog ข้อความผิดพลาด
                  _showAlertDialog('Error', 'An error occurred: $error');
                }
              },
              child: const Text('ADD'),
            ),
          ],
        ),
      ),
    );
  }
}
