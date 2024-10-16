import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final int points;
  final String profileImagePath;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.points,
    required this.profileImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Row(
            children: [
              Text(
                '$points pts',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage(profileImagePath),
              ),
            ],
          ),
        ),
      ],
      leadingWidth: 200,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
