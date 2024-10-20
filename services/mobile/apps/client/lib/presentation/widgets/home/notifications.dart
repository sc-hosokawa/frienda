import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  final List<Map<String, String>> _notifications = const [
    {
      'title': 'New follower',
      'message': 'John Doe started following you',
      'time': '2 hours ago'
    },
    {
      'title': 'New like',
      'message': 'Your post received a new like',
      'time': '4 hours ago'
    },
    {
      'title': 'New comment',
      'message': 'Someone commented on your post',
      'time': 'Yesterday'
    },
    {
      'title': 'System update',
      'message': 'New features are available',
      'time': '2 days ago'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            AppBar(
              title: const Text('Notifications'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  final notification = _notifications[index];
                  return _buildListItem(
                    context: context,
                    title: notification['title']!,
                    message: notification['message']!,
                    time: notification['time']!,
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
    required String title,
    required String message,
    required String time,
  }) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: Text(title),
      subtitle: Text(message),
      trailing: Text(time, style: const TextStyle(color: Colors.grey)),
      onTap: () {
        // タップ時の処理をここに追加
        print('Notification tapped: $title');
      },
    );
  }
}
