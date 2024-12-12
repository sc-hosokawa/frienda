import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/widgets/message/message_room.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql/client.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:intl/intl.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({super.key});

  @override
  ConsumerState<MessageList> createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  // final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  void Function()? _refetch;

  @override
  void dispose() {
    _recipientController.dispose();
    super.dispose();
  }

  void _showUserListDialog() {
    final searchController = TextEditingController();
    final searchNotifier = ValueNotifier<String>('');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ユーザーを選択'),
        content: SizedBox(
          width: 300,
          height: 400,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'ユーザー名を入力',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) => searchNotifier.value = value,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: searchNotifier,
                  builder: (context, String searchText, _) {
                    if (searchText.isEmpty) {
                      return const Center(child: Text('ユーザー名を入力してください'));
                    }

                    return Query(
                      options: QueryOptions(
                        document: gql('''
                          query SearchUsers(\$username: String!) {
                            searchUsers(username: \$username) {
                              id
                              name
                              realname
                              imageUrl
                            }
                          }
                        '''),
                        variables: {'username': searchText},
                      ),
                      builder: (result, {refetch, fetchMore}) {
                        if (result.hasException) {
                          return Center(
                              child: Text(result.exception.toString()));
                        }

                        if (result.isLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        final users =
                            result.data?['searchUsers'] as List<dynamic>? ?? [];
                        if (users.isEmpty) {
                          return const Center(child: Text('ユーザーが見つかりません'));
                        }

                        final currentUserId = ref.read(userProvider)?.id;

                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: users.length,
                          itemBuilder: (context, index) {
                            final user = users[index];
                            if (user['id'] == currentUserId) {
                              return const SizedBox.shrink();
                            }

                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: user['imageUrl'] != null
                                    ? NetworkImage(user['imageUrl'] as String)
                                    : null,
                                child: user['imageUrl'] == null
                                    ? const Icon(Icons.person)
                                    : null,
                              ),
                              title: Text(user['name'] as String),
                              subtitle: Text(user['realname'] as String? ?? ''),
                              onTap: () async {
                                print(
                                    'Selected user: ${user['id']} - ${user['name']}');

                                if (!context.mounted) return;
                                Navigator.of(context).pop();

                                if (!context.mounted) return;
                                await _createRoom(user['id'] as String);
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
        ],
      ),
    );
  }

  Future<void> _createRoom(String recipientId) async {
    print('Creating room with recipient: $recipientId');

    final currentUserId = ref.read(userProvider)?.id;
    print('Current user ID: $currentUserId');

    final result = await ref.read(graphQLClientProvider).mutate(
          MutationOptions(
            document: gql('''
          mutation CreateNewMessageRoom(\$input: CreateNewMessageRoomInput!) {
            createNewMessageRoom(input: \$input) {
              id
            }
          }
        '''),
            variables: {
              'input': {
                'createdBy': currentUserId ?? '',
                'userList': [currentUserId ?? '', recipientId],
                'category': 'dm',
              },
            },
          ),
        );

    print('Mutation result: ${result.data}');
    if (result.hasException) {
      print('Mutation error: ${result.exception}');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.exception.toString())),
        );
      }
      return;
    }

    if (!context.mounted) return;
    _refetch?.call();

    final roomId = result.data?['createNewMessageRoom']['id'] as String?;
    print('Created room ID: $roomId');

    if (roomId != null && context.mounted) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MessageRoom(roomId: roomId),
        ),
      );
    }
  }

  String _formatDateTime(String? dateTimeStr) {
    if (dateTimeStr == null) return '';

    final dateTime = DateTime.parse(dateTimeStr).toLocal();
    final now = DateTime.now();
    final formatter = DateFormat('M/d HH:mm');

    if (dateTime.year == now.year) {
      return formatter.format(dateTime);
    }
    return DateFormat('yyyy/M/d HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userProvider)?.id ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('メッセージ一覧'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showUserListDialog,
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query GetMessageRooms(\$userId: String!) {
              getMessageRooms(userId: \$userId) {
                messageRoomList {
                  id
                  category
                  latestMessage
                  latestMessageId
                  latestSentAt
                  isRead
                  users {
                    id
                    name
                    imageUrl
                  }
                  latestMessage
                }
                countOfMessageRooms
              }
            }
          '''),
          variables: {
            'userId': userId,
          },
        ),
        builder: (QueryResult result,
            {VoidCallback? refetch, FetchMore? fetchMore}) {
          _refetch = refetch;
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final messageRooms = result.data?['getMessageRooms']
                  ['messageRoomList'] as List<dynamic>? ??
              [];

          // メッセージルームを最新のメッセージ順にソート
          messageRooms.sort((a, b) {
            final aTime = a['latestSentAt'] as String?;
            final bTime = b['latestSentAt'] as String?;
            if (aTime == null) return 1;
            if (bTime == null) return -1;
            return DateTime.parse(bTime).compareTo(DateTime.parse(aTime));
          });

          if (messageRooms.isEmpty) {
            return const Center(
              child: Text('No message yet'),
            );
          }

          return ListView.builder(
            itemCount: messageRooms.length,
            itemBuilder: (context, index) {
              final room = messageRooms[index];
              final otherUsers = (room['users'] as List<dynamic>?)
                      ?.where((user) => user['id'] != userId)
                      .toList() ??
                  [];
              final otherUser = otherUsers.isNotEmpty ? otherUsers.first : null;
              final isUnread = room['isRead'] != true;

              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: otherUser?['imageUrl'] != null
                      ? NetworkImage(otherUser!['imageUrl'] as String)
                      : null,
                  child: otherUser?['imageUrl'] == null
                      ? const Icon(Icons.person)
                      : null,
                ),
                title: Text(
                  otherUser?['name'] as String? ?? 'Unknown User',
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                subtitle: Text(
                  room['latestMessage'] as String? ?? 'No messages',
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                trailing: Text(
                  _formatDateTime(room['latestSentAt'] as String?),
                  style: TextStyle(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
                tileColor: isUnread ? Colors.grey[800] : null,
                onTap: () async {
                  final currentUserId = ref.read(userProvider)?.id;
                  if (currentUserId == null) return;

                  // latestMessageIdが存在する場合のみ既読処理を実行
                  final latestMessageId = room['latestMessageId'] as String?;
                  if (latestMessageId != null) {
                    await _markAsRead(
                      roomId: room['id'] as String,
                      userId: currentUserId,
                      messageId: latestMessageId,
                    );
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MessageRoom(roomId: room['id'] as String),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _markAsRead({
    required String roomId,
    required String userId,
    required String messageId,
  }) async {
    try {
      final result = await ref.read(graphQLClientProvider).mutate(
            MutationOptions(
              document: gql('''
            mutation MarkAsRead(\$input: MarkAsReadInput!) {
              markAsRead(input: \$input) {
                isSuccess
              }
            }
          '''),
              variables: {
                'input': {
                  'roomId': roomId,
                  'userId': userId,
                  'messageId': messageId,
                },
              },
            ),
          );

      if (result.hasException) {
        print('Error marking message as read: ${result.exception}');
      }
    } catch (e) {
      print('Error marking message as read: $e');
    }
  }
}
