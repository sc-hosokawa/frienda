import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:client/presentation/screens/walkthrough/wt_1.dart';
import 'package:client/presentation/screens/walkthrough/wt_2.dart';
import 'package:client/presentation/screens/walkthrough/wt_3.dart';
import 'package:client/presentation/screens/walkthrough/wt_4.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:ferry/ferry.dart';

final providerContainer = ProviderContainer();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final client = await initClient();
  providerContainer.read(clientProvider.notifier).state = client;

  runApp(
    UncontrolledProviderScope(
      container: providerContainer,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FRIENDSHIP. DAO App',
      theme: ThemeData(
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey[800],
            elevation: 0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.green),
          textTheme: TextTheme(
            bodyLarge: TextStyle(color: Colors.grey[800]),
            bodyMedium: TextStyle(color: Colors.grey[800]),
            titleMedium: TextStyle(color: Colors.grey[800]),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.lightGreen,
            ),
          ),
          cardTheme: CardTheme(color: Colors.white)),
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
