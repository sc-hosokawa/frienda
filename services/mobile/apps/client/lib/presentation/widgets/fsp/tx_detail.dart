import 'package:flutter/material.dart';

class TxDetail extends StatelessWidget {
  final String txId;
  const TxDetail({super.key, required this.txId});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('取引詳細 $txId'),
      ],
    );
  }
}
