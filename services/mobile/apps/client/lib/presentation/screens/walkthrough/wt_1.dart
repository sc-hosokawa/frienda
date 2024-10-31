import 'package:flutter/material.dart';

class WalkthroughPage1 extends StatelessWidget {
  const WalkthroughPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/friendshipdao_loop.gif',
            height: 200,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 240),
        const Text(
          '<< Swipe to Start',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
