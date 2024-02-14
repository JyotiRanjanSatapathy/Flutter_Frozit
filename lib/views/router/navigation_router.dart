import 'package:flutter/material.dart';
import 'package:frozit/views/home/home_screen.dart';
import 'package:frozit/views/product/product_screen.dart';

import '../../common/colors.dart';

class NavigationRouterScreen extends StatefulWidget {
  const NavigationRouterScreen({super.key});

  @override
  State<NavigationRouterScreen> createState() => _NavigationRouterScreenState();
}

class _NavigationRouterScreenState extends State<NavigationRouterScreen> {
  final Map<String, IconData> _icons = {
    'Home': Icons.home,
    'Products': Icons.shopping_bag_rounded,
    'Cart': Icons.shopping_cart,
    'Account': Icons.account_circle,
  };

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const HomeScreen(),
        const ProductScreen(),
        Container(
          color: Colors.green,
        ),
        Container(
          color: Colors.blue,
        ),
      ][currentPageIndex],
      bottomNavigationBar: NavigationBar(
        overlayColor: MaterialStateProperty.all(Colors.white),
        indicatorColor: kPrimaryColor,
        selectedIndex: currentPageIndex,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        // surfaceTintColor: Colors.white,
        destinations: _icons.keys
            .map(
              (String title) => NavigationDestination(
                icon: Icon(
                  _icons[title],
                  color: kPrimaryColor,
                ),
                selectedIcon: Icon(
                  _icons[title],
                  color: Colors.white,
                ),
                label: title,
              ),
            )
            .toList(),
      ),
    );
  }
}
