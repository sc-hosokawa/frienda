import 'package:flutter/material.dart';

class WalkthroughPage4 extends StatelessWidget {
  const WalkthroughPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/friendshipdao_loop.gif',
          height: 200,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 240),
        const Text(
          'Describe 3',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
