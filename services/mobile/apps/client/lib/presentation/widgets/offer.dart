import 'package:flutter/material.dart';
import 'package:client/presentation/widgets/offer_detail.dart';

class Offer extends StatelessWidget {
  const Offer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> offers = [
      'Offer 1',
      'Offer 2',
      'Offer 3',
      'Offer 4',
      'Offer 5'
    ];

    return Column(
      children: [
        SizedBox(
          height: 150, // 正方形の高さを設定
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 150, // 正方形の幅を設定
                margin: EdgeInsets.all(8),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OfferDetailPage()),
                    );
                  },
                  child: Card(
                    child: Center(
                      child:
                          Text(offers[index], style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: offers.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(offers[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OfferDetailPage()),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
