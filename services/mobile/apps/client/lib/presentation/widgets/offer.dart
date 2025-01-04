import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/offer/offer_detail.dart';
import 'package:client/routing/navigation.dart';
import 'package:client/presentation/widgets/offer/add_new_offer.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:client/presentation/providers/user_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client/presentation/widgets/offer/available_offers.dart';

class Offer extends ConsumerStatefulWidget {
  const Offer({super.key});

  @override
  ConsumerState<Offer> createState() => _OfferState();
}

class _OfferState extends ConsumerState<Offer> {
  bool _isTransitioning = false;

  void _navigateToOfferDetail(
      BuildContext context, int offerId, Function? refetch) async {
    setState(() {
      _isTransitioning = true;
    });

    await navigateWithFadeTransition(
      context,
      OfferDetailPage(offerId: offerId),
    );

    if (refetch != null) {
      await refetch();
    }

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

            final offersByStatus = result.data?['getOffersByStatus'];
            final inprogressOffers =
                offersByStatus?['inprogressOffers'] as List<dynamic>? ?? [];
            final appliedOffers =
                offersByStatus?['appliedOffers'] as List<dynamic>? ?? [];

            return RefreshIndicator(
              onRefresh: () async {
                await refetch!();
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: _buildOverviewCard()),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AvailableOffers(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 48),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('もっと見る'),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: _buildSectionTitle('自分のOffer'),
                  ),
                  SliverToBoxAdapter(child: _buildOwnedOfferCarousel()),
                  SliverToBoxAdapter(child: _buildSectionTitle('進行中')),
                  SliverToBoxAdapter(
                    child: _buildOfferCarousel(
                      context: context,
                      offers: inprogressOffers,
                      height: 180,
                      refetch: refetch,
                    ),
                  ),
                  SliverToBoxAdapter(child: _buildSectionTitle('応募中')),
                  SliverToBoxAdapter(
                    child: _buildOfferCarousel(
                      context: context,
                      offers: appliedOffers,
                      height: 180,
                      refetch: refetch,
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
            color: const Color(0x10101010),
            elevation: 4,
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
    SvgPicture getIconForLabel() {
      switch (label) {
        case 'Total':
          return SvgPicture.asset(
            'assets/total.svg',
            width: 20,
            height: 20,
          );
        case 'Current':
          return SvgPicture.asset(
            'assets/current.svg',
            width: 20,
            height: 20,
          );
        case 'Applying':
          return SvgPicture.asset(
            'assets/apply.svg',
            width: 20,
            height: 20,
          );
        case 'Completed':
          return SvgPicture.asset(
            'assets/complete.svg',
            width: 20,
            height: 20,
          );
        default:
          return SvgPicture.asset(
            'assets/complete.svg',
            width: 20,
            height: 20,
          );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 40,
          height: 40,
          child: getIconForLabel(),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
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
        SizedBox(
          width: 40,
          height: 40,
          child: SvgPicture.asset('assets/total_point_earn.svg'),
        ),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Total Point Earned',
              style: TextStyle(color: Colors.white, fontSize: 12),
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
      padding: const EdgeInsets.only(
          left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: offers.length,
            itemBuilder: (context, index) {
              final offer = offers[index];
              return Container(
                width: 150,
                margin: const EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () =>
                      _navigateToOfferDetail(context, offer['id'], refetch),
                  child: Card(
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    ),
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
                          SizedBox(
                            height: 40,
                            child: Text(
                              offer['title'],
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${offer['fee']} FSP',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
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

  Widget _buildOfferCarousel({
    required BuildContext context,
    required List<dynamic> offers,
    required double height,
    required Function? refetch,
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
              onTap: () =>
                  _navigateToOfferDetail(context, offer['id'], refetch),
              child: Card(
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
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
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Text(
                        '${offer['fee']} FSP',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
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
}
