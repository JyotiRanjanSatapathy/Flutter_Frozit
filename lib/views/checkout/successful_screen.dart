import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../common/names.dart';
import '../../widgets/button.dart';
import '../cart/model/cart_model.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Success'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/undraw_order_confirmed_re_g0if.svg',
                      height: 200,
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Order confirmed!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              FrozitPrimaryButton(
                text: 'Done',
                onPressed: () {
                  Navigator.popUntil(
                    context,
                    ModalRoute.withName(ScreenRoutes.navigationRouter),
                  );
                  context.read<CartProvider>().clearCart();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
