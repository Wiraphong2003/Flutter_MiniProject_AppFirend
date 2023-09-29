import 'package:flutter/material.dart';
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
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                ListTile(
                                  // iconColor: Icons.group,
                                  title: Text(
                                    group.name,
                                    style: const TextStyle(
                                      fontFamily: 'kanit',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 16.0,
                                    ),
                                  ),
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
