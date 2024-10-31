import 'package:flutter/material.dart';

class WalkthroughPage3 extends StatelessWidget {
  const WalkthroughPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/tutorial-community.gif',
            height: 350,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 120),
        SizedBox(
          width: 350,
          child: const Text(
            'そうしてさまざまな人と繋がり、蓄積した信頼がさらにあなたの力になります',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
