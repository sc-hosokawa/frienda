import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/presentation/screens/main_screen.dart';
import 'package:client/presentation/screens/auth/signin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/auth_provider.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
                    style: TextStyle(fontSize: 14, color: Colors.green),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

        final userData = await ref.read(graphQLClientProvider).query(
              QueryOptions(
                document: gql('''
              query GetUserData(\$userId: String!) {
                getUserData(userId: \$userId) {
                  id
                  email
                  name
                  imageUrl
                  fspBalance
                  credentialBalance
                  role
                  primaryRole
                  belongsToArtists {
                    id
                    name
                    imageUrl
                    fsp
                    status
                    isAdmin
                  }
                  primaryArtist {
                    id
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
              ),
            );

        await ref.read(authProvider.notifier).setAuthInfo(userCredential.user!);

        ref.read(userProvider.notifier).updateUser(
              UserData.fromJson(
                  userData.data?['getUserData'] as Map<String, dynamic>),
            );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const MainScreen()));
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
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}
