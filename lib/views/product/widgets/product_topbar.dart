import 'package:flutter/material.dart';

import '../../../common/colors.dart';

class ProductTopBar extends StatelessWidget {
  const ProductTopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: const TextSpan(
        text: 'Frozit\n',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: kContainerColor2,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Range',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
