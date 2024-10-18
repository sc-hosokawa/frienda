import 'package:flutter/material.dart';

class Exchange extends StatelessWidget {
  const Exchange({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('交換'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.network(
                        'https://placehold.jp/150x150.png', // サムネイルのプレースホルダー
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'アイテム ${index + 1}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            '${(index + 1) * 100} FSP',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
