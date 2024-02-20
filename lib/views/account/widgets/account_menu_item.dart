import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';

class AccountMenuItem extends StatelessWidget {
  const AccountMenuItem({
    super.key,
    required this.text,
    required this.icon,
    this.route,
  });

  final String text;
  final IconData icon;
  final String? route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (route != null) {
          Navigator.pushNamed(context, route!);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: kPrimaryColor),
                const SizedBox(width: 15),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    color: kSecondaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_forward_ios,
                  color: kPrimaryColor,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
