import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:client/presentation/screens/walkthrough/wt_1.dart';
import 'package:client/presentation/screens/walkthrough/wt_2.dart';
import 'package:client/presentation/screens/walkthrough/wt_3.dart';
import 'package:client/presentation/screens/walkthrough/wt_4.dart';
import 'package:client/presentation/screens/auth/login.dart';
import 'package:client/presentation/screens/auth/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:ferry/ferry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:webview_flutter/webview_flutter.dart';

final providerContainer = ProviderContainer();

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  WebViewPlatform.instance = WebViewPlatform.instance;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final client = await initClient();
  FlutterNativeSplash.remove();

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
          fontFamily: 'Jost',
          brightness: Brightness.light,
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.grey[800],
            elevation: 0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 1,
          ),
          iconTheme: IconThemeData(color: Colors.green),
          textTheme: TextTheme(
            bodyLarge: TextStyle(
                color: Colors.grey[800], fontFamilyFallback: ['NotoSansJP']),
            bodyMedium: TextStyle(
                color: Colors.grey[800], fontFamilyFallback: ['NotoSansJP']),
            titleMedium: TextStyle(
                color: Colors.grey[800], fontFamilyFallback: ['NotoSansJP']),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.lightGreen,
            ),
          ),
          cardTheme: CardTheme(color: Colors.white),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.green.withOpacity(0.3),
            cursorColor: Colors.green,
            selectionHandleColor: Colors.green,
          ),
        ),
        darkTheme: ThemeData(
          fontFamily: 'Jost',
          brightness: Brightness.dark,
          primarySwatch: Colors.green,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.grey[200],
            elevation: 0,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.grey[900],
            elevation: 1,
          ),
          iconTheme: IconThemeData(color: Colors.green),
          textTheme: TextTheme(
            bodyLarge: TextStyle(
                color: Colors.grey[200], fontFamilyFallback: ['NotoSansJP']),
            bodyMedium: TextStyle(
                color: Colors.grey[200], fontFamilyFallback: ['NotoSansJP']),
            titleMedium: TextStyle(
                color: Colors.grey[200], fontFamilyFallback: ['NotoSansJP']),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[800],
              foregroundColor: Colors.lightGreen,
            ),
          ),
          cardTheme: CardTheme(color: Colors.grey[800]),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: Colors.green.withOpacity(0.3),
            cursorColor: Colors.green,
            selectionHandleColor: Colors.green,
          ),
        ),
        themeMode: ThemeMode.dark,
        home: const HomePage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const RegisterPage(),
        });
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
                    jumpScale: .4,
                    verticalOffset: 15,
                    activeDotColor: Colors.white),
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
