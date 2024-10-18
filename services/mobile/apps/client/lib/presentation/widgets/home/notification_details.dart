import 'package:flutter/material.dart';

class NotificationDetails extends StatelessWidget {
  const NotificationDetails({super.key});

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
      'time': '2 hours ago',
      'category': 'Social',
      'description':
          'You have a new follower! John Doe has started following your profile. Check out their profile and consider following them back.'
    },
    {
      'title': 'New like',
      'message': 'Your post received a new like',
      'time': '4 hours ago',
      'category': 'Engagement',
      'description':
          'Your recent post "Flutter tips and tricks" has received a new like. Your content is resonating with the community!'
    },
    {
      'title': 'New comment',
      'message': 'Someone commented on your post',
      'time': 'Yesterday',
      'category': 'Engagement',
      'description':
          'A user has left a comment on your post "Best practices for state management". They said: "Great article! I learned a lot from this."'
    },
    {
      'title': 'System update',
      'message': 'New features are available',
      'time': '2 days ago',
      'category': 'System',
      'description':
          'We\'ve added new features to improve your experience. Update your app to access the latest improvements and bug fixes.',
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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    NotificationDetailPage(notification: notification),
              ),
            );
          },
        );
      },
    );
  }
}

class NotificationDetailPage extends StatelessWidget {
  final Map<String, String> notification;

  const NotificationDetailPage({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Details'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification['title']!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 8),
            Text(
              'Category: ${notification['category']}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 8),
            Text(
              'Time: ${notification['time']}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: 16),
            Text(
              'Description:',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              notification['description']!,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
