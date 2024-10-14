import 'package:flutter/material.dart';

class WalkthroughPage3 extends StatelessWidget {
  const WalkthroughPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/friendshipdao_loop.gif',
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 240),
          const Text(
            "Describe 2",
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
