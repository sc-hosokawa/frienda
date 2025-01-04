import 'package:flutter/material.dart';

class WalkthroughPage4 extends StatelessWidget {
  const WalkthroughPage4({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'OFFERS',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w100,
          ),
        ),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/tutorial-offer.gif',
            height: 350,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 350,
          child: const Text(
            'Offersでは、あなたにあったオファーを探すことができ、オファーに応募して承認されると、オファー作成者やオファーのパートナーと共に、オファーを始めることになります。オファーを完了すると、ポイントが付与されます。',
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
