import 'package:flutter/material.dart';
import 'package:contentful_rich_text/contentful_rich_text.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class NewsDetailPage extends StatelessWidget {
  const NewsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // ルート引数を取得
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final title = args['title'] as String? ?? 'No Title';
    final body = args['body'] ?? 'No Content';
    final imageUrl = args['imageUrl'] as String?;
    final category = args['category'] as String? ?? '';
    final date = args['date'] as String? ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (imageUrl != null)
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getCategoryColor(category).withOpacity(0.8),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      category.toUpperCase(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date != ''
                        ? DateFormat('yyyy/MM/dd HH:mm')
                            .format(DateTime.parse(date).toLocal())
                        : '',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    child: ContentfulRichText(body).documentToWidgetTree,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toUpperCase()) {
      case 'INFO':
        return Color(0xFFB487FF);
      case 'FRIENDSHIP. DAO':
        return Color(0xFF00B496);
      case 'FRIENDSHIP.':
        return Color(0xFF2D78FF);
      default:
        return Colors.black;
    }
  }
}
