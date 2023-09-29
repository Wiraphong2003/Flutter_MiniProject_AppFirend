import 'package:flutter/material.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/src/memberGroup.dart';

import '../API/Service.dart';

class AddFriend extends StatefulWidget {
  final Usermodel userModel;
  final Group group;

  const AddFriend({super.key, required this.userModel, required this.group});

  @override
  _AddFriendState createState() => _AddFriendState(usermodel: userModel,group: group);
}

class _AddFriendState extends State<AddFriend> {
  final TextEditingController _usernameController = TextEditingController();
  final Usermodel usermodel;
  final Group group;

  _AddFriendState({required this.usermodel, required this.group});
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => MemberGroupPage(
                            group: group, usermodel: usermodel)),
                  );
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
              controller: _usernameController,
              decoration: const InputDecoration(
                hintText: 'Username',
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String username = _usernameController.text;

                try {
                  // เรียกใช้งาน API
                  final response = await ServiceAPI.addfriend(
                    widget.userModel.username,
                    widget.group.name,
                    username,
                  );
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
