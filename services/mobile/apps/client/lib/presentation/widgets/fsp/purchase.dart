import 'package:flutter/material.dart';

class Purchase extends StatelessWidget {
  const Purchase({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('FSPポイント購入'),
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
                Text(
                  '購入するポイント数を選択してください',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 24),
                _buildPurchaseOption(context, '100 FSP', '¥100'),
                _buildPurchaseOption(context, '500 FSP', '¥450'),
                _buildPurchaseOption(context, '1,000 FSP', '¥900'),
                _buildPurchaseOption(context, '5,000 FSP', '¥4,000'),
                _buildPurchaseOption(context, '10,000 FSP', '¥7,500'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPurchaseOption(
      BuildContext context, String points, String price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            // TODO: In App Purchase の処理を実装
            _showPurchaseConfirmation(context, points, price);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
          ),
          child: Text('$points を $price で購入'),
        ),
      ),
    );
  }

  void _showPurchaseConfirmation(
      BuildContext context, String points, String price) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('購入確認'),
          content: Text('$points を $price で購入しますか？'),
          actions: <Widget>[
            TextButton(
              child: const Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('購入する'),
              onPressed: () {
                // TODO: 実際の In App Purchase 処理を実装
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$points を購入しました')),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
