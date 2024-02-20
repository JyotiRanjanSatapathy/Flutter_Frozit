import 'package:flutter/material.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:frozit/views/account/widgets/account_menu_item.dart';
import 'package:frozit/views/account/widgets/account_profile_container.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../common/names.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Account'),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              children: [
                AccountProfileContainer(),
                SizedBox(height: 20),
                AccountMenuItem(
                  text: 'Order History',
                  icon: Icons.history,
                ),
                SizedBox(height: 10),
                AccountMenuItem(
                  text: 'Address Book',
                  icon: Icons.location_on,
                  route: ScreenRoutes.address,
                ),
                SizedBox(height: 10),
                AccountMenuItem(
                  text: 'Payment Methods',
                  icon: Icons.payment,
                ),
                SizedBox(height: 10),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AccountProvider>().logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  ScreenRoutes.login,
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                context.read<AccountProvider>().user != null
                    ? 'Logout'
                    : 'Login',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
