import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:client/presentation/screens/auth/login.dart';
import 'package:client/presentation/widgets/more/update_user_profile.dart';

class AccountSettings extends StatelessWidget {
  const AccountSettings({super.key});

  final List<Map<String, dynamic>> _accountSettingsItems = const [
    {
      'icon': Icons.person,
      'title': 'ユーザー情報の変更',
      'description': 'アカウントのユーザー情報を変更します',
    },
    {
      'icon': Icons.lock,
      'title': 'パスワードの変更',
      'description': 'アカウントのパスワードを変更します',
    },
    {
      'icon': Icons.delete_forever,
      'title': 'アカウントの削除（退会）',
      'description': 'アカウントを完全に削除します',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('アカウント設定'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _accountSettingsItems.length,
        itemBuilder: (context, index) {
          final item = _accountSettingsItems[index];
          return ListTile(
            leading: Icon(item['icon'] as IconData),
            title: Text(item['title'] as String),
            subtitle: Text(item['description'] as String),
            onTap: () => _handleItemTap(context, item['title'] as String),
          );
        },
      ),
    );
  }

  void _handleItemTap(BuildContext context, String title) async {
    switch (title) {
      case 'パスワードの変更':
        await _changePassword(context);
        break;
      case 'ユーザー情報の変更':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UpdateUserProfile()),
        );
        break;
      case 'アカウントの削除（退会）':
        await _deleteAccount(context);
        break;
    }
  }

  Future<void> _changePassword(BuildContext context) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: user.email!);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('パスワード変更用のメールを送信しました。メールをご確認ください。')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('パスワード変更メールの送信に失敗しました: $e')),
      );
    }
  }

  Future<void> _deleteAccount(BuildContext context) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('アカウント削除の確認'),
          content: const Text('本当にアカウントを削除しますか？この操作は取り消せません。'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: const Text('削除'),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await FirebaseAuth.instance.currentUser?.delete();
        await FirebaseAuth.instance.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('アカウントが正常に削除されました。')),
        );
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('アカウントの削除に失敗しました: $e')),
        );
      }
    }
  }
}
