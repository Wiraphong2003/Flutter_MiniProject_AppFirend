import 'package:flutter/material.dart';

class GroupPage extends StatefulWidget {
  const GroupPage({Key? key}) : super(key: key);

  @override
  _GroupPageeState createState() => _GroupPageeState();
}

class _GroupPageeState extends State<GroupPage> {
  // late Users usersData = Users(users: [], Groups: []);

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch user data when the widget is initialized
  }

  Future<void> fetchData() async {
    try {
      final data = await APIService.getUsers();
      setState(() {
        usersData = data;
      });
    } catch (e) {
      // Handle any errors that may occur during the HTTP request
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Friend"),
        backgroundColor: const Color(0xFFF29727),
      ),
      body: ListView.builder(
          itemCount: usersData != null ? usersData.users.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                // เมื่อคลิกที่ ListTile จะเปิดหน้า UserDetail โดยส่งข้อมูลผู้ใช้ไปด้วย
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => UserDetail(
                //     user: usersData.users[index],
                //   ),
                // ));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTileTheme(
                  contentPadding: EdgeInsets.zero,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30.0, // ปรับขนาดรูปภาพตามที่คุณต้องการ
                      backgroundImage: NetworkImage(usersData.users[index].img),
                    ),
                    title: Text(
                      usersData.users[index].name,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 18.0,
                      ),
                    ),
                    subtitle: Text(
                      "Email: ${usersData.users[index].email}",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       if (usersData != null)
      //         for (int index = 0; index < usersData.users.length; index++)
      //           Card(
      //             child: Padding(
      //               padding: const EdgeInsets.all(10.0),
      //               child: Column(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.stretch,
      //                 children: <Widget>[
      //                   ListTile(
      //                     leading: CircleAvatar(
      //                       backgroundImage:
      //                           NetworkImage(usersData.users[index].img),
      //                     ),
      //                     title: Text(
      //                       usersData.users[index].name,
      //                       style: const TextStyle(
      //                           color: Color.fromARGB(255, 0, 0, 0),
      //                           fontSize: 16.0),
      //                     ),
      //                     subtitle: Text(
      //                       "Email: ${usersData.users[index].email}",
      //                       style: const TextStyle(
      //                           color: Color.fromARGB(255, 0, 0, 0),
      //                           fontSize: 14.0),
      //                     ),
      //                     trailing: const Icon(Icons.arrow_forward_ios),
      //                     onTap: () {
      //                       // Navigator.of(context).push(MaterialPageRoute(
      //                       //   builder: (context) => UserDetail(
      //                       //     user: usersData!.users[index],
      //                       //   ),
      //                       // ));
      //                     },
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //     ],
      //   ),
      // ),
    );
  }
}
