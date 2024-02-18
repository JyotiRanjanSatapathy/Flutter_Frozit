import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/views/account/model/account_model.dart';
import 'package:frozit/views/account/model/account_provider.dart';
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
            return Column(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: kContainerColorLight,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 0,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: kBorderColor,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Name: ${user.location!.address}'),
                      Text('Email: ${user.email}'),
                      Text('Phone: ${user.phone}'),
                    ],
                  ),
                ),
                Text('Checkout Screen'),
              ],
            );
          }
        },
      ),
    );
  }
}
