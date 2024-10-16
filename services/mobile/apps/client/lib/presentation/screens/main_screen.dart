import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/home_page.dart';
import 'package:client/presentation/widgets/dashboard.dart';
import 'package:client/presentation/widgets/offer.dart';
import 'package:client/presentation/widgets/more.dart';
import 'package:client/presentation/widgets/components/bottom_bar.dart';
import 'package:client/presentation/widgets/components/header_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<String> _sectionTitles = [
    'FRIENDSHIP.',
    'Dashboard',
    'Offer',
    'More',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        appBar: CustomAppBar(
            title: _sectionTitles[_selectedIndex],
            points: 1000,
            profileImagePath: 'assets/logo_visualonly.jpg'),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (index) {
                case 0:
                  return HomePage();
                case 1:
                  return Dashboard();
                case 2:
                  return Offer();
                case 3:
                  return More();
                default:
                  return HomePage();
              }
            },
          );
        },
      ),
    );
  }
}
