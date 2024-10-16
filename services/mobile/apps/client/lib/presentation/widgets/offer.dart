import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/offer_detail.dart';

class Offer extends StatelessWidget {
  const Offer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Offer Page'),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OfferDetailPage()),
              );
            },
            child: Text('Go to Offer Detail'),
          ),
        ],
      ),
    );
  }
}
