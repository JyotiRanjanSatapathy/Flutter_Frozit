import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../model/cart_model.dart';

class ChangeCountButtons extends StatelessWidget {
  const ChangeCountButtons({
    super.key,
    required this.cartProduct,
  });

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CountIconButton(
              icon: Icons.remove,
              onTapped: () {
                context
                    .read<CartProvider>()
                    .reduceFromCart(cartProduct.product);
              },
            ),
            const SizedBox(width: 15),
            Text(
              cartProduct.quantity.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 15),
            CountIconButton(
              icon: Icons.add,
              onTapped: () {
                context.read<CartProvider>().addToCart(cartProduct.product);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class CountIconButton extends StatelessWidget {
  const CountIconButton({
    super.key,
    required this.onTapped,
    required this.icon,
  });

  final void Function() onTapped;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapped,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
