import 'package:flutter/material.dart';

import 'MainMap.dart';

class NavbarPage extends StatelessWidget {
  const NavbarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BottomNavigationBarExample(),
    );
  }
}

class BottomNavigationBarExample extends StatefulWidget {
  const BottomNavigationBarExample({super.key});

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    MainMapPage(),
    // Group(),
    // UserDetailPage()
    // เพิ่มหน้า "userDetail" ที่ตำแหน่งที่ 3
  ];

  static get optionStyle => null;

  // void _onItemTapped(int index) {
  //   if (index == 1) {
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => const FriendPage()),
  //     );
  //   } else {
  //     setState(() {
  //       _selectedIndex = index;
  //     });
  //   }
  // }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List<String> appBarTitles = ['สินค้า', 'ตระกร้าสินค้า', 'บัญชีของฉัน'];
    List<String> appBarTitles = ['main', 'Friend'];
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(appBarTitles[_selectedIndex]),
      //   backgroundColor: Colors.pink,
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
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
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.person_pin_circle_rounded),
          //   label: 'บัญชีของฉัน',
          // ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
