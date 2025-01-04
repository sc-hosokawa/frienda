import 'package:flutter/material.dart';

class WalkthroughPage5 extends StatelessWidget {
  const WalkthroughPage5({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'DASHBOARD',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w100,
          ),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/tutorial-dashboard.gif',
            height: 350,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 350,
          child: const Text(
            'Dashboardでは、登録された音楽チャンネルの再生数を統合し、あなたのアーティストとしての活動を可視化します。週、月での再生数の確認、再生されているユーザーや国の内訳などあなたにとって有益な情報が確認できます。',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
