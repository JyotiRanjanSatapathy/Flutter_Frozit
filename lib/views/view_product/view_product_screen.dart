import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/views/cart/model/cart_model.dart';
import 'package:provider/provider.dart';

import '../product/model/products.dart';
import 'model/product_info.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProductInfo product = context.read<ProductsModel>().currentProduct!;
    return Scaffold(
      backgroundColor: kContainerColorLight,
      appBar: AppBar(
        backgroundColor: kContainerColorLight,
        surfaceTintColor: kContainerColorLight,
        elevation: 0,
      ),
      body: Stack(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              return SizedBox(
                height: constraints.maxHeight * .4,
                child: Center(
                  child: Image.asset(
                    product.image,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
          ProductDetailsSheet(product: product),
          CartButtons(product: product),
        ],
      ),
    );
  }
}

class CartButtons extends StatefulWidget {
  const CartButtons({
    super.key,
    required this.product,
  });

  final ProductInfo product;

  @override
  State<CartButtons> createState() => _CartButtonsState();
}

class _CartButtonsState extends State<CartButtons> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Row(
        children: [
          CartDesign(
            onTap: () {
              context.read<CartProvider>().addToCart(widget.product);
              Navigator.pushNamed(context, ScreenRoutes.cart);
            },
            leftSide: true,
          ),
          CartDesign(
            onTap: () {
              if (isAdded) {
                Navigator.pushNamed(context, ScreenRoutes.cart);
              } else {
                context.read<CartProvider>().addToCart(widget.product);
                setState(() {
                  isAdded = true;
                });
              }
            },
            rightSide: true,
            isAdded: isAdded,
          ),
        ],
      ),
    );
  }
}

class CartDesign extends StatelessWidget {
  const CartDesign({
    super.key,
    required this.onTap,
    this.leftSide = false,
    this.rightSide = false,
    this.isAdded = false,
  });

  final VoidCallback onTap;
  final bool leftSide;
  final bool rightSide;
  final bool isAdded;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: (MediaQuery.of(context).size.width) / 2,
        decoration: BoxDecoration(
          color: leftSide ? kContainerColor : kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: leftSide ? Radius.circular(30) : Radius.zero,
            topRight: rightSide ? Radius.circular(30) : Radius.zero,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            leftSide
                ? Icon(
                    Icons.shopping_bag,
                    color: kPrimaryColor,
                  )
                : Icon(
                    isAdded ? Icons.check : Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
            const SizedBox(width: 10),
            Text(
              leftSide
                  ? "Buy Now"
                  : isAdded
                      ? "Go to Cart"
                      : "Add to Cart",
              style: TextStyle(
                color: leftSide ? kPrimaryColor : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsSheet extends StatelessWidget {
  const ProductDetailsSheet({
    super.key,
    required this.product,
  });

  final ProductInfo product;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 4,
                blurRadius: 15,
              ),
            ],
          ),
          child: ProductDetails(
            product: product,
            scrollController: scrollController,
          ),
        );
      },
    );
  }
}

class ProductDetails extends StatelessWidget {
  const ProductDetails({
    super.key,
    required this.product,
    required this.scrollController,
  });

  final ProductInfo product;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductInfo(),
            const SizedBox(height: 40),
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(product.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  Column buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: "₹",
                    style: TextStyle(
                      fontSize: 24,
                      color: kPrimaryColor,
                    ),
                  ),
                  TextSpan(
                    text: " ${product.price}",
                    style: const TextStyle(
                      fontSize: 30,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              product.weight,
              style: const TextStyle(
                fontSize: 16,
                // color: kTextColorLight,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
