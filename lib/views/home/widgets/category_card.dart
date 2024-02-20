import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/views/home/model/product_category.dart';
import 'package:provider/provider.dart';

import '../../product/model/products.dart';
import '../../router/model/navigation_provider.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });

  final ProductCategory category;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<ProductsModel>().currentCategory = category;
        context.read<NavigationProvider>().currentIndex = 1;
      },
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: kContainerColorLight,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: kPrimaryColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Image.asset(category.image),
              const SizedBox(height: 10),
              Text(
                category.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
