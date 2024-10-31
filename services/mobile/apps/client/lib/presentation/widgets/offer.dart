import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/offer/offer_detail.dart';
import 'package:client/routing/navigation.dart';
import 'package:client/presentation/widgets/offer/add_new_offer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';

class Offer extends ConsumerStatefulWidget {
  const Offer({super.key});

  @override
  ConsumerState<Offer> createState() => _OfferState();
}

class _OfferState extends ConsumerState<Offer> {
  bool _isTransitioning = false;
  final List<String> offers = const [
    'Offer 1',
    'Offer 2',
    'Offer 3',
    'Offer 4',
    'Offer 5'
  ];
  final List<String> ownedOffers = const [
    'My Offer 1',
    'My Offer 2',
    'My Offer 3',
  ];

  void _navigateToOfferDetail(BuildContext context) async {
    setState(() {
      _isTransitioning = true;
    });

    await navigateWithFadeTransition(
      context,
      OfferDetailPage(),
    );

    if (mounted) {
      setState(() {
        _isTransitioning = false;
      });
    }
  }

  void _navigateToAddNewOffer(BuildContext context) async {
    setState(() {
      _isTransitioning = true;
    });

    await navigateWithFadeTransition(
      context,
      const AddNewOffer(),
    );

    if (mounted) {
      setState(() {
        _isTransitioning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final userId = ref.watch(userProvider)?.id ?? '';

    return Scaffold(
      body: AnimatedOpacity(
        opacity: _isTransitioning ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: Query(
          options: QueryOptions(
            document: gql('''
              query GetOffersData(\$userId: String!) {
                getOffersByStatus(userId: \$userId) {
                  inprogressOffers {
                    id
                    title
                    description
                    imageUrl
                    fee
                    category
                  }
                  appliedOffers {
                    id
                    title
                    description
                    imageUrl
                    fee
                    category
                  }
                }
              }
            '''),
            variables: {
              'userId': userId,
            },
            errorPolicy: ErrorPolicy.all,
            fetchPolicy: FetchPolicy.networkOnly,
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.hasException) {
              print('GraphQL Error: ${result.exception.toString()}');
              return Center(
                  child: Text('Error: ${result.exception.toString()}'));
            }
            if (result.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            final data = result.data?['getOffersByStatus'];
            final inprogressOffers =
                data?['inprogressOffers'] as List<dynamic>? ?? [];
            final appliedOffers =
                data?['appliedOffers'] as List<dynamic>? ?? [];
            final availableOffers =
                result.data?['getAllOffers'] as List<dynamic>? ?? [];

            return RefreshIndicator(
              onRefresh: () async {
                await refetch!();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildOverviewCard()),
                  SliverToBoxAdapter(child: _buildSectionTitle('自分のOffer')),
                  SliverToBoxAdapter(child: _buildOwnedOfferCarousel()),
                  SliverToBoxAdapter(child: _buildSectionTitle('進行中')),
                  SliverToBoxAdapter(
                    child: _buildOfferCarousel(
                      context: context,
                      offers: inprogressOffers,
                      height: 150,
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildSectionTitle('応募中')),
                  SliverToBoxAdapter(
                    child: _buildOfferCarousel(
                      context: context,
                      offers: appliedOffers,
                      height: 150,
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildSectionTitle('応募できるOffer')),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildAvailableOfferTile(
                          context, availableOffers[index]),
                      childCount: availableOffers.length,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNewOffer(context),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewCard() {
    final userId = ref.watch(userProvider)?.id ?? '';

    return Query(
      options: QueryOptions(
        document: gql('''
          query GetOfferStats(\$userId: String!) {
            getOfferStatsByUser(userId: \$userId) {
              totalOffers
              ongoingOffers
              appliedOffers
              completedOffers
              totalEarnings
            }
          }
        '''),
        variables: {
          'userId': userId,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Text('Error: ${result.exception.toString()}');
        }
        if (result.isLoading) {
          return CircularProgressIndicator();
        }
        if (result.data == null) {
          return Text('No data available');
        }

        final data = result.data!['getOfferStatsByUser'];
        final totalOffers = data['totalOffers'];
        final ongoingOffers = data['ongoingOffers'];
        final appliedOffers = data['appliedOffers'];
        final completedOffers = data['completedOffers'];
        final totalEarnings = data['totalEarnings'];

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: _buildOverviewItem(
                              'Total', totalOffers, Colors.blue)),
                      Expanded(
                        child: Row(
                          children: [
                            _buildOverviewItem(
                                'Current', ongoingOffers, Colors.purple),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                          child: _buildOverviewItem(
                              'Applying', appliedOffers, Colors.green)),
                      Expanded(
                        child: Row(
                          children: [
                            _buildOverviewItem(
                                'Completed', completedOffers, Colors.red),
                            Spacer(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTotalPointEarned(totalEarnings),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOverviewItem(String label, int value, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              value.toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTotalPointEarned(dynamic totalEarnings) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Point Earned',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              totalEarnings.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 16.0, bottom: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildOwnedOfferCarousel() {
    final userId = ref.watch(userProvider)?.id ?? '';

    return Query(
      options: QueryOptions(
        document: gql('''
          query GetOffersByOwner(\$userId: String!) {
            getOffersByOwner(userId: \$userId) {
              offerList {
                id
                title
                description
                imageUrl
                fee
                category
              }
            }
          }
        '''),
        variables: {
          'userId': userId,
        },
      ),
      builder: (result, {fetchMore, refetch}) {
        if (result.hasException) {
          return Center(child: Text('Error: ${result.exception.toString()}'));
        }
        if (result.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final offers =
            result.data?['getOffersByOwner']['offerList'] as List<dynamic>? ??
                [];

        if (offers.isEmpty) {
          return SizedBox(
            height: 150,
            child: const Center(
              child: Text(
                'No owned offers',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }

        return SizedBox(
          height: 150,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Container(
                width: 150,
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () => _navigateToOfferDetail(context),
                  child: Card(
                    color: Colors.blue[100],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (offer['imageUrl'] != null)
                            Image.network(
                              offer['imageUrl'],
                              height: 60,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          const SizedBox(height: 8),
                          Text(
                            offer['title'],
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue[800],
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Spacer(),
                          Text(
                            '${offer['fee']} FSP',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue[800],
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
        );
      },
    );
  }

  Widget _buildOngoingOfferCarousel() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        itemBuilder: (context, index) => _buildOfferCard(context, index),
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, int index,
      {bool isOwned = false}) {
    final offerList = isOwned ? ownedOffers : offers;
    final cardColor = isOwned ? Colors.blue[100] : Colors.white;
    final textColor = isOwned ? Colors.blue[800] : Colors.black;

    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => _navigateToOfferDetail(context),
        child: Card(
          color: cardColor,
          child: Center(
            child: Text(
              offerList[index],
              style: TextStyle(fontSize: 18, color: textColor),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOfferListTile(BuildContext context, int index) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _navigateToOfferDetail(context),
      child: ListTile(
        title: Text(offers[index]),
      ),
    );
  }

  Widget _buildOfferCarousel({
    required BuildContext context,
    required List<dynamic> offers,
    required double height,
  }) {
    if (offers.isEmpty) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text(
            'No offers',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Container(
            width: 150,
            margin: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => _navigateToOfferDetail(context),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (offer['imageUrl'] != null)
                        Image.network(
                          offer['imageUrl'],
                          height: 60,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      const SizedBox(height: 8),
                      Text(
                        offer['title'],
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        '${offer['fee']} FSP',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
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
    );
  }

  Widget _buildAvailableOfferTile(
      BuildContext context, Map<String, dynamic> offer) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () => _navigateToOfferDetail(context),
      child: ListTile(
        leading: offer['imageUrl'] != null
            ? Image.network(
                offer['imageUrl'],
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
            : null,
        title: Text(offer['title']),
        subtitle: Text(offer['description'] ?? ''),
        trailing: Text('${offer['fee']} FSP'),
      ),
    );
  }
}
