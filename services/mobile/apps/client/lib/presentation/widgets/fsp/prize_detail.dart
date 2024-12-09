import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/client_provider.dart';

class PrizeDetail extends ConsumerWidget {
  final String itemName;
  final String itemPrice;
  final String itemImage;
  final String prizeId;

  const PrizeDetail({
    super.key,
    required this.itemName,
    required this.itemPrice,
    required this.itemImage,
    required this.prizeId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SafeArea(
          child: AppBar(
            title: Text(itemName),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  image: itemImage.startsWith('asset:')
                      ? AssetImage(itemImage.substring(6))
                      : NetworkImage(itemImage) as ImageProvider,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            itemName,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          ElevatedButton(
                            onPressed: () => _exchangePrize(context, ref),
                            child: const Text('交換する'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        itemPrice,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'アイテムの詳細がここに入ります。実際のアプリケーションでは、このテキストをサーバーから取得するか、アイテムごとに適切な説明を用意する必要があります。',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _exchangePrize(BuildContext context, WidgetRef ref) async {
    try {
      final client = ref.read(graphQLClientProvider);
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
              'prizeId': prizeId,
            },
          },
        ),
      );

      if (result.hasException) {
        throw result.exception!;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$itemNameを交換しました')),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('交換に失敗しました')),
      );
    }
  }
}
