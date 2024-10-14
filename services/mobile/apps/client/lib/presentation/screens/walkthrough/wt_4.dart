import 'package:flutter/material.dart';
import 'package:client/presentation/screens/main_screen.dart';

class WalkthroughPage4 extends StatelessWidget {
  const WalkthroughPage4({super.key});

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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MyBottomNavigationBar(),
                ),
              );
            },
            child: const Text('次へ'),
          ),
        ],
      ),
    );
  }
}
