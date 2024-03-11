import 'package:flutter/material.dart';
import 'package:frozit/views/home/model/product_category.dart';
import 'package:frozit/views/home/widgets/category_card.dart';
import 'package:frozit/views/home/widgets/home_appbar.dart';
import 'package:frozit/views/home/widgets/offer_card.dart';
import 'package:frozit/views/product/model/products.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductsModel>().getCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FrozitHomeToolBar(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const OfferCard(),
                    const SizedBox(height: 20),
                    const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Selector<ProductsModel, List<ProductCategory>>(
                      selector: (context, productModel) =>
                          productModel.categories,
                      builder: (context, categories, child) {
                        return GridView.count(
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisCount: 2,
                          crossAxisSpacing: 20,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 20,
                          shrinkWrap: true,
                          children: categories
                              .map(
                                (category) => CategoryCard(
                                  category: category,
                                ),
                              )
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
