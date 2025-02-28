import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RequestWidget extends ConsumerWidget {
  const RequestWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Query(
      options: QueryOptions(
        document: gql('''
          query GetPrizesByUser(\$userId: String!) {
            getPrizeByUserId(userId: \$userId) {
              unusedPrizeList {
                id
                name
                point
                description
              }
              requestedPrizeList {
                id
                name
                point
                description
              }
              usedPrizeList {
                id
                name
                point
                description
              }
            }
          }
        '''),
        variables: {
          'userId': user?.id ?? '',
        },
        fetchPolicy: FetchPolicy.networkOnly,
        pollInterval: const Duration(seconds: 1),
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

        final prizeData = result.data!['getPrizeByUserId'];
        final unusedPrizes = _groupPrizes(prizeData['unusedPrizeList'] as List);
        final requestedPrizes =
            _groupPrizes(prizeData['requestedPrizeList'] as List);

        return Scaffold(
          appBar: AppBar(
            title: const Text('交換済み景品'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('交換済み',
                            (prizeData['unusedPrizeList'] as List).length),
                        _buildStatItem('申請中',
                            (prizeData['requestedPrizeList'] as List).length),
                        _buildStatItem('使用済み',
                            (prizeData['usedPrizeList'] as List).length),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (unusedPrizes.isNotEmpty) ...[
                          const Text(
                            '利用可能なプライズ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: unusedPrizes.length,
                            itemBuilder: (context, index) {
                              final prizeGroup = unusedPrizes[index];
                              return Card(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              prizeGroup.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              prizeGroup.description ?? '',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              foregroundColor: Colors.black,
                                            ),
                                            onPressed: () => _requestPrize(
                                              context,
                                              prizeGroup.id,
                                              prizeGroup.name,
                                              user?.id ?? '',
                                              refetch,
                                            ),
                                            child: const Text('利用申請'),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '所持数: ${prizeGroup.count}個',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ] else
                          const Center(
                            child: Text('利用可能なプライズがありません'),
                          ),
                        const SizedBox(height: 16),
                        if (requestedPrizes.isNotEmpty) ...[
                          const Text(
                            'リクエスト中のプライズ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: requestedPrizes.length,
                            itemBuilder: (context, index) {
                              final prizeGroup = requestedPrizes[index];
                              return Card(
                                color: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              prizeGroup.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              prizeGroup.description ?? '',
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            '申請中',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          IconButton(
                                            icon: const Icon(Icons.qr_code,
                                                color: Colors.white),
                                            onPressed: () => _showQRCode(
                                              context,
                                              prizeGroup.id,
                                              user?.id ?? '',
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '所持数: ${prizeGroup.count}個',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, int count) {
    return Column(
      children: [
        Text(
          count.toString(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }

  List<PrizeGroup> _groupPrizes(List prizes) {
    final Map<String, PrizeGroup> groupedPrizes = {};

    for (final prize in prizes) {
      final key = '${prize['id']}-${prize['name']}';
      if (groupedPrizes.containsKey(key)) {
        groupedPrizes[key]!.count++;
      } else {
        groupedPrizes[key] = PrizeGroup(
          id: prize['id'],
          name: prize['name'],
          description: prize['description'],
          point: prize['point'],
          count: 1,
        );
      }
    }

    return groupedPrizes.values.toList();
  }

  Future<void> _requestPrize(
    BuildContext context,
    int prizeId,
    String prizeName,
    String userId,
    VoidCallback? refetch,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('確認'),
          content: Text('$prizeNameの利用を申請しますか？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('申請する'),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    try {
      final client = GraphQLProvider.of(context).value;
      final result = await client.mutate(
        MutationOptions(
          document: gql('''
            mutation RequestPrize(\$input: RequestPrizeInput!) {
              requestPrize(input: \$input) {
                id
              }
            }
          '''),
          variables: {
            'input': {
              'userId': userId,
              'prizeId': prizeId,
            },
          },
        ),
      );

      print(result);

      if (result.hasException) {
        throw result.exception!;
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('利用申請を送信しました')),
      );

      refetch?.call();
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('利用申請に失敗しました')),
      );
    }
  }

  void _showQRCode(BuildContext context, int prizeId, String userId) {
    final qrData = '$userId|$prizeId';
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.grey[900],
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'QRコード',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'このQRコードを管理者に見せてください',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 184.0,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    '閉じる',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class PrizeGroup {
  final int id;
  final String name;
  final String? description;
  final int point;
  int count;

  PrizeGroup({
    required this.id,
    required this.name,
    this.description,
    required this.point,
    this.count = 1,
  });
}
