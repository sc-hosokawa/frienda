import 'package:flutter/material.dart';

class WalkthroughPage7 extends StatelessWidget {
  const WalkthroughPage7({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/login');
          },
          child: const Text('ログイン'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/signup');
          },
          child: const Text(
            '新規登録',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
