import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/fsp/tx_detail.dart';

class Transactions extends StatelessWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: const Text('取引履歴'),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            centerTitle: true,
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('取引 ${index + 1}'),
                subtitle: Text('取引の詳細情報'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TxDetail(txId: index.toString()),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
