import 'package:flutter/material.dart';
import 'package:smart_ring/screens/activity_screen/activity_screen.dart';
import 'package:smart_ring/screens/home_screen/home_screen.dart';
import 'package:smart_ring/screens/profile_screen/profile_screen.dart';
import 'package:smart_ring/screens/sleep_screen/sleep_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ActivityScreen(),
    SleepScreen(),
    MyProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.black, // Background color
            selectedItemColor: Colors.blue, // White icon & label when selected
            unselectedItemColor: Colors.white, // Blue icon when unselected
            selectedLabelStyle: TextStyle(color: Colors.white), // White label
            unselectedLabelStyle: TextStyle(
              color: Colors.white,
            ), // White label when unselected
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed, // Ensures labels always show
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_walk),
              label: 'Activity',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.bedtime), label: 'Sleep'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Me'),
          ],
        ),
      ),
    );
  }
}
