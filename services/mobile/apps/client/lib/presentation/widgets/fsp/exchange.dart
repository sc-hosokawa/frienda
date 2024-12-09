import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:client/presentation/widgets/fsp/prize_detail.dart';

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
              title: const Text('交換'),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              centerTitle: true,
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
                              prizeId: prize['id'],
                              itemName: prize['name'],
                              itemPrice: '${prize['point']} FSP',
                              itemImage: prize['imgUrl'] ??
                                  'https://placehold.jp/150x150.png',
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Image.network(
                                prize['imgUrl'] ??
                                    'https://placehold.jp/150x150.png',
                                fit: BoxFit.cover,
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
                                  ),
                                  Text(
                                    '${prize['point']} FSP',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
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
