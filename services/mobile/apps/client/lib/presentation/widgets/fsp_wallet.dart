import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/fsp/transfer.dart';
import 'package:client/presentation/widgets/fsp/exchange.dart';
import 'package:client/presentation/widgets/fsp/receive.dart';
import 'package:client/presentation/widgets/fsp/purchase.dart';
import 'package:client/presentation/widgets/fsp/transactions.dart';
import 'package:client/presentation/widgets/fsp/tx_detail.dart';
import 'package:client/routing/navigation.dart';

class Fsp extends StatelessWidget {
  const Fsp({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
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
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '取引履歴',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              TextButton(
                onPressed: () {
                  navigateWithFadeTransition(context, const Transactions());
                },
                child:
                    const Text('もっと見る', style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.history),
                title: Text('取引 ${index + 1}'),
                subtitle: Text('10,000 fsp'),
                trailing: Text('2023/04/${index + 1}'),
                onTap: () {
                  navigateWithFadeTransition(
                    context,
                    TxDetail(txId: index.toString()),
                  );
                },
              );
            },
          ),
        ),
      ],
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
