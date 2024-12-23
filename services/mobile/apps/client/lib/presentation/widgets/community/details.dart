import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NodeDetailPage extends ConsumerStatefulWidget {
  final String id;

  const NodeDetailPage({super.key, required this.id});

  @override
  ConsumerState<NodeDetailPage> createState() => _NodeDetailPageState();
}

class _NodeDetailPageState extends ConsumerState<NodeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ユーザー詳細'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage('assets/logo_visualonly.jpg'),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'No Name',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildSection('説明', 'No description'),
              _buildSection('スキル', 'No skills'),
              _buildSection('カテゴリ', 'No category'),
              _buildListSection('Offers', []),
              _buildListSection('Connections', []),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String? content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text(content ?? 'Not specified'),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildListSection(String title, List<dynamic>? items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        if (items != null && items.isNotEmpty)
          Column(
            children: items
                .map((item) => ListTile(title: Text(item.toString())))
                .toList(),
          )
        else
          Text('No $title available'),
        SizedBox(height: 15),
      ],
    );
  }
}
