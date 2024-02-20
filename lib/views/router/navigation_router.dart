import 'package:flutter/material.dart';
import 'package:frozit/views/account/account_screen.dart';
import 'package:frozit/views/cart/cart_screen.dart';
import 'package:frozit/views/home/home_screen.dart';
import 'package:frozit/views/product/product_screen.dart';
import 'package:frozit/views/router/model/navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';

class NavigationRouterScreen extends StatelessWidget {
  const NavigationRouterScreen({super.key});

  static const Map<String, IconData> icons = {
    'Home': Icons.home,
    'Products': Icons.shopping_bag_rounded,
    'Cart': Icons.shopping_cart,
    'Account': Icons.account_circle,
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (_, router, __) {
        return Scaffold(
          body: [
            const HomeScreen(),
            const ProductScreen(),
            const CartScreen(),
            const AccountScreen()
          ][router.currentIndex],
          bottomNavigationBar: NavigationBar(
            overlayColor: MaterialStateProperty.all(kContainerColor),
            elevation: 10,
            shadowColor: Colors.black,
            surfaceTintColor: kContainerColor,
            indicatorColor: kPrimaryColor,
            selectedIndex: router.currentIndex,
            onDestinationSelected: (int index) {
              router.currentIndex = index;
            },
            // surfaceTintColor: Colors.white,
            destinations: icons.keys
                .map(
                  (String title) => NavigationDestination(
                    icon: Icon(
                      icons[title],
                      color: kPrimaryColor,
                    ),
                    selectedIcon: Icon(
                      icons[title],
                      color: kContainerColorLight,
                    ),
                    label: title,
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}
