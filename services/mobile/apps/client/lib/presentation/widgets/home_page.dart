import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/widgets/message/message_list.dart';
import 'package:client/presentation/widgets/message/message_room.dart';
import 'package:client/presentation/providers/auth_provider.dart';
import 'package:client/data/graphql/schema.graphql.dart';
import 'package:client/data/graphql/query.graphql.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql/client.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final _isLoading = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _isLoading.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    return SingleChildScrollView(
      key: PageStorageKey('home_page'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildActionsSection(),
          // _buildNewsSection(),
          _buildMessagesSection(key: UniqueKey()),
          _buildTrendingSection(),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildActionsSection() {
    final List<String> actions = [];

    if (actions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('Actions', style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: actions.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(
                    left: 16, right: index == actions.length - 1 ? 16 : 0),
                child: SizedBox(
                  width: 240,
                  child: Center(child: Text(actions[index])),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // TODO: Unreadを最大5件表示、5件ない場合は最新のメッセを全体で5件になるまで取得。なお未読のメッセはハイライトする。
  Widget _buildMessagesSection({Key? key}) {
    final client = ref.watch(graphQLClientProvider);
    final userState = ref.watch(userProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Messages', style: Theme.of(context).textTheme.titleMedium),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MessageList()),
                  );
                },
                child: Text('View all'),
              ),
            ],
          ),
        ),
        FutureBuilder<QueryResult<Query$GetMessagesInProgress>>(
          future: client.query$GetMessagesInProgress(
            Options$Query$GetMessagesInProgress(
              variables: Variables$Query$GetMessagesInProgress(
                userId: userState?.id ?? '',
              ),
            ),
          ),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text('Error loading messages'));
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            final data = snapshot.data?.data;
            if (data == null) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('No messages yet'),
                ),
              );
            }

            final messageRooms = (data['getMessagesInProgress']
                as Map<String, dynamic>)['messageRoomList'] as List<dynamic>?;

            if (messageRooms == null || messageRooms.isEmpty) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text('No messages yet'),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: messageRooms.length,
              itemBuilder: (context, index) {
                final room = messageRooms[index] as Map<String, dynamic>;
                return Container(
                  color: room['isRead'] == true ? null : Colors.grey[800],
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MessageRoom(
                            roomId: room['id'] as String,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Text('M'),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  room['category'] as String? ?? 'No category',
                                  style: TextStyle(
                                    fontWeight: room['isRead'] == true
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  room['latestMessage'] as String? ??
                                      'No message',
                                  style: TextStyle(
                                    fontWeight: room['isRead'] == true
                                        ? FontWeight.normal
                                        : FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (room['latestSentAt'] != null)
                            Text(room['latestSentAt'] as String),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );
  }

/*
  Widget _buildNewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('News', style: Theme.of(context).textTheme.titleSmall),
        ),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // 仮のアイテム数
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(left: 16, right: index == 4 ? 16 : 0),
                child: SizedBox(
                  width: 300,
                  child: Center(child: Text('News ${index + 1}')),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
*/

  Widget _buildTrendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Text('Trending', style: Theme.of(context).textTheme.titleMedium),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return _buildTrendingItem(index);
          },
        ),
      ],
    );
  }

  Widget _buildTrendingItem(int index) {
    final rank = index + 1;
    final isUp = index % 2 == 0;
    final changeIcon = isUp ? Icons.arrow_upward : Icons.arrow_downward;
    final changeColor = isUp ? Colors.green : Colors.red;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Icon(changeIcon, color: changeColor),
          const SizedBox(width: 10),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://ogre.natalie.mu/media/news/music/2024/0913/Thefin_jkt2014.jpg?imwidth=750&imdensity=1'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Song name $rank',
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Total: ${1000000 - index * 100000}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Week: ${100000 - index * 10000}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Add this method to check if a message is unread
  bool _isMessageUnread(int index) {
    // TODO: Implement actual logic to check if the message is unread
    return index % 2 == 0; // For demonstration, every other message is unread
  }
}
