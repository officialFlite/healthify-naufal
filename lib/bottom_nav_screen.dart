import 'package:flutter/material.dart';
import 'package:healthify_testing/pages/main_page.dart';
import 'package:healthify_testing/pages/profile_page.dart';
import 'package:healthify_testing/pages/recipe_page.dart';

class BottomNavScreen extends StatefulWidget {
  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _screens = [
    MainPage(),
    RecipePage(),
    ProfilePage(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 178, 34, 34),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        items: [
          Icons.fitness_center_rounded,
          Icons.restaurant_rounded,
          Icons.people,
        ]
            .asMap()
            .map(
              (key, value) => MapEntry(
                key,
                BottomNavigationBarItem(
                  label: '',
                  icon: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 16.0,
                    ),
                    child: Icon(
                      value,
                      size: 30,
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList(),
      ),
    );
  }
}
