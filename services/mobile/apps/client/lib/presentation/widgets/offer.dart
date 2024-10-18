import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/offer/offer_detail.dart';
import 'package:client/routing/navigation.dart';

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

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isTransitioning ? 0.0 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Column(
        children: [
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) => _buildOfferCard(context, index),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: offers.length,
              itemBuilder: (context, index) =>
                  _buildOfferListTile(context, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOfferCard(BuildContext context, int index) {
    return Container(
      width: 150,
      margin: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => _navigateToOfferDetail(context),
        child: Card(
          child: Center(
            child: Text(offers[index], style: const TextStyle(fontSize: 18)),
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
