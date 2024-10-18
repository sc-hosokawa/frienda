import 'package:flutter/material.dart';

class WalkthroughPage2 extends StatelessWidget {
  const WalkthroughPage2({super.key});

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
            'Describe 1',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
