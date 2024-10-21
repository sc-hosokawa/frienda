import 'package:flutter/material.dart';

class NodeDetailPage extends StatelessWidget {
  final Map<dynamic, dynamic> node;

  const NodeDetailPage({super.key, required this.node});

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
                      node['name'] ?? 'No Name',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              _buildSection('説明', node['description']),
              _buildSection('スキル', node['skills']?.join(', ')),
              _buildSection('カテゴリ', node['category']),
              _buildListSection('Offers', node['offers']),
              _buildListSection('Connections', node['connections']),
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
