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

  void _showCreateRoomDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('新規メッセージ'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _recipientController,
            decoration: const InputDecoration(
              labelText: 'ユーザー名またはメールアドレス',
              hintText: 'ユーザー名またはメールアドレスを入力',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '入力は必須です';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final variables = Variables$Mutation$CreateNewMessageRoom(
                  input: Input$CreateNewMessageRoomInput(
                    createdBy: ref.read(userProvider)?.id ?? '',
                    userList: [
                      ref.read(userProvider)?.id ?? '',
                      _recipientController.text
                    ],
                    category: 'dm',
                  ),
                );

                final result = await ref
                    .read(graphQLClientProvider)
                    .mutate$CreateNewMessageRoom(
                      Options$Mutation$CreateNewMessageRoom(
                        variables: variables,
                      ),
                    );

                print('GraphQL Response: ${result.data}');

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
                  _recipientController.clear();
                  _refetch?.call();
                }
              }
            },
            child: const Text('メッセージする'),
          ),
        ],
      ),
    );
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
            onPressed: _showCreateRoomDialog,
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
              final isUnread = room['isRead'] != true;

              return ListTile(
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
                title: Text(
                  room['category'] as String? ?? 'No Category',
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
