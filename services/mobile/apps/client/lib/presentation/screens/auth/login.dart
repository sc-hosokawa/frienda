import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:client/presentation/screens/auth/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/auth_provider.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/services/biometric_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:client/presentation/screens/auth/reset_password.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  final BiometricAuthService _biometricAuth = BiometricAuthService();
  bool _isBiometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
  }

  Future<void> _checkBiometric() async {
    if (!mounted) return;

    final isAvailable = await _biometricAuth.isBiometricAvailable();
    final isEnabled = await _biometricAuth.isBiometricEnabled();

    if (isAvailable && isEnabled) {
      if (!mounted) return;

      setState(() {
        _isBiometricAvailable = true;
      });

      // アプリ起動時に自動で生体認証を開始
      _authenticateWithBiometrics();
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    if (!mounted) return;

    print('生体認証を開始します');
    final authenticated = await _biometricAuth.authenticate();
    print('生体認証結果: $authenticated');

    if (authenticated) {
      if (!mounted) return;

      setState(() => _isLoading = true);
      try {
        print('保存されたトークンを取得します');
        final storedToken = await _biometricAuth.getAuthToken();
        print('取得したトークン: ${storedToken?.substring(0, 10)}...');

        if (storedToken == null) {
          throw Exception('認証情報が見つかりません');
        }

        // 現在のユーザーの状態を確認
        final currentUser = FirebaseAuth.instance.currentUser;
        if (currentUser == null) {
          // セッションが切れている場合は、保存されているトークンを削除
          await _biometricAuth.deleteAuthToken();
          throw Exception('認証セッションが切れています。再度ログインしてください。');
        }

        try {
          // 既存のセッションを使用して新しいIDトークンを取得
          final newToken = await currentUser.getIdToken(true);
          print('新しいトークンを取得: ${newToken?.substring(0, 10)}...');
        } catch (e) {
          // トークンの更新に失敗した場合は、保存されているトークンを削除
          await _biometricAuth.deleteAuthToken();
          throw Exception('認証の更新に失敗しました。再度ログインしてください。');
        }

        final user = FirebaseAuth.instance.currentUser;
        print('Firebase認証結果: ${user?.uid}');

        if (user == null) {
          throw Exception('ユーザー情報の取得に失敗しました');
        }

        // FCMトークンを取得
        final prefs = await SharedPreferences.getInstance();
        final fcmToken = prefs.getString('fcm_token');

        // FCMトークンを更新するミューテーション
        await ref.read(graphQLClientProvider).mutate(
              MutationOptions(
                document: gql('''
                  mutation UpdateUserData(\$input: UpdateUserDataInput!) {
                    updateUserData(input: \$input) {
                      userInfo {
                        id
                        name
                        imageUrl
                      }
                    }
                  }
                '''),
                variables: {
                  'input': {
                    'id': user.uid,
                    'fcmToken': fcmToken,
                  },
                },
              ),
            );

        // ユーザーデータを取得
        final userData = await ref.read(graphQLClientProvider).query(
              QueryOptions(
                document: gql('''
              query GetUserData(\$userId: String!) {
                getUserData(userId: \$userId) {
                  id
                  name
                  imageUrl
                  fspBalance
                  credentialBalance
                  role
                  primaryRole
                  greeting
                  skill
                  xHandle
                  instagramHandle
                  fbHandle
                  interestOffer
                  createdAt
                  belongsToArtists {
                    id
                    artistId
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                  primaryArtist {
                    id
                    artistId
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                }
              }
            '''),
                variables: {
                  'userId': user.uid,
                },
                fetchPolicy: FetchPolicy.noCache,
              ),
            );

        // 状態を更新
        await ref.read(authProvider.notifier).setAuthInfo(user);
        ref.read(userProvider.notifier).updateUser(
              UserData.fromJson(
                  userData.data?['getUserData'] as Map<String, dynamic>),
            );

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );
      } catch (e) {
        print('生体認証エラー詳細: $e');
        if (e is FirebaseAuthException) {
          print('Firebase Error Code: ${e.code}');
          print('Firebase Error Message: ${e.message}');
          // Firebase認証エラーの場合は保存されているトークンを削除
          await _biometricAuth.deleteAuthToken();
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('生体認証でのログインに失敗しました。\n再度メールアドレスとパスワードでログインしてください。'),
          ),
        );
      } finally {
        if (!mounted) return;
        setState(() => _isLoading = false);
      }
    }
  }

  // ログイン成功時に生体認証を有効にするオプションを表示
  Future<void> _showBiometricEnableDialog() async {
    if (!mounted) return;

    if (await _biometricAuth.isBiometricAvailable()) {
      if (!mounted) return;

      final enable = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('生体認証の設定'),
          content: Text('次回から生体認証でログインできるようにしますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('いいえ'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('はい'),
            ),
          ],
        ),
      );

      if (enable == true && mounted) {
        final token = await FirebaseAuth.instance.currentUser?.getIdToken();
        if (token != null) {
          await _biometricAuth.saveAuthToken(token);
        }
      }
    }
  }

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        // FCMトークンを取得
        final prefs = await SharedPreferences.getInstance();
        final fcmToken = prefs.getString('fcm_token');

        // FCMトークンを更新するミューテーション
        await ref.read(graphQLClientProvider).mutate(
              MutationOptions(
                document: gql('''
                  mutation UpdateUserData(\$input: UpdateUserDataInput!) {
                    updateUserData(input: \$input) {
                      userInfo {
                        id
                        name
                        imageUrl
                      }
                    }
                  }
                '''),
                variables: {
                  'input': {
                    'id': userCredential.user!.uid,
                    'fcmToken': fcmToken,
                  },
                },
              ),
            );

        // カスタムトークンを取得して保存
        final token = await userCredential.user?.getIdToken();
        if (token != null) {
          await _biometricAuth.saveAuthToken(token);
        }

        final userData = await ref.read(graphQLClientProvider).query(
              QueryOptions(
                document: gql('''
              query GetUserData(\$userId: String!) {
                getUserData(userId: \$userId) {
                  id
                  name
                  imageUrl
                  fspBalance
                  credentialBalance
                  role
                  primaryRole
                  greeting
                  skill
                  xHandle
                  instagramHandle
                  fbHandle
                  interestOffer
                  createdAt
                  belongsToArtists {
                    id
                    artistId
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                  primaryArtist {
                    id
                    artistId
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                }
              }
            '''),
                variables: {
                  'userId': userCredential.user!.uid,
                },
                fetchPolicy: FetchPolicy.noCache,
              ),
            );

        await ref.read(authProvider.notifier).setAuthInfo(userCredential.user!);
        ref.read(userProvider.notifier).updateUser(
              UserData.fromJson(
                  userData.data?['getUserData'] as Map<String, dynamic>),
            );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MainScreen()),
        );

        // ログイン成功後に生体認証の設定を提案
        await _showBiometricEnableDialog();
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'ユーザーが見つかりません';
        } else if (e.code == 'wrong-password') {
          message = 'パスワードが間違っています';
        } else {
          message = 'ログインに失敗しました: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラーが発生しました: $e')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'メールアドレス'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'メールアドレスを入力してください';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'パスワード'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'パスワードを入力してください';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),
                if (_isBiometricAvailable) ...[
                  SizedBox(height: 16),
                  IconButton(
                    icon: Icon(Icons.fingerprint),
                    onPressed: () => _authenticateWithBiometrics(),
                    iconSize: 40,
                  ),
                ],
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _signIn,
                        child: Text('ログイン'),
                      ),
                SizedBox(height: 16),
                TextButton(
                  child: Text(
                    '新規登録',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPasswordPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'パスワードをお忘れの方はこちら',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ログアウト時にトークンを削除
  Future<void> logout() async {
    await _biometricAuth.deleteAuthToken();
    await FirebaseAuth.instance.signOut();
  }
}
