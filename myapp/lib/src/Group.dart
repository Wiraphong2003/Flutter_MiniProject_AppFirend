import 'package:flutter/material.dart';
import 'package:myapp/API/Service.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/src/memberGroup.dart';

class GroupPage extends StatelessWidget {
  // const GroupPage({super.key});

  final Usermodel userModel;

  const GroupPage({Key? key, required this.userModel}) : super(key: key);

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
      ),

      // backgroundColor: Colors.amber[600],
      body: FutureBuilder<Groups>(
        future: ServiceAPI.getGroup(userModel.username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // แสดง CircularProgressIndicator เมื่อกำลังโหลดข้อมูล
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final groups = snapshot.data?.groups;
            if (groups != null && groups.isNotEmpty) {
              print('Number of groups: ${groups.length}');
              print('First group name: $groups');

              return ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: groups.length,
                itemBuilder: (context, index) {
                  final group = groups[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => memberGroupPage(
                              group: group, usermodel: userModel),
                        ),
                      );
                      print(group.groupid);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Card(
                        elevation: 2.0,

                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)), // เพิ่มขอบโค้ง 4 ด้าน
                        ),
                        // color: const Color.fromARGB(255, 234, 234, 234),

                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10.0),
                          title: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Row(
                              children: [
                                const Icon(Icons.group),
                                const SizedBox(width: 20),
                                Text(
                                  group.name,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'kanit',
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                          ),
                          // trailing: const Icon(Icons.arrow_forward_ios),
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
    );
  }
}
