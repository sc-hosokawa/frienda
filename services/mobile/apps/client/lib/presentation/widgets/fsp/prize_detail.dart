import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:intl/intl.dart';

class PrizeDetail extends ConsumerWidget {
  final String prizeId;

  const PrizeDetail({
    super.key,
    required this.prizeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Query(
      options: QueryOptions(
        document: gql('''
          query GetPrizeDetail(\$prizeId: Int!) {
            getPrizeDetail(prizeId: \$prizeId) {
              id
              imgUrl
              name
              point
              description
              representation
              condition
            }
          }
        '''),
        variables: {
          'prizeId': int.parse(prizeId),
        },
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Scaffold(
            body: Center(
                child: Text('エラーが発生しました: ${result.exception.toString()}')),
          );
        }

        if (result.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final prizeDetail = result.data!['getPrizeDetail'];
        final imageUrl = prizeDetail['imageUrl'] as String?;

        return Scaffold(
          body: Column(
            children: [
              SafeArea(
                child: AppBar(
                  title: Text(prizeDetail['name'] ?? ''),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image(
                            image: imageUrl.startsWith('asset:')
                                ? AssetImage(imageUrl.substring(6))
                                : NetworkImage(imageUrl) as ImageProvider,
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            'assets/logo_visualonly.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              prizeDetail['name'],
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${NumberFormat('#,###').format(prizeDetail['point'])} fsp',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: Colors.black,
                                  ),
                                  onPressed: () => _exchangePrize(
                                      context, ref, prizeDetail['name']),
                                  child: const Text('交換する'),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            Card(
                              margin: EdgeInsets.zero,
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '説明',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      prizeDetail['description'] ?? '説明がありません',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 16),
                                    const Text(
                                      '条件',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      prizeDetail['condition'] ?? '',
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
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
          ),
        );
      },
    );
  }

  Future<void> _exchangePrize(
      BuildContext context, WidgetRef ref, String itemName) async {
    try {
      final client = ref.read(graphQLClientProvider);
      final user = ref.read(userProvider);
      final result = await client.mutate(
        MutationOptions(
          document: gql('''
            mutation ExchangePrize(\$input: ExchangePrizeInput!) {
              exchangePrize(input: \$input) {
                id
                txId
              }
            }
          '''),
          variables: {
            'input': {
              'userId': user?.id ?? '',
              'prizeId': int.parse(prizeId),
              'amount': 1,
            },
          },
        ),
      );

      print(result.data);

      if (result.hasException) {
        throw result.exception!;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$itemNameを交換しました。確認メールをご確認ください。')),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('交換に失敗しました')),
      );
    }
  }
}
