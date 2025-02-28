import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/widgets/fsp/prize_detail.dart';
import 'package:intl/intl.dart';
import 'package:client/presentation/widgets/fsp/prizeRequest.dart';

class Exchange extends StatelessWidget {
  const Exchange({super.key});

  static const String getAllPrizesQuery = '''
    query GetAllPrizes {
      getAllPrizes {
        id
        name
        point
        imgUrl
      }
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: AppBar(
              title: const Text('景品'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.info_outline),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RequestWidget(),
                      ),
                    );
                  },
                  tooltip: '詳細',
                ),
              ],
            ),
          ),
          Expanded(
            child: Query(
              options: QueryOptions(
                document: gql(getAllPrizesQuery),
              ),
              builder: (QueryResult result, {fetchMore, refetch}) {
                if (result.hasException) {
                  return Center(
                      child:
                          Text('エラーが発生しました: ${result.exception.toString()}'));
                }

                if (result.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final prizes = result.data?['getAllPrizes'] as List<dynamic>?;

                if (prizes == null || prizes.isEmpty) {
                  return const Center(child: Text('交換可能なアイテムがありません'));
                }

                prizes.sort(
                    (a, b) => (a['point'] as int).compareTo(b['point'] as int));

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: prizes.length,
                  itemBuilder: (context, index) {
                    final prize = prizes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrizeDetail(
                              prizeId: prize['id'].toString(),
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: prize['imgUrl'] != null
                                      ? Image.network(
                                          prize['imgUrl'],
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        )
                                      : Image.asset(
                                          'assets/logo_visualonly.jpg',
                                          fit: BoxFit.cover,
                                          width: double.infinity,
                                        ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prize['name'],
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    '${NumberFormat('#,###').format(prize['point'])} FSP',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
