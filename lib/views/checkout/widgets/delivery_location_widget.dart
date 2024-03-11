import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';

import '../../account/model/account_model.dart';

class DeliveryLocationWidget extends StatelessWidget {
  const DeliveryLocationWidget({
    super.key,
    required this.user,
  });

  final UserAccount user;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kContainerColorLight,
        boxShadow: const [
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.location_on,
                  size: 20,
                  color: kPrimaryColor,
                ),
                const SizedBox(width: 15),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.address?.name ?? 'Add Address',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                        '${user.address?.area}\n${user.address?.city}, ${user.address?.state}'),
                  ],
                ),
              ],
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, ScreenRoutes.address);
              },
              icon: const Icon(
                Icons.edit,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
