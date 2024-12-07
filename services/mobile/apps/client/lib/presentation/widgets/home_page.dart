import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/widgets/message/message_list.dart';
import 'package:client/presentation/widgets/message/message_room.dart';
import 'package:client/presentation/providers/auth_provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql/client.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/number_symbols_data.dart';

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
    return SingleChildScrollView(
      key: PageStorageKey('home_page'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _buildActionsSection(),
          // const Divider(height: 1, thickness: 1, color: Colors.black12),
          // _buildNewsSection(),
          _buildMessagesSection(key: UniqueKey()),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(255, 50, 50, 50),
            ),
          ),
          const SizedBox(height: 4),
          _buildTrendingSection(),
          const SizedBox(height: 16),
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

  Widget _buildMessagesSection({Key? key}) {
    final userState = ref.watch(userProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/message.svg',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 8),
                  Text('Active Message Rooms',
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
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
        Query(
          options: QueryOptions(
            document: gql('''
              query GetMessageRooms(\$userId: String!) {
                getMessageRooms(userId: \$userId) {
                  messageRoomList {
                    id
                    category
                    latestMessage
                    latestSentAt
                    isRead
                    users {
                      id
                      name
                      imageUrl
                    }
                  }
                  countOfMessageRooms
                }
              }
            '''),
            variables: {
              'userId': userState?.id ?? '',
            },
            fetchPolicy: FetchPolicy.networkOnly,
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Center(child: Text('Error loading messages'));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final messageRooms = result.data?['getMessageRooms']
                    ['messageRoomList'] as List<dynamic>? ??
                [];

            // Sort messages by latestSentAt in descending order (newest first)
            messageRooms.sort((a, b) {
              try {
                final aTime = a['latestSentAt'] != null
                    ? DateTime.parse(a['latestSentAt'])
                    : DateTime(1900);
                final bTime = b['latestSentAt'] != null
                    ? DateTime.parse(b['latestSentAt'])
                    : DateTime(1900);
                return bTime.compareTo(aTime);
              } catch (e) {
                print('Date parsing error: ${e.toString()}');
                return 0;
              }
            });

            // Take only the first 5 messages
            final displayMessages = messageRooms.take(5).toList();

            if (displayMessages.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('No messages yet'),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: displayMessages.length,
              itemBuilder: (context, index) {
                final room = displayMessages[index];
                final isUnread = room['isRead'] != true;

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: room['users']?[0]['imageUrl'] != null
                        ? NetworkImage(room['users'][0]['imageUrl'] as String)
                        : null,
                    child: room['users']?[0]['imageUrl'] == null
                        ? const Icon(Icons.person)
                        : null,
                  ),
                  title: Text(
                    room['users']?[0]['name'] as String? ?? 'Unknown User',
                    style: TextStyle(
                      fontWeight:
                          isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  subtitle: Text(
                    room['latestMessage'] as String? ?? 'No messages',
                    style: TextStyle(
                      fontWeight:
                          isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  trailing: Text(
                    _formatDateTime(room['latestSentAt'] as String?),
                    style: TextStyle(
                      fontWeight:
                          isUnread ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
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
    final userState = ref.watch(userProvider);

    if (userState == null || userState.belongsToArtists.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text('アーティストに所属していません'),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/dashboard.svg',
                width: 20,
                height: 20,
              ),
              const SizedBox(width: 8),
              Text('Trending', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
        Query(
          options: QueryOptions(
            document: gql('''
              query GetTrending(\$artistId: String!, \$userId: String!) {
                getTrending(artistId: \$artistId, userId: \$userId) {
                  trendingTracks {
                    isrc
                    trackTitle
                    upcTitle
                    imageUrl
                    totalPlayCount
                    weeklyPlayCount
                  }
                }
              }
            '''),
            variables: {
              'artistId': userState.belongsToArtists[0].artistId,
              'userId': userState.id,
            },
            fetchPolicy: FetchPolicy.networkOnly,
          ),
          builder: (result, {refetch, fetchMore}) {
            if (result.hasException) {
              return Center(child: Text('Error loading trending data'));
            }

            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final tracks = result.data?['getTrending']?['trendingTracks']
                    as List<dynamic>? ??
                [];

            if (tracks.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text('トレンドデータが�りません'),
                ),
              );
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: tracks.length,
              itemBuilder: (context, index) {
                final track = tracks[index];
                return _buildTrendingItem(
                  index,
                  track['trackTitle'] ?? 'Unknown Track',
                  track['imageUrl'],
                  track['totalPlayCount'] ?? 0,
                  track['weeklyPlayCount'] ?? 0,
                );
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildTrendingItem(int index, String title, String? imageUrl,
      int totalCount, int weeklyCount) {
    final rank = index + 1;
    final numberFormat = NumberFormat('#,###');

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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: imageUrl == null ? const Icon(Icons.music_note) : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
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
                'Total: ${numberFormat.format(totalCount)}',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(
                'Week: ${numberFormat.format(weeklyCount)}',
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

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(dateTimeStr).toLocal();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final messageDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

      // 今日の場合は時刻のみ
      if (messageDate == today) {
        return DateFormat('HH:mm').format(dateTime);
      }
      // 今年の場合は月日と時刻
      else if (dateTime.year == now.year) {
        return DateFormat('M/d HH:mm').format(dateTime);
      }
      // そ以外は年月日と時刻
      return DateFormat('yyyy/M/d HH:mm').format(dateTime);
    } catch (e) {
      print('Date formatting error: ${e.toString()}');
      print('Input dateTimeStr: $dateTimeStr');
      return dateTimeStr; // エラーの場合は元の文字列を返す
    }
  }
}
