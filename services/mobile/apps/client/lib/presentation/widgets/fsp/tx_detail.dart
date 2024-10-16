import 'package:flutter/material.dart';

class TxDetail extends StatelessWidget {
  final String txId;
  const TxDetail({super.key, required this.txId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('取引詳細 $txId'),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Card(
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ユーザー名: 山田太郎',
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Text('日時: 2023年4月1日 14:30',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 8),
                  Text('ポイント: 1000 pt',
                      style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
