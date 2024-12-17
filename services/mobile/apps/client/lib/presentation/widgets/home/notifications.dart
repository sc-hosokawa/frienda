import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Notifications extends ConsumerStatefulWidget {
  const Notifications({super.key});

  @override
  ConsumerState<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends ConsumerState<Notifications> {
  static final GET_NOTIFICATIONS = gql('''
    query GetNotifications(\$userId: String!) {
      getNotifications(userId: \$userId) {
        id
        title
        content
        isRead
        createdAt
      }
    }
  ''');

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider);
    return Material(
      child: SafeArea(
        child: Query(
          options: QueryOptions(
            document: GET_NOTIFICATIONS,
            variables: {
              'userId': user?.id ?? '',
            },
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Center(child: Text(result.exception.toString()));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            print(user?.id);
            print(result.data);

            final notifications = result.data?['getNotifications'] ?? [];

            return Column(
              children: [
                AppBar(
                  title: const Text('Notifications'),
                  titleTextStyle: Theme.of(context).textTheme.titleMedium,
                  centerTitle: true,
                ),
                Expanded(
                  child: notifications.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.notifications_none,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '通知はありません',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.grey,
                                    ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return _buildListItem(
                              context: context,
                              id: notification['id'],
                              title: notification['title'],
                              message: notification['content'],
                              time: _formatDateTime(notification['createdAt']),
                              isRead: notification['isRead'],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required String id,
    required String title,
    required String message,
    required String time,
    required bool isRead,
  }) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: Text(title),
      subtitle: Text(message),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(time, style: const TextStyle(color: Colors.grey)),
          if (!isRead)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'NEW',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        print('Notification tapped: $title');
      },
    );
  }

  String _formatDateTime(String dateTimeStr) {
    final date = DateTime.parse(dateTimeStr).toLocal();
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
