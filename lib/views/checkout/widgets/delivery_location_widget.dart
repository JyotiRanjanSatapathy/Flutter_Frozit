import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';

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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0, bottom: 5),
                  child: Text(
                    user.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 20,
                      color: kPrimaryColor,
                    ),
                    Text(
                        '${user.location?.address}, ${user.location?.city}, ${user.location?.state}'),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
