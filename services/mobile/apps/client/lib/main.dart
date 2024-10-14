import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:client/presentation/screens/bottom_navigation_bar.dart';
import 'package:client/presentation/screens/walkthrough/wt_1.dart';
import 'package:client/presentation/screens/walkthrough/wt_2.dart';
import 'package:client/presentation/screens/walkthrough/wt_3.dart';
import 'package:client/presentation/screens/walkthrough/wt_4.dart';

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
  static const int pageCount = 4;
  final PageController _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: const [
              WalkthroughPage1(),
              WalkthroughPage2(),
              WalkthroughPage3(),
              WalkthroughPage4(),
            ],
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

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
