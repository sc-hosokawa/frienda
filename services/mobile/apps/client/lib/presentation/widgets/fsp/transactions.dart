import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用

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
              final isIncoming = index % 2 == 0;
              final date = DateTime.now().subtract(Duration(days: index));
              final formattedDate = DateFormat('yyyy/MM/dd HH:mm').format(date);
              final points = (index + 1) * 100;

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
                  '${isIncoming ? "+" : "-"}$points ポイント',
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
    );
  }
}
