import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),  // ✅ Changed
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.restaurant_menu_outlined),  // ✅ Already correct
          label: 'Meals',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_bag_outlined),  // ✅ Changed
          label: 'Bazar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payments_outlined),  // ✅ Changed
          label: 'Costs',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz_outlined),  // ✅ Changed
          label: 'More',
        ),
      ],

    );
  }
}
