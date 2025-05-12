import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/home.svg',
        width: 20,
        height: 20,
      ),
      activeIcon: SvgPicture.asset(
        'assets/home.svg',
        width: 20,
        height: 20,
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/dashboard.svg',
        width: 20,
        height: 20,
      ),
      activeIcon: SvgPicture.asset(
        'assets/dashboard.svg',
        width: 20,
        height: 20,
      ),
      label: 'Dashboard',
    ),
    // TODO: オファー画面を作成したら表示する
    // BottomNavigationBarItem(
    //   icon: SvgPicture.asset(
    //     'assets/offer.svg',
    //     width: 20,
    //     height: 20,
    //   ),
    //   activeIcon: SvgPicture.asset(
    //     'assets/offer.svg',
    //     width: 20,
    //     height: 20,
    //   ),
    //   label: 'Offers',
    // ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/message.svg',
        width: 20,
        height: 20,
      ),
      activeIcon: SvgPicture.asset(
        'assets/message.svg',
        width: 20,
        height: 20,
      ),
      label: 'Message',
    ),
    BottomNavigationBarItem(
      icon: SvgPicture.asset(
        'assets/community.svg',
        width: 20,
        height: 20,
      ),
      activeIcon: SvgPicture.asset(
        'assets/community.svg',
        width: 20,
        height: 20,
      ),
      label: 'Community',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _items,
      currentIndex: currentIndex,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
    );
  }
}
