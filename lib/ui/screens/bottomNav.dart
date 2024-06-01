import 'package:flutter/material.dart';
import 'package:chiventis/ui/screens/bottom_nav_screens/airtime.dart';
import 'package:chiventis/ui/screens/bottom_nav_screens/cable.dart';
import 'package:chiventis/ui/screens/bottom_nav_screens/data.dart';
import 'package:chiventis/ui/screens/bottom_nav_screens/electricity.dart';
import 'package:chiventis/ui/screens/bottom_nav_screens/home.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  BottomNavState createState() => BottomNavState();
}

class BottomNavState extends State<BottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const AirtimePage(),
    const DataPage(),
    const ElectricityPage(),
    const CablePage(),
  ];

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: _pages
            .asMap()
            .map(
              (index, page) => MapEntry(
                index,
                Offstage(
                  offstage: _selectedIndex != index,
                  child: Navigator(
                    key: _navigatorKeys[index],
                    onGenerateRoute: (settings) {
                      if (settings.name != '/' && settings.name != null) {
                        Navigator.pushNamed(context, settings.name!,
                            arguments: settings.arguments);
                      }
                      return MaterialPageRoute(
                        builder: (context) => page,
                      );
                    },
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedIconTheme: const IconThemeData(color: Colors.black),
        selectedIconTheme: const IconThemeData(
          color: Color(0xFF4169E1),
        ),
        showUnselectedLabels: true,
        unselectedLabelStyle: const TextStyle(color: Colors.black),
        showSelectedLabels: true,
        selectedLabelStyle: const TextStyle(color: Colors.black),
        backgroundColor: const Color(0xFFF4FFFE),
        unselectedItemColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Color(0xFFF4FFFE)),
          BottomNavigationBarItem(
              icon: Icon(Icons.phone_in_talk),
              label: 'Airtime',
              backgroundColor: Color(0xFFF4FFFE)),
          BottomNavigationBarItem(
              icon: Icon(Icons.wifi),
              label: 'Data',
              backgroundColor: Color(0xFFF4FFFE)),
          BottomNavigationBarItem(
              icon: Icon(Icons.lightbulb),
              label: 'Electricity',
              backgroundColor: Color(0xFFF4FFFE)),
          BottomNavigationBarItem(
              icon: Icon(Icons.tv_rounded),
              label: 'Cable TV',
              backgroundColor: Color(0xFFF4FFFE)),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
