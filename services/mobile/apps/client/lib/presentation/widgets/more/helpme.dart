import 'package:flutter/material.dart';

class HelpMe extends StatelessWidget {
  const HelpMe({super.key});

  final List<Map<String, dynamic>> _helpItems = const [
    {
      'icon': Icons.question_answer,
      'title': 'よくある質問',
      'description': 'FAQ一覧を確認します',
    },
    {
      'icon': Icons.contact_support,
      'title': 'お問い合わせ / 不具合報告',
      'description': 'サポートチームに連絡します',
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
                itemCount: _helpItems.length,
                itemBuilder: (context, index) {
                  final item = _helpItems[index];
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
