import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/message/message_room.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

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
          return ListTile(
            leading: CircleAvatar(
              child: Text('U${index + 1}'),
            ),
            title: Text('User ${index + 1}'),
            subtitle: Text('Latest message from User ${index + 1}'),
            trailing: Text('${index + 1}m ago'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MessageRoom()),
              );
            },
          );
        },
      ),
    );
  }
}
