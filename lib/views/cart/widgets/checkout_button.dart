import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ScreenRoutes.checkout);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Proceed to checkout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 10),
            Icon(
              Icons.shopping_cart_checkout_outlined,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
