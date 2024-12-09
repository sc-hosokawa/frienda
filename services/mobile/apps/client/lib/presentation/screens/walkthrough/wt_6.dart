import 'package:flutter/material.dart';

class WalkthroughPage6 extends StatelessWidget {
  const WalkthroughPage6({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'COMMUNITY',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w100,
          ),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/tutorial-community.gif',
            height: 350,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 350,
          child: const Text(
            'Communityでは、繋がった他のユーザーとの繋がりを確認できます。また、繋がったユーザーのユーザーページを確認し、そのユーザーの繋がりを確認することもできます。気になったユーザーがいたら、メッセージを送って繋がりましょう。',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
