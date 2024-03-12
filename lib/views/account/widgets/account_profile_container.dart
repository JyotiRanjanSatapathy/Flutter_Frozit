import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/views/account/model/account_model.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:provider/provider.dart';

class AccountProfileContainer extends StatelessWidget {
  const AccountProfileContainer({
    super.key,
  });

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
      child: Selector<AccountProvider, UserAccount?>(
        selector: (context, account) => account.user,
        builder: (context, user, child) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 30,
                      color: kPrimaryColor,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user?.address?.name ?? 'Guest',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          user?.email ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                            color: kSecondaryColor,
                          ),
                        ),
                        (user?.phone != null)
                            ? Text(
                                "+ 91 ${user?.phone}",
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: kSecondaryColor,
                                ),
                              )
                            : const Text(
                                'No Phone Number',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: kSecondaryColor,
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
                user != null
                    ? IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ScreenRoutes.address);
                        },
                        icon: const Icon(Icons.edit, color: kPrimaryColor),
                      )
                    : IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ScreenRoutes.login);
                        },
                        icon: const Icon(Icons.login, color: kPrimaryColor),
                      )
              ],
            ),
          );
        },
      ),
    );
  }
}
