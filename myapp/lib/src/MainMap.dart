import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:myapp/models/groups.dart';

import '../API/Service.dart';
import '../models/members.dart';
import '../models/usermodel.dart';

class MainMapPage extends StatefulWidget {
  final Usermodel userModel;

  const MainMapPage({Key? key, required this.userModel}) : super(key: key);

  @override
  _MainMapPageState createState() => _MainMapPageState();
}

class _MainMapPageState extends State<MainMapPage> {
  late final Usermodel userModel;
  bool isLoading = false;
  String? selectedValue;
  Groups? groups;
  bool ischeck = false;
  late double sizewtemp;
  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });

      final retrievedGroups = await ServiceAPI.getGroup(userModel.username);
      setState(() {
        groups = retrievedGroups;
        selectedValue =
            groups!.groups.isNotEmpty ? groups!.groups[0].name : null;
        isLoading = false;
        ischeck = true;
      });
    } catch (error) {
      print('Error fetching groups: $error');
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          child: BottomDrawer(
            header: buildHeader(),
            body: buildMemberList(),
            headerHeight: 200,
            drawerHeight: 350,
            color: const Color.fromARGB(0, 0, 0, 0),
          ),
        ),
      ],
    );
  }

  Widget buildHeader() {
    if (ischeck) {
      sizewtemp = 80;
    } else {
      sizewtemp = 125;
    }
    double width = sizewtemp;
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50.0),
          topRight: Radius.circular(50.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 60),
          const SizedBox(width: 30),
          // ... (other header widgets)

          DropdownButton<String>(
            icon: const Icon(Icons.group),
            value: selectedValue,
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(
              color: Colors.black, // Dropdown text color
            ),
            underline: Container(
              height: 0,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  selectedValue = newValue;
                });
              }
            },
            items: groups?.groups.map((group) {
                  return DropdownMenuItem<String>(
                    value: group.name,
                    child: Text(
                      group.name,
                      style: const TextStyle(
                        fontFamily: 'kanit',
                      ),
                    ),
                  );
                }).toList() ??
                [],
          ),
          // const SizedBox(width: width),
          SizedBox(width: width),
          const Center(
            child: Icon(
              Icons.horizontal_rule_outlined,
              size: 50,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMemberList() {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      child: FutureBuilder<Members>(
        future: ServiceAPI.getmember(userModel.username, "$selectedValue"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('An error occurred: ${snapshot.error}');
          } else {
            final members = snapshot.data?.members;
            if (members != null && members.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return GestureDetector(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              ListTile(
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(member.img),
                                ),
                                title: Text(
                                  member.username,
                                  style: const TextStyle(
                                    fontFamily: 'kanit',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 16.0,
                                  ),
                                ),
                                subtitle: Text(
                                  member.memo,
                                  style: const TextStyle(
                                    fontFamily: 'kanit',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 14.0,
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
              );
            } else {
              return const Text('No members available.');
            }
          }
        },
      ),
    );
  }
}
