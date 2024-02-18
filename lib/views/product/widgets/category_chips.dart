import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../home/model/product_category.dart';
import '../model/products.dart';

class CategoryChips extends StatelessWidget {
  const CategoryChips({super.key});

  @override
  Widget build(BuildContext context) {
    List<ProductCategory> categories = context.read<ProductsModel>().categories;
    categories = [ProductCategory(name: "All", image: "")] + categories;
    return Row(
      children: categories
          .map(
            (category) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Selector<ProductsModel, String>(
                selector: (context, productModel) =>
                    productModel.currentCategory.name,
                builder: (context, selectedCategory, child) {
                  return ActionChip(
                    label: Text(
                      category.name,
                      style: TextStyle(
                        color: category.name == selectedCategory
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    backgroundColor: category.name == selectedCategory
                        ? kPrimaryColor
                        : kContainerColorLight,
                    onPressed: () {
                      context.read<ProductsModel>().currentCategory = category;
                    },
                  );
                },
              ),
            ),
          )
          .toList(),
    );
  }
}
