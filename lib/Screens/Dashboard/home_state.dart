import 'package:flutter/material.dart';
import 'package:iron_log/Screens/Dashboard/Calender/calender_screen.dart';
import 'package:iron_log/Screens/Dashboard/work_hub/workout_hub.dart';

import '../../Widgets/botton_nav.dart';
import 'Home/home_screen.dart';
import 'Progress/progess_screen.dart';
import 'Setting/setting_screen.dart';

class HomeState extends StatefulWidget {
  final int initialIndex;

  const HomeState({super.key, this.initialIndex = 0});

  @override
  State<HomeState> createState() => _HomeState();
}

class _HomeState extends State<HomeState> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = [
    const HomeScreen(),     // Index 0
    const WorkoutHubScreen(),  // Index 1
    const ProgressScreen(),    // Index 2
    const CalenderScreen(), // Index 3
    const SettingsScreen(), // Index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}