import 'package:flutter/material.dart';
import 'package:myapp/models/index.dart';
import 'package:myapp/src/addfriend.dart';

import '../API/Service.dart';

class MemberGroupPage extends StatefulWidget {
  final Group group;
  final Usermodel usermodel;

  const MemberGroupPage({
    Key? key,
    required this.group,
    required this.usermodel,
  }) : super(key: key);

  @override
  _MemberGroupPageState createState() => _MemberGroupPageState();
}

class _MemberGroupPageState extends State<MemberGroupPage> {
  late final Usermodel userModel;
  bool isLoading = true;
  Users? users;

  @override
  void initState() {
    super.initState();
    userModel = widget.usermodel;
    fetchData();
    refreshData();
  }

  Future<void> fetchData() async {
    try {
      final retrievedGroups =
          await ServiceAPI.getuserfromgroupdetail("${widget.group.groupid}");
      setState(() {
        users = retrievedGroups;
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
      final retrievedGroups =
          await ServiceAPI.getuserfromgroupdetail("${widget.group.groupid}");
      setState(() {
        users = retrievedGroups;
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
        title: Text(
          widget.group.name,
          style: const TextStyle(
            fontFamily: 'kanit',
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddFriend(
                    userModel: widget.usermodel,
                    group: widget.group,
                  ),
                ),
              );
              refreshData();
            },
            icon: const Icon(Icons.group_add),
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users != null && users!.users.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: users!.users.length,
                  itemBuilder: (context, index) {
                    final user = users!.users[index];

                    return GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Card(
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(user.img),
                                  ),
                                  title: Text(
                                    user.username,
                                    style: const TextStyle(
                                      fontFamily: 'kanit',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  subtitle: Text(
                                    user.phone,
                                    style: const TextStyle(
                                      fontFamily: 'kanit',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ],
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
