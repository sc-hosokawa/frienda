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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:graphql/client.dart';
import 'package:client/data/graphql/schema.graphql.dart';
import 'package:client/data/graphql/query.graphql.dart';
import 'package:client/data/graphql/mutation.graphql.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/fsp_balance_provider.dart';

class Fsp extends ConsumerWidget {
  const Fsp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fspBalance = ref.watch(fspBalanceProvider);

    return RefreshIndicator(
      onRefresh: () async {
        // Refresh both providers
        await Future.wait([
          ref.refresh(transactionsProvider.future),
          ref.refresh(popularPrizesProvider.future),
        ]);
      },
      child: SingleChildScrollView(
        // Add physics to enable refresh on iOS
        physics: const AlwaysScrollableScrollPhysics(),
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
                    children: [
                      fspBalance.when(
                        data: (balance) => Text(
                          '$balance fsp',
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                        loading: () => const CircularProgressIndicator(),
                        error: (err, stack) => Text(
                          '0 fsp',
                          style: Theme.of(context).textTheme.headlineLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Divider(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '期間限定 0 fsp',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.info_outline, size: 16),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('期間限定FSP'),
                                    content: const Text(
                                        '期間限定FSPは、有効期限付きのFSPです。\n特定のキャンペーンやイベントで付与され、期限内に使用する必要があります。'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('閉じる'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'クレデンシャル 未登録',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            IconButton(
                              icon: const Icon(Icons.info_outline, size: 16),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('クレデンシャル'),
                                    content: const Text(
                                        'クレデンシャルは、ブロックチェーン上で管理される貢献証明です。\n特定の条件を満たすことで取得でき、様々な特典を受けることができます。'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('閉じる'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
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
            Consumer(
              builder: (context, ref, child) {
                final prizesAsync = ref.watch(popularPrizesProvider);

                return prizesAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) =>
                      Center(child: Text('エラーが発生しました: $err')),
                  data: (prizes) => prizes.isEmpty
                      ? const SizedBox(
                          height: 80,
                          child: Center(child: Text('No Data')),
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: prizes.length,
                            itemBuilder: (context, index) {
                              final prize = prizes[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    navigateWithFadeTransition(
                                      context,
                                      PrizeDetail(
                                        prizeId: prize.id.toString(),
                                        itemName: prize.name,
                                        itemPrice: '${prize.point} FSP',
                                        itemImage: prize.imgUrl ??
                                            'https://placehold.jp/150x150.png',
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: 150,
                                    child: Card(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Center(
                                              child: Image.network(
                                                prize.imgUrl ??
                                                    'https://placehold.jp/150x150.png',
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  prize.name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                Text(
                                                  '${prize.point} FSP',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
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
                );
              },
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
            Consumer(
              builder: (context, ref, child) {
                final transactionsAsync = ref.watch(transactionsProvider);

                return transactionsAsync.when(
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) =>
                      Center(child: Text('エラーが発生しました: $err')),
                  data: (transactions) => transactions.isEmpty
                      ? const SizedBox(
                          height: 160,
                          child: Center(child: Text('No Data')),
                        )
                      : ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 360),
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              final isIncoming = transaction.direction ==
                                  Enum$TransactionDirection.IN;

                              return ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      isIncoming
                                          ? Icons.arrow_downward
                                          : Icons.arrow_upward,
                                      color: isIncoming
                                          ? Colors.green
                                          : Colors.red,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    CircleAvatar(
                                      backgroundImage:
                                          transaction.counterParty.imageUrl !=
                                                  null
                                              ? NetworkImage(transaction
                                                  .counterParty.imageUrl!)
                                              : null,
                                      child: transaction
                                                  .counterParty.imageUrl ==
                                              null
                                          ? Text(
                                              transaction.counterParty.name[0])
                                          : null,
                                    ),
                                  ],
                                ),
                                title: Text(transaction.counterParty.name),
                                subtitle: Text(DateFormat('yyyy/MM/dd HH:mm')
                                    .format(DateTime.parse(transaction.txAt))),
                                trailing: Text(
                                  '${isIncoming ? "+" : "-"}${transaction.amount} fsp',
                                  style: TextStyle(
                                    color:
                                        isIncoming ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                );
              },
            ),
          ],
        ),
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
              destinationWidget = const Allocation();
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

final transactionsProvider = FutureProvider.autoDispose<
        List<Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList>>(
    (ref) async {
  final user = ref.watch(userProvider);
  if (user == null) return [];

  final result = await ref.read(graphQLClientProvider).query(
        QueryOptions(
          document: gql('''
        query GetFspHistoryByUser(\$userId: String!, \$count: Int!) {
          getFspHistoryByUser(userId: \$userId, count: \$count) {
            transactionList {
              id
              amount
              direction
              counterParty {
                id
                name
                imageUrl
              }
              txAt
            }
          }
        }
      '''),
          variables: {
            'userId': user.id,
            'count': 5,
          },
        ),
      );

  print('Transactions: ${result.data}');

  final transactions = (result.data!['getFspHistoryByUser']['transactionList']
          as List)
      .map((tx) => Query$GetFspHistoryByUser$getFspHistoryByUser$transactionList
          .fromJson(tx as Map<String, dynamic>))
      .toList();
  return transactions;
});

final popularPrizesProvider =
    FutureProvider.autoDispose<List<Query$GetPopularPrizes$getPopularPrizes>>(
        (ref) async {
  final result = await ref.read(graphQLClientProvider).query(
        QueryOptions(
          document: gql('''
        query GetPopularPrizes {
          getPopularPrizes {
            id
            name
            point
            imgUrl
          }
        }
      '''),
        ),
      );

  final prizes = (result.data!['getPopularPrizes'] as List)
      .map((prize) => Query$GetPopularPrizes$getPopularPrizes.fromJson(
          prize as Map<String, dynamic>))
      .toList();
  return prizes;
});
