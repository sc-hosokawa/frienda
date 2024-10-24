import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/offer/offer_detail.dart';
import 'package:client/routing/navigation.dart';
import 'package:client/presentation/widgets/offer/add_new_offer.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  _OfferState createState() => _OfferState();
}

class _OfferState extends State<Offer> {
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
    return Scaffold(
      body: AnimatedOpacity(
        opacity: _isTransitioning ? 0.0 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: _buildOverviewCard()),
            SliverToBoxAdapter(child: _buildSectionTitle('自分のOffer')),
            SliverToBoxAdapter(child: _buildOwnedOfferCarousel()),
            SliverToBoxAdapter(child: _buildSectionTitle('進行中')),
            SliverToBoxAdapter(child: _buildOngoingOfferCarousel()),
            SliverToBoxAdapter(child: _buildSectionTitle('応募できるOffer')),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildOfferListTile(context, index),
                childCount: offers.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddNewOffer(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildOverviewCard() {
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
                  Expanded(child: _buildOverviewItem('Total', 4, Colors.blue)),
                  Expanded(
                    child: Row(
                      children: [
                        _buildOverviewItem('Current', 2, Colors.purple),
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
                      child: _buildOverviewItem('Applying', 1, Colors.green)),
                  Expanded(
                    child: Row(
                      children: [
                        _buildOverviewItem('Completed', 1, Colors.red),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildTotalPointEarned(),
            ],
          ),
        ),
      ),
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

  Widget _buildTotalPointEarned() {
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
          children: const [
            Text(
              'Total Point Earned',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            Text(
              '612,345',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold),
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
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: ownedOffers.length,
        itemBuilder: (context, index) =>
            _buildOfferCard(context, index, isOwned: true),
      ),
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
}
