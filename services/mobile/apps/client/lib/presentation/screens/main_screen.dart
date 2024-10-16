import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/home_page.dart';
import 'package:client/presentation/widgets/dashboard.dart';
import 'package:client/presentation/widgets/offer.dart';
import 'package:client/presentation/widgets/fsp_wallet.dart';
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
    GlobalKey<NavigatorState>(),
  ];

  final List<String> _sectionTitles = [
    'FRIENDSHIP.',
    'Dashboard',
    'Offer',
    'FSP',
    'More',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  bool _canPop() {
    return _navigatorKeys[_selectedIndex].currentState?.canPop() ?? false;
  }

  void _handleBackPress() {
    if (_canPop()) {
      _navigatorKeys[_selectedIndex].currentState?.pop();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final safeIndex = _selectedIndex.clamp(0, _sectionTitles.length - 1);

    return WillPopScope(
      onWillPop: () async {
        if (_canPop()) {
          _handleBackPress();
          return false;
        }
        return false;
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: _sectionTitles[safeIndex],
          points: 1000,
          profileImagePath: 'assets/logo_visualonly.jpg',
          showBackButton: _canPop(),
          onBackPressed: _handleBackPress,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            _buildOffstageNavigator(4),
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
                  return Fsp();
                case 4:
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
