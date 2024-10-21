import 'package:flutter/material.dart';
import 'home/notifications.dart';
import 'more/setting.dart';
// import 'more/helpme.dart';
import 'more/about.dart';

class More extends StatelessWidget {
  const More({super.key});

  final List<Map<String, dynamic>> _items = const [
    {
      'icon': Icons.notifications,
      'title': '通知',
      'description': '届いた通知を確認します',
    },
    {
      'icon': Icons.settings,
      'title': '設定',
      'description': 'アプリの設定を変更します',
    },
    /*
    {
      'icon': Icons.help,
      'title': 'ヘルプ',
      'description': 'よくある質問と回答',
    },
     */
    {
      'icon': Icons.info,
      'title': 'アプリについて',
      'description': 'バージョン情報と利用規約',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: const Text('その他'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return _buildListItem(
                    context: context,
                    icon: item['icon'] as IconData,
                    title: item['title'] as String,
                    description: item['description'] as String,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final bool hasUnreadNotifications =
        title == '通知' && _hasUnreadNotifications();

    return ListTile(
      leading: Badge(
        isLabelVisible: hasUnreadNotifications,
        child: Icon(icon),
      ),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        if (title == '通知') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Notifications()),
          );
        } else if (title == '設定') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Setting()),
          );
        }
        /*
        else if (title == 'ヘルプ') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HelpMe()),
          );
        }
         */
        else if (title == 'アプリについて') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const About()),
          );
        }
      },
    );
  }

  bool _hasUnreadNotifications() {
    // TODO: Implement logic to check for unread notifications
    return true; // Temporary return value for demonstration
  }
}
