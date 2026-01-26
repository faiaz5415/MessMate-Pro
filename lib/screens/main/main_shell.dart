import 'package:flutter/material.dart';
import '../../widgets/bottom_nav.dart';
import 'dashboard_screen.dart';
import 'meals_screen.dart';
import 'bazar_screen.dart';
import 'costs_screen.dart';
import 'more_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    DashboardScreen(),
    MealsScreen(),
    BazarScreen(),
    CostsScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 4) {
      // More tab - navigate to full screen without bottom nav
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const MoreScreen(),
        ),
      ).then((_) {
        // When returning from MoreScreen, reset to Dashboard
        setState(() {
          _currentIndex = 0;
        });
      });
    } else {
      // Normal tab navigation
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
