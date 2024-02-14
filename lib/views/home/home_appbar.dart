import 'package:flutter/material.dart';

import '../../common/colors.dart';

class FrozitHomeToolBar extends StatelessWidget {
  const FrozitHomeToolBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    text: 'Hi ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: kContainerColor2,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Rajeev!',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(
                      Icons.location_on_rounded,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                    Text(
                      ' Bhubaneswar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            color: kSecondaryColor.withOpacity(0.1),
            thickness: 3,
          ),
        ],
      ),
    );
  }
}
