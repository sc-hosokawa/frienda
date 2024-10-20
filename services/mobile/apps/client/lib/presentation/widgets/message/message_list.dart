import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/message/message_room.dart';

class MessageList extends StatefulWidget {
  const MessageList({super.key});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  final List<bool> _readStatus = List.generate(10, (index) => index % 3 != 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('メッセージ一覧'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final isUnread = !_readStatus[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text('U${index + 1}'),
            ),
            title: Text(
              'User ${index + 1}',
              style: TextStyle(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Text(
              'Latest message from User ${index + 1}',
              style: TextStyle(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: Text(
              '${index + 1}m ago',
              style: TextStyle(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            tileColor: isUnread ? Colors.grey[800] : null, // 未読の場合、背景を明るく
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageRoom()),
              ).then((_) {
                setState(() {
                  _readStatus[index] = true;
                });
              });
            },
          );
        },
      ),
    );
  }
}
