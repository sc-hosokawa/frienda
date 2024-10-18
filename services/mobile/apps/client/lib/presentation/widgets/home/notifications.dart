import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('Notifications'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: NotificationList(),
        ),
      ],
    );
  }
}

class NotificationList extends StatelessWidget {
  NotificationList({super.key});

  // ダミーデータ。実際のアプリケーションではこれをAPIやデータベースから取得します。
  final List<Map<String, String>> notifications = [
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
    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          leading: Icon(Icons.notifications),
          title: Text(notification['title']!),
          subtitle: Text(notification['message']!),
          trailing:
              Text(notification['time']!, style: TextStyle(color: Colors.grey)),
          onTap: () {
            // タップ時の処理をここに追加
            print('Notification tapped: ${notification['title']}');
          },
        );
      },
    );
  }
}
