import 'package:flutter/material.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:provider/provider.dart';

import '../../../common/colors.dart';
import '../../account/model/account_model.dart';

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
            child: Selector<AccountProvider, UserAccount?>(
              selector: (context, account) => account.user,
              builder: (_, user, __) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Hi ',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: kContainerColor2,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '${user?.address?.name ?? "Guest"}!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: kPrimaryColor,
                        size: 20,
                      ),
                      Text(
                        ' ${user?.address?.city ?? 'Add Address'}',
                        style: const TextStyle(
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
