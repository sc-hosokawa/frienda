import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:client/presentation/screens/walkthrough/wt_1.dart';
import 'package:client/presentation/screens/walkthrough/wt_2.dart';
import 'package:client/presentation/screens/walkthrough/wt_3.dart';
import 'package:client/presentation/screens/walkthrough/wt_4.dart';
import 'package:client/presentation/screens/walkthrough/wt_5.dart';
import 'package:client/presentation/screens/walkthrough/wt_6.dart';
import 'package:client/presentation/screens/walkthrough/wt_7.dart';
import 'package:client/presentation/screens/auth/login.dart';
import 'package:client/presentation/screens/auth/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:collection';

final providerContainer = ProviderContainer();

void main() async {
  try {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await initHiveForFlutter();
    WebViewPlatform.instance = WebViewPlatform.instance;
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // ATTの初期化と要求
    try {
      final status = await AppTrackingTransparency.trackingAuthorizationStatus;
      if (status == TrackingStatus.notDetermined) {
        // ATTダイアログを表示する前に数秒待つことを推奨
        await Future.delayed(const Duration(seconds: 2));
        await AppTrackingTransparency.requestTrackingAuthorization();
      }
    } catch (e) {
      debugPrint('ATT初期化エラー: $e');
      // ATTの初期化エラーはアプリの動作に致命的ではないため、続行
    }

    final messagingInstance = FirebaseMessaging.instance;
    try {
      await messagingInstance.requestPermission();
      final fcmToken = await messagingInstance.getToken();
      if (fcmToken != null) {
        await _updateFcmToken(fcmToken);
      }

      FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
        _updateFcmToken(fcmToken);
      });
    } catch (e) {
      debugPrint('FCM初期化エラー: $e');
      // FCMの初期化エラーはアプリの動作に致命的ではないため、続行
    }

    // デバッグ情報の出力を改善
    debugPrint('=== Environment Variables ===');
    debugPrint('API URL: ${const String.fromEnvironment('apiUrl')}');
    debugPrint('App Name: ${const String.fromEnvironment('appName')}');
    debugPrint('Flavor: ${const String.fromEnvironment('flavor')}');
    debugPrint('==========================');

    FlutterNativeSplash.remove();

    runApp(
      ProviderScope(
        child: Consumer(
          builder: (context, ref, child) {
            final client = ref.watch(graphQLClientProvider);

            return GraphQLProvider(
              client: ValueNotifier(client),
              child: MyApp(),
            );
          },
        ),
      ),
    );
  } catch (e) {
    FlutterNativeSplash.remove();
    debugPrint('アプリ初期化エラー: $e');
    // 重大なエラーの場合はエラー画面を表示
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              'アプリの初期化中にエラーが発生しました。\nアプリを再起動してください。',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

Future<void> _updateFcmToken(String fcmToken) async {
  debugPrint('FCM Token: $fcmToken');
  // FCMトークンをローカルに保存
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('fcm_token', fcmToken);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
        colorScheme: ColorScheme.light(
          primary: Colors.green,
          secondary: Colors.lightGreen,
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
            foregroundColor: Colors.white,
          ),
        ),
        cardTheme: CardTheme(color: Colors.grey[800]),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colors.white.withOpacity(0.3),
          cursorColor: Colors.white,
          selectionHandleColor: Colors.white,
        ),
        colorScheme: ColorScheme.dark(
          primary: Colors.white,
          secondary: Colors.white,
        ),
      ),
      themeMode: ThemeMode.dark,
      home: const HomePage(),
      routes: {
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const RegisterPage(),
      },
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
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (!isFirstLaunch && mounted) {
      // TODO: check if user is logged in and fetch user data
      // final currentUser = FirebaseAuth.instance.currentUser;

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      await prefs.setBool('isFirstLaunch', false);
    }
  }

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
              //WalkthroughPage3(),
              WalkthroughPage4(),
              WalkthroughPage5(),
              WalkthroughPage6(),
              WalkthroughPage7(),
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
