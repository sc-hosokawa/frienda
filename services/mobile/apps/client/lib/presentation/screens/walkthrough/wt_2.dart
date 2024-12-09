import 'package:flutter/material.dart';

class WalkthroughPage2 extends StatelessWidget {
  const WalkthroughPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            'assets/tutorial-welcome.gif',
            height: 350,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 350,
          child: const Text(
            'Welcome to FRIENDSHIP. DAO!',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
