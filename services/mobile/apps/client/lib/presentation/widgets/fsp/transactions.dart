import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';

class Transactions extends ConsumerWidget {
  const Transactions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider)?.id ?? '';

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: AppBar(
              title: const Text('取引履歴'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
            ),
          ),
          Expanded(
            child: Query(
              options: QueryOptions(
                document: gql('''
                  query GetFspHistory(\$userId: String!, \$count: Int!) {
                    getFspHistoryByUser(userId: \$userId, count: \$count) {
                      transactionList {
                        id
                        amount
                        direction
                        counterParty {
                          name
                        }
                        txAt
                        note
                      }
                    }
                  }
                '''),
                variables: {
                  'userId': userId,
                  'count': 100,
                },
              ),
              builder: (result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Center(child: Text('エラーが発生しました'));
                }

                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final transactions = result.data?['getFspHistoryByUser']
                    ['transactionList'] as List<dynamic>?;

                if (transactions == null || transactions.isEmpty) {
                  return const Center(child: Text('取引履歴がありません'));
                }

                return ListView.builder(
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = transactions[index];
                    final isIncoming = transaction['direction'] == 'IN';
                    final date = DateTime.parse(transaction['txAt']);
                    final formattedDate =
                        DateFormat('yyyy/MM/dd HH:mm').format(date);

                    return ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isIncoming
                                ? Icons.arrow_downward
                                : Icons.arrow_upward,
                            color: isIncoming ? Colors.green : Colors.red,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const CircleAvatar(
                            child: Icon(Icons.person),
                          ),
                        ],
                      ),
                      title: Text(transaction['note']),
                      subtitle: Text(
                          '${transaction['counterParty']['name']} at $formattedDate',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Colors.grey,
                                  )),
                      trailing: Text(
                        '${isIncoming ? "+" : "-"}${transaction['amount']} FSP',
                        style: TextStyle(
                          color: isIncoming ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
