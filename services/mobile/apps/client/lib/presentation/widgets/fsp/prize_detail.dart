import 'package:flutter/material.dart';

class PrizeDetail extends StatelessWidget {
  final String itemName;
  final String itemPrice;
  final String itemImage;

  const PrizeDetail({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: Text(itemName),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  itemImage,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        itemName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        itemPrice,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'アイテムの詳細説明がここに入ります。実際のアプリケーションでは、このテキストをサーバーから取得するか、アイテムごとに適切な説明を用意する必要があります。',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // TODO: 交換処理を実装
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$itemNameを交換しました')),
                            );
                          },
                          child: const Text('交換する'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
