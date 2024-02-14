import 'package:flutter/material.dart';
import 'package:frozit/views/home/home_appbar.dart';
import 'package:frozit/views/home/offer_card.dart';
import 'package:frozit/views/home/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const FrozitHomeToolBar(),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 50,
            ),
            child: Column(
              children: [
                const OfferCard(),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 20,
                  childAspectRatio: 0.7,
                  mainAxisSpacing: 20,
                  shrinkWrap: true,
                  children: const [
                    ProductCard(image: 'assets/images/OATS.png'),
                    ProductCard(image: 'assets/images/Cookies.png'),
                    ProductCard(image: 'assets/images/Ragi Flour.png'),
                    ProductCard(image: 'assets/images/Sagoo.png'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
