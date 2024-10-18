import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.dashboard),
      label: 'dashboard',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people),
      label: 'offer',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.money),
      label: 'fsp',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.more_horiz),
      label: 'community',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _items,
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
    );
  }
}
