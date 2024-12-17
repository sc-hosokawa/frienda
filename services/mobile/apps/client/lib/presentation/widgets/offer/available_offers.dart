import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client/presentation/widgets/offer/offer_detail.dart';
import 'package:intl/intl.dart';

class AvailableOffers extends StatelessWidget {
  const AvailableOffers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('利用可能なオファー'),
        titleTextStyle: Theme.of(context).textTheme.titleMedium,
        centerTitle: true,
      ),
      body: Query(
        options: QueryOptions(
          document: gql('''
            query GetOffers {
              getOffers {
                offerList {
                  id
                  title
                  imageUrl
                  description
                  fee
                  category
                }
              }
            }
          '''),
          fetchPolicy: FetchPolicy.cacheAndNetwork,
        ),
        builder: (QueryResult result, {fetchMore, refetch}) {
          if (result.hasException) {
            return Center(
                child: Text('エラーが発生しました: ${result.exception.toString()}'));
          }

          if (result.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final offers =
              result.data?['getOffers']['offerList'] as List<dynamic>? ?? [];

          if (offers.isEmpty) {
            return const Center(
              child: Text(
                '利用可能なOfferはありません',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(4),
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Card(
                color: Colors.black,
                margin: const EdgeInsets.only(bottom: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: offer['imageUrl'] != null
                        ? Image.network(
                            offer['imageUrl'],
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          )
                        : SvgPicture.asset(
                            'assets/offer.svg',
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                  ),
                  title: Text(offer['title']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        offer['description'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Fee: ${NumberFormat('#,###').format(offer['fee'])} FSP',
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        side: const BorderSide(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OfferDetailPage(
                              offerId: offer['id'],
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        '詳細',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  isThreeLine: true,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
