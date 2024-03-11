import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/views/product/model/products.dart';
import 'package:provider/provider.dart';

import '../../view_product/model/product_info.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
  });

  final ProductInfo product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      radius: 30,
      onTap: () {
        // TODO: Add action
        context.read<ProductsModel>().currentProduct = product;
        Navigator.pushNamed(context, ScreenRoutes.viewProduct);
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
            color: kBorderColor,
            width: 1,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(product.image),
              const SizedBox(height: 10),
              Text(
                product.name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "₹ ${product.price}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    product.weight,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
