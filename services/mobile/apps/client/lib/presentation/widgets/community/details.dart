import 'package:flutter/material.dart';

class NodeDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> node;

  const NodeDetailPage({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('ユーザー詳細'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/logo_visualonly.jpg'),
                  ),
                ),
                SizedBox(height: 20),
                Text('ID: ${node['id']}',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Type: ${node['tag']}'),
                SizedBox(height: 10),
                Text('Tags: ${node['tags'].join(', ')}'),
                // 他の属性を表示する場合はここに追加
              ],
            ),
          ),
        ),
      ],
    );
  }
}
