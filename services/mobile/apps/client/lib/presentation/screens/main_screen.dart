import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/home_page.dart';
import 'package:client/presentation/widgets/dashboard.dart';
import 'package:client/presentation/widgets/offer.dart';
import 'package:client/presentation/widgets/more.dart';
import 'package:client/presentation/widgets/bottom_bar.dart';
import 'package:client/presentation/widgets/header_bar.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Dashboard(),
    Offer(),
    More(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          title: "FRIENDSHIP.",
          points: 1000,
          profileImagePath: "assets/logo_visualonly.jpg"),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
