import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/views/cart/model/cart_model.dart';
import 'package:frozit/views/cart/widgets/change_count_component.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartProduct,
  });

  final CartProduct cartProduct;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: kContainerColorLight,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 0,
            ),
          ],
          border: Border.all(
            color: kBorderColor,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(cartProduct.product.image),
                  const SizedBox(width: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          cartProduct.product.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '₹ ${cartProduct.product.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ChangeCountButtons(cartProduct: cartProduct),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: kBorderColor,
              thickness: 1,
            ),
            InkWell(
              onTap: () {
                context
                    .read<CartProvider>()
                    .removeFromCart(cartProduct.product);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.delete,
                    color: kPrimaryColor,
                  ),
                  Text(
                    'Remove',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
