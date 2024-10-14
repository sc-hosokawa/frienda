import 'package:flutter/material.dart';

class More extends StatelessWidget {
  const More({super.key});

  final List<Map<String, dynamic>> _items = const [
    {
      'icon': Icons.money,
      'title': 'FSP',
      'description': 'ポイントの操作をします',
    },
    {
      'icon': Icons.settings,
      'title': '設定',
      'description': 'アプリの設定を変更します',
    },
    {
      'icon': Icons.help,
      'title': 'ヘルプ',
      'description': 'よくある質問と回答',
    },
    {
      'icon': Icons.info,
      'title': 'アプリについて',
      'description': 'バージョン情報と利用規約',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items.length,
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildListItem(
          icon: item['icon'] as IconData,
          title: item['title'] as String,
          description: item['description'] as String,
        );
      },
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        // TODO: Implement onTap functionality
      },
    );
  }
}
