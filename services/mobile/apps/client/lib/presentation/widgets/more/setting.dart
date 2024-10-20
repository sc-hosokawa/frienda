import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  final List<Map<String, dynamic>> _settingsItems = const [
    /*
    {
      'icon': Icons.language,
      'title': '言語設定',
      'description': 'アプリの表示言語を変更します',
    },
     */
    {
      'icon': Icons.notifications_active,
      'title': '通知設定',
      'description': '通知の ON/OFF や種類を設定します',
    },
    {
      'icon': Icons.color_lens,
      'title': 'テーマ設定',
      'description': 'アプリの配色やダークモードを設定します',
    },
    {
      'icon': Icons.account_circle,
      'title': 'アカウント設定',
      'description': 'ユーザー情報の変更や退会手続きを行います',
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
                itemCount: _settingsItems.length,
                itemBuilder: (context, index) {
                  final item = _settingsItems[index];
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
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // TODO: Implement setting item tap logic
      },
    );
  }
}
