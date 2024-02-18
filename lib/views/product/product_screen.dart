import 'package:flutter/material.dart';
import 'package:frozit/views/product/widgets/product_details.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import 'model/products.dart';
import 'widgets/category_chips.dart';
import 'widgets/product_topbar.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<ProductsModel>().getProducts());
    // context.read<ProductsModel>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTopBar(),
                  SizedBox(height: 20),
                  CategoryChips(),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              child: Consumer<ProductsModel>(
                builder: (context, products, child) => products.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: kPrimaryColor,
                        ),
                      )
                    : GridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: .7,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 10),
                        children: products.products
                            .map(
                              (product) => ProductDetails(product: product),
                            )
                            .toList(),
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
