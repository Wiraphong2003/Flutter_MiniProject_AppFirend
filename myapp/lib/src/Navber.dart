import 'package:flutter/material.dart';

import '../models/usermodel.dart';
import 'Group.dart';
import 'MainMap.dart';

class NavbarPage extends StatelessWidget {
  final Usermodel userModel;

  // const NavbarPage({Key? key, required this.userModel}) : super(key: key);
  const NavbarPage({super.key, required this.userModel});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavigationBarExample(userModel: userModel),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  final Usermodel userModel;

  // const BottomNavigationBarExample(
  //     {Key? key, required this.userModel, required this.groups})
  //     : super(key: key);
  const BottomNavigationBarExample({super.key, required this.userModel});
  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions(Usermodel userModel) {
    return <Widget>[
      MainMapPage(userModel: userModel),
      GroupPage(userModel: userModel),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<String> appBarTitles = ['main', 'Friend'];
    return Scaffold(
      body: Center(
        child: _widgetOptions(widget.userModel).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'main',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_alt_rounded),
            label: 'Friend',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}


// class _BottomNavigationBarExampleState
//     extends State<BottomNavigationBarExample> {
//   // ไม่ต้องประกาศตัวแปร userModel ที่นี่

//   int _selectedIndex = 0;

//   static const List<Widget> _widgetOptions = <Widget>[
//     MainMapPage(),
//     // ใช้ widget.userModel เพื่อเข้าถึง userModel ที่ถูกส่งมาจากคลาสด้านบน
//     GroupPage(userModel: widget.userModel),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<String> appBarTitles = ['main', 'Friend'];
//     return Scaffold(
//       body: Center(
//         child: _widgetOptions.elementAt(_selectedIndex),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.map_outlined),
//             label: 'main',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people_alt_rounded),
//             label: 'Friend',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }
