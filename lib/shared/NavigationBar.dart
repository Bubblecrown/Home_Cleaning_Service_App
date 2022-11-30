import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:home_cleaning_service_app/pages/HomePage.dart';
import 'package:home_cleaning_service_app/pages/ProfilePage.dart';
import 'package:home_cleaning_service_app/pages/Reserve.dart';

class NavigationBarBtn extends StatefulWidget {
  const NavigationBarBtn({Key? key}) : super(key: key);

  @override
  State<NavigationBarBtn> createState() => _NavigationBarBtnState();
}

class _NavigationBarBtnState extends State<NavigationBarBtn> {
  int _selectedIndex = 0;
  final List<Widget> _pages = <Widget>[
    const HomePage(),
    const ReservePage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart_outlined),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex),
      ),
    );
  }
}
