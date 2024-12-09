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
            'assets/tutorial-services.gif',
            height: 350,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 60),
        SizedBox(
          width: 350,
          child: const Text(
            'OffersやDashboardのサマリーを確認できます。また、あなたの活動や音楽の視聴数などに応じて、アクションの提案をおすすめします。',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
