import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/widgets/message/message_room.dart';
import 'package:client/data/graphql/schema.graphql.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql/client.dart';
import 'package:client/data/graphql/query.graphql.dart';
import 'package:client/data/graphql/mutation.graphql.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:intl/intl.dart';

class MessageList extends ConsumerStatefulWidget {
  const MessageList({super.key});

  @override
  ConsumerState<MessageList> createState() => _MessageListState();
}

class _MessageListState extends ConsumerState<MessageList> {
  final _formKey = GlobalKey<FormState>();
  final _recipientController = TextEditingController();
  void Function()? _refetch;

  @override
  void dispose() {
    _recipientController.dispose();
    super.dispose();
  }

  void _showUserListDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ユーザーを選択'),
        content: SizedBox(
          width: double.maxFinite,
          child: Query$GetAllUsers$Widget(
            builder: (result, {refetch, fetchMore}) {
              if (result.hasException) {
                return Center(child: Text(result.exception.toString()));
              }

              if (result.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final users = result.data?['getAllUsers']['users'];
              if (users == null || users.isEmpty) {
                return const Center(child: Text('ユーザーデータを取得できませんでした'));
              }

              print('GraphQL Response:Users: ${users[0]['id']}');

              final currentUserId = ref.read(userProvider)?.id;

              return ListView.builder(
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  // Skip current user
                  if (user['id'] == currentUserId)
                    return const SizedBox.shrink();

                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: user['imageUrl'] != null
                          ? NetworkImage(user['imageUrl']!)
                          : null,
                      child: user['imageUrl'] == null
                          ? const Icon(Icons.person)
                          : null,
                    ),
                    title: Text(user['name'] as String),
                    onTap: () {
                      Navigator.pop(context);
                      _createRoom(user['id'] as String);
                    },
                  );
                },
              );
            },
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
    final variables = Variables$Mutation$CreateNewMessageRoom(
      input: Input$CreateNewMessageRoomInput(
        createdBy: ref.read(userProvider)?.id ?? '',
        userList: [ref.read(userProvider)?.id ?? '', recipientId],
        category: 'dm',
      ),
    );

    final result =
        await ref.read(graphQLClientProvider).mutate$CreateNewMessageRoom(
              Options$Mutation$CreateNewMessageRoom(
                variables: variables,
              ),
            );

    if (result.hasException) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.exception.toString())),
        );
      }
      return;
    }

    if (context.mounted) {
      Navigator.pop(context);
      _refetch?.call();

      final roomId =
          result.data?['createNewMessageRoom']['messageRoom']['id'] as String?;
      if (roomId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageRoom(roomId: roomId),
          ),
        );
      }
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
      body: Query$GetMessageRooms$Widget(
        options: Options$Query$GetMessageRooms(
          variables: Variables$Query$GetMessageRooms(
            userId: userId,
          ),
        ),
        builder: (result, {refetch, fetchMore}) {
          _refetch = refetch;
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          print('GraphQL Response:Rooms: ${result.data}');

          final messageRooms = result.data?['getMessageRooms']
                  ['messageRoomList'] as List<dynamic>? ??
              [];

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
                onTap: () {
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
}
