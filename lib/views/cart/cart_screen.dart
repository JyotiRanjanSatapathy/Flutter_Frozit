import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/views/cart/widgets/cart_item.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:provider/provider.dart';

import 'model/cart_model.dart';
import 'widgets/checkout_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Cart'),
      body: Consumer<CartProvider>(
        builder: (context, cart, child) {
          if (cart.getCartItems().isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                children: [
                  SvgPicture.asset(
                    'assets/images/undraw_empty_cart_co35.svg',
                    height: 200,
                  ),
                  const SizedBox(height: 60),
                  const Center(
                    child: Text(
                      'Your cart is empty!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        ...cart
                            .getCartItems()
                            .map(
                              (cartProduct) =>
                                  CartItem(cartProduct: cartProduct),
                            )
                            .toList(),
                        const SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 50, left: 20, right: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Price details (${cart.getCartItemsCount()} items)',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                ),
                              ),
                              const SizedBox(height: 20),
                              buildPriceBreakdown(
                                'Price',
                                '₹ ${cart.getCartTotalPriceWithoutGST()}',
                              ),
                              buildPriceBreakdown(
                                'GST',
                                '₹ ${cart.getGSTAmount()}',
                              ),
                              Divider(
                                color: kSecondaryColor.withOpacity(0.3),
                                thickness: 1,
                              ),
                              buildPriceBreakdown(
                                'Total MRP',
                                '₹ ${cart.getCartTotalPrice()}',
                                isBold: true,
                              ),
                              Divider(
                                color: kSecondaryColor.withOpacity(0.3),
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const CheckoutButton(),
            ],
          );
        },
      ),
    );
  }

  Row buildPriceBreakdown(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? Colors.black : kSecondaryColor,
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isBold ? 18 : 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.w500,
            color: isBold ? Colors.black : kSecondaryColor,
          ),
        ),
      ],
    );
  }
}
