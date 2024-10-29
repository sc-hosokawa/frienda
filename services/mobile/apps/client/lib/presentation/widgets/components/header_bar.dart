import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/more.dart';

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
      automaticallyImplyLeading: false,
      title: Text(title),
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => More()),
                  );
                },
                child: CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage(profileImagePath),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
