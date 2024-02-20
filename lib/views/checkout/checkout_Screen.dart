import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/views/account/model/account_model.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:frozit/views/cart/model/cart_model.dart';
import 'package:frozit/views/checkout/widgets/delivery_location_widget.dart';
import 'package:frozit/widgets/button.dart';
import 'package:provider/provider.dart';

import '../../common/names.dart';
import '../../widgets/appbar.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Checkout'),
      body: Selector<AccountProvider, UserAccount?>(
        selector: (context, account) => account.user,
        builder: (context, user, child) {
          if (user == null) {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      'Account not found, Please login to continue.',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  FrozitPrimaryButton(
                    text: "Login",
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenRoutes.login);
                    },
                  ),
                ],
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildSubHeading('Delivery Address'),
                        const SizedBox(height: 20),
                        DeliveryLocationWidget(user: user),
                        const SizedBox(height: 20),
                        buildSubHeading('Payment Method'),
                        const SizedBox(height: 20),
                        const PaymentMethods(),
                        const SizedBox(height: 20),
                        buildOrderSummary(context),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                  FrozitPrimaryButton(
                    text:
                        'Place Order ₹ ${context.read<CartProvider>().getCartTotalPrice()}',
                    onPressed: () {
                      Navigator.pushNamed(context, ScreenRoutes.paymentSuccess);
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Text buildSubHeading(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: kPrimaryColor,
      ),
    );
  }

  Column buildOrderSummary(BuildContext context) {
    final cart = context.read<CartProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSubHeading('Order Summary'),
        const SizedBox(height: 20),
        buildPriceBreakdown(
          'Price',
          '₹ ${cart.getCartTotalPriceWithoutGST()}',
        ),
        buildPriceBreakdown(
          'GST',
          '₹ ${cart.getGSTAmount()}',
        ),
        buildPriceBreakdown(
          'Total',
          '₹ ${cart.getCartTotalPrice()}',
          isBold: true,
        ),
      ],
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

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({
    super.key,
  });

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int selectedPaymentMethod = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildPaymentMethod(
          index: 0,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Image.asset('assets/images/UPILogo.png'),
          ),
        ),
        buildPaymentMethod(
          index: 1,
          child: const Row(
            children: [
              Icon(Icons.add_card_rounded, color: kPrimaryColor),
              SizedBox(width: 20),
              Text(
                "Debit Card",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
        buildPaymentMethod(
          index: 2,
          child: const Row(
            children: [
              Icon(Icons.add_card, color: kContainerColor2),
              SizedBox(width: 20),
              Text(
                "Credit Card",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  InkWell buildPaymentMethod({
    required Widget child,
    required int index,
  }) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedPaymentMethod = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 30,
          child: Row(
            children: [
              Radio.adaptive(
                groupValue: selectedPaymentMethod,
                value: index,
                onChanged: (value) {},
                activeColor: kPrimaryColor,
              ),
              const SizedBox(width: 20),
              child,
            ],
          ),
        ),
      ),
    );
  }

  // Convert the buildPaymentMethods to widget (to use setState())
}

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({
    super.key,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // setState(() {
        //   isSelected = !isSelected;
        // });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          height: 20,
          child: Row(
            children: [
              Checkbox.adaptive(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                value: true,
                onChanged: (value) {},
                activeColor: kPrimaryColor,
              ),
              const SizedBox(height: 10),
              Image.asset('assets/images/UPILogo.png'),
            ],
          ),
        ),
      ),
    );
  }
}
