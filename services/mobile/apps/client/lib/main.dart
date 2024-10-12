import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FRIENDSHIP. DAO App Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const int pageCount = 6;
  final PageController _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: pageCount,
            itemBuilder: (context, index) => _buildPage(index),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 50,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: pageCount,
                effect: const JumpingDotEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  jumpScale: .7,
                  verticalOffset: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(int index) {
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
          Text(
            index == 0 ? "<< Swipe to Start" : "Describe $index",
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
