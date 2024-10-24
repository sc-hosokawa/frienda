import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/fsp/transfer.dart';
import 'package:client/presentation/widgets/fsp/exchange.dart';
import 'package:client/presentation/widgets/fsp/receive.dart';
import 'package:client/presentation/widgets/fsp/purchase.dart';
import 'package:client/presentation/widgets/fsp/transactions.dart';
import 'package:client/routing/navigation.dart';
import 'package:client/presentation/widgets/fsp/allocation.dart';
import 'package:client/presentation/widgets/fsp/prize_detail.dart';
import 'package:intl/intl.dart';

class Fsp extends StatelessWidget {
  const Fsp({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 5 / 6,
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '1,000 fsp',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    const Divider(),
                    Text(
                      '期間限定 100 fsp',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.right,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'クレデンシャル 15 cred',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildMenuButton(context, '送付', Icons.send),
              _buildMenuButton(context, '受取', Icons.call_received),
              _buildMenuButton(context, '購入', Icons.shopping_cart),
              _buildMenuButton(context, '交換', Icons.swap_horiz),
              _buildMenuButton(context, '分配', Icons.pie_chart),
            ],
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'おすすめの景品',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton(
                  onPressed: () {
                    navigateWithFadeTransition(context, const Exchange());
                  },
                  child: const Text('もっと見る',
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      navigateWithFadeTransition(
                        context,
                        PrizeDetail(
                          itemName: 'アイテム ${index + 1}',
                          itemPrice: '${(index + 1) * 100} FSP',
                          itemImage: 'https://placehold.jp/150x150.png',
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 150,
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: Image.network(
                                  'https://placehold.jp/150x150.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'アイテム ${index + 1}',
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                  Text(
                                    '${(index + 1) * 100} FSP',
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '取引履歴 (最新5件)',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                TextButton(
                  onPressed: () {
                    navigateWithFadeTransition(context, const Transactions());
                  },
                  child: const Text('もっと見る',
                      style: TextStyle(color: Colors.green)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 360,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                final isIncoming = index % 2 == 0;
                final date = DateTime.now().subtract(Duration(days: index));
                final formattedDate =
                    DateFormat('yyyy/MM/dd HH:mm').format(date);
                final points = (index + 1) * 1000;

                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isIncoming ? Icons.arrow_downward : Icons.arrow_upward,
                        color: isIncoming ? Colors.green : Colors.red,
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      CircleAvatar(
                        child: Text('${index + 1}'),
                      ),
                    ],
                  ),
                  title: Text('取引相手 ${index + 1}'),
                  subtitle: Text(formattedDate),
                  trailing: Text(
                    '${isIncoming ? "+" : "-"}$points fsp',
                    style: TextStyle(
                      color: isIncoming ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String label, IconData icon) {
    return SizedBox(
      width: 60,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Widget? destinationWidget;
          switch (label) {
            case '送付':
              destinationWidget = Transfer();
              break;
            case '受取':
              destinationWidget = const Receive();
              break;
            case '購入':
              destinationWidget = const Purchase();
              break;
            case '交換':
              destinationWidget = const Exchange();
              break;
            case '分配':
              destinationWidget = const Allocation(); // 追加
              break;
          }
          if (destinationWidget != null) {
            navigateWithFadeTransition(context, destinationWidget);
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
