import 'package:bottom_drawer/bottom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  Set<Marker> markers = {};
  bool isLoading = false;
  String? selectedValue;
  Groups? groups;
  bool ischeck = false;
  late double sizewtemp;
  late double wilocation;
  GoogleMapController? mapController;
  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    fetchData();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // ตำแหน่งปัจจุบันของผู้ใช้
      double latitude = position.latitude;
      double longitude = position.longitude;

      latitude = position.latitude; // กำหนดค่าให้กับตัวแปร latitude
      longitude = position.longitude; // กำหนดค่าให้กับตัวแปร longitude

      // สร้าง Marker
      final marker = Marker(
        markerId: MarkerId(userModel.username),
        position: LatLng(latitude, longitude),
        infoWindow: const InfoWindow(title: 'Your Location'),
      );

      // เพิ่ม Marker เข้าใน Set<Marker>
      markers.add(marker);

      // print(latitude);
      // print(longitude);
    } catch (e) {
      print('Error getting current location: $e');
    }
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
        GoogleMap(
          initialCameraPosition: const CameraPosition(
            target: LatLng(16.245875, 103.250251),
            zoom: 15,
          ),
          markers: markers, // ใช้ markers ที่เราสร้าง
          onMapCreated: (GoogleMapController controller) {
            mapController = controller;
          },
        ),
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
      wilocation = 120;
    } else {
      sizewtemp = 125;
      wilocation = 120;
    }
    double width = sizewtemp;
    double widthlocation = wilocation;
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
          //  const SizedBox(width: 30),

          SizedBox(width: widthlocation),
          SizedBox(
            width: 30.0,
            height: 30.0,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FloatingActionButton(
                onPressed: () {
                  LatLng destination = LatLng(latitude, longitude);

                  if (mapController != null) {
                    mapController
                        ?.animateCamera(CameraUpdate.newLatLng(destination));
                  }
                },
                child: const Icon(Icons.my_location),
              ),
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
