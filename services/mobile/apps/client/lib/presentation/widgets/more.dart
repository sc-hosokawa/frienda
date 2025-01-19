import 'package:flutter/material.dart';
import 'home/notifications.dart';
import 'more/setting.dart';
// import 'more/helpme.dart';
import 'more/about.dart';
import 'package:client/presentation/widgets/more/faq.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/fsp_balance_provider.dart';
import 'package:intl/intl.dart';
import 'package:client/presentation/widgets/fsp_wallet.dart';

class More extends ConsumerWidget {
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
      'description': '設定情報を変更します',
    },
    {
      'icon': Icons.help,
      'title': 'よくある質問',
      'description': 'よくある質問と回答',
    },
    {
      'icon': Icons.info,
      'title': 'アプリについて',
      'description': 'バージョン情報と利用規約',
    },
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceState = ref.watch(balanceStreamProvider);

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: const Text('その他'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Fsp()),
                );
              },
              child: Card(
                margin: const EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.account_balance_wallet,
                        size: 40,
                        color: Color(0xFFE4DBC0),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'FSP残高',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            balanceState.when(
                              data: (balance) => Text(
                                '${NumberFormat('#,###').format(balance.fspBalance)} fsp',
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              loading: () => const CircularProgressIndicator(),
                              error: (err, stack) => const Text(
                                '0 fsp',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right, color: Color(0xFFE4DBC0)),
                    ],
                  ),
                ),
              ),
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
        } else if (title == 'よくある質問') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FAQPage()),
          );
        } else if (title == 'アプリについて') {
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
    return false; // Temporary return value for demonstration
  }
}
