import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/auth_provider.dart';
import 'package:client/presentation/screens/web_view_screen.dart';
import 'package:client/presentation/screens/auth/profile_setup.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  final _linkButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.symmetric(vertical: 4),
    foregroundColor: Colors.white,
    textStyle: TextStyle(fontSize: 12),
  );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text('新規登録')),
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
                      if (value.length < 6) {
                        return 'パスワードは6文字以上で入力してください';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24),
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _register,
                          child: Text('登録'),
                        ),
                  SizedBox(height: 48),
                  Text(
                    '登録をした方は以下の書類に同意したこととみなします',
                    style: TextStyle(fontSize: 12),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextButton(
                        style: _linkButtonStyle,
                        onPressed: () => _openWebView('プライバシーポリシー',
                            'https://app.friendshipdao.xyz/privacypolicy'),
                        child: Text('プライバシーポリシー'),
                      ),
                      TextButton(
                        style: _linkButtonStyle,
                        onPressed: () => _openWebView('利用規約',
                            'https://app.friendshipdao.xyz/termofservice'),
                        child: Text('利用規約'),
                      ),
                      /*
                      TextButton(
                        style: _linkButtonStyle,
                        onPressed: () => _openWebView('特定商取引法',
                            'https://example.com/specified-commercial-transactions'),
                        child: Text('特定商取引法'),
                      ),
                      TextButton(
                        style: _linkButtonStyle,
                        onPressed: () => _openWebView(
                            '資金決済法', 'https://example.com/fund-settlement'),
                        child: Text('資金決済法'),
                      ),
                      */
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _openWebView(String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WebViewScreen(title: title, url: url),
      ),
    );
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );

        final User user = userCredential.user!;

        final String? idToken = await user.getIdToken();
        if (idToken == null) {
          throw Exception('IDトークンの取得に失敗しました');
        }

        await ref.read(authProvider.notifier).setAuthInfo(user);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ProfileSetupScreen(
              user: user,
              initialData: {
                'uid': user.uid,
                'email': user.email ?? '',
                'idToken': idToken,
              },
            ),
          ),
        );
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'weak-password') {
          message = 'パスワードが弱すぎます';
        } else if (e.code == 'email-already-in-use') {
          message = 'このメールアドレスは既に使用されています';
        } else {
          message = '登録に失敗しました: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('エラーが発生しました: ${e.toString()}')),
        );
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }
}
