import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/more/faq.dart';
import 'package:client/presentation/widgets/more/webview_page.dart';

class About extends StatelessWidget {
  const About({super.key});

  final List<Map<String, dynamic>> _aboutItems = const [
    {
      'icon': Icons.info_outline,
      'title': 'アプリバージョン',
      'description': '現在のバージョン: 1.0.3',
    },
    {
      'icon': Icons.description,
      'title': '利用規約',
      'description': 'アプリの利用規約を確認します',
    },
    {
      'icon': Icons.privacy_tip,
      'title': 'プライバシーポリシー',
      'description': '個人情報の取り扱いについて確認します',
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
                itemCount: _aboutItems.length,
                itemBuilder: (context, index) {
                  final item = _aboutItems[index];
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
        String url;
        if (title == '利用規約') {
          url = 'https://app.friendshipdao.xyz/termofservice';
        } else if (title == 'プライバシーポリシー') {
          url = 'https://app.friendshipdao.xyz/privacypolicy';
        } else {
          return;
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebViewPage(url: url, title: title),
          ),
        );
      },
    );
  }
}
