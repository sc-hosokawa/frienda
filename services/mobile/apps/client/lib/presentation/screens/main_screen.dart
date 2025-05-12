import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/home_page.dart';
import 'package:client/presentation/widgets/dashboard.dart';
import 'package:client/presentation/widgets/offer.dart';
import 'package:client/presentation/widgets/message/message_list.dart';
import 'package:client/presentation/widgets/community.dart';
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
    // GlobalKey<NavigatorState>(),
  ];

  final List<String> _sectionTitles = [
    'HOME',
    'DASHBOARD',
    // TODO: オファー画面を作成したら表示する
    // 'OFFERS',
    'MESSAGE',
    'COMMUNITY',
  ];

  final List<bool> _hasHistory = List.filled(5, false);

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      // 同じタブをタップした場合、ルートに戻る
      _resetToRoot(index);
    } else {
      // 異なるタブをタップした場合、タブを切り替えてナビゲーターをリセット
      setState(() {
        _selectedIndex = index;
        _resetNavigator(index);
      });
    }
  }

  void _resetToRoot(int index) {
    final NavigatorState? navigator = _navigatorKeys[index].currentState;
    if (navigator != null) {
      navigator.popUntil((route) => route.isFirst);
      setState(() {
        _hasHistory[index] = false;
      });
    }
  }

  void _resetNavigator(int index) {
    final NavigatorState? navigator = _navigatorKeys[index].currentState;
    if (navigator != null) {
      navigator.popUntil((route) => route.isFirst);
      _hasHistory[index] = false;
    }
  }

  bool _canPop() {
    return _hasHistory[_selectedIndex];
  }

  void _handleBackPress() {
    if (_canPop()) {
      _navigatorKeys[_selectedIndex].currentState?.pop();
      setState(() {
        _hasHistory[_selectedIndex] =
            _navigatorKeys[_selectedIndex].currentState?.canPop() ?? false;
      });
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
          defaultProfileImagePath: 'assets/logo_visualonly.jpg',
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            _buildOffstageNavigator(0),
            _buildOffstageNavigator(1),
            _buildOffstageNavigator(2),
            _buildOffstageNavigator(3),
            // _buildOffstageNavigator(4),
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
              Widget page;
              switch (index) {
                case 0:
                  page = HomePage();
                  break;
                case 1:
                  page = Dashboard();
                  break;
                // TODO: オファー画面を作成したら表示する
                // case 2:
                //   page = Offer();
                //   break;
                case 2:
                  page = MessageList();
                  break;
                case 3:
                  page = Community();
                  break;
                default:
                  page = HomePage();
              }
              return WillPopScope(
                onWillPop: () async {
                  setState(() {
                    _hasHistory[index] = true;
                  });
                  return true;
                },
                child: page,
              );
            },
          );
        },
      ),
    );
  }
}
