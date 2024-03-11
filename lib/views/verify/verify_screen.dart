import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:frozit/widgets/illustartion.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../widgets/button.dart';
import 'dotted_field.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key, this.fromCart = false});

  final bool fromCart;

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(
        title: ScreenRoutes.verify,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const IllustrationWidget(
                'assets/images/undraw_access_account_re_8spm.svg'),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'We have sent a verification code to ${context.read<AccountProvider>().phone}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ),
                DottedTextField(
                  controller: _otpController,
                  onFieldChanged: (String value) {
                    if (value.length == 6) {
                      verifyOTP(context);
                    }
                  },
                ),
                const SizedBox(height: 50),
                TextButton(
                  onPressed: () {},
                  child: const Text("Resend OTP"),
                ),
                const SizedBox(height: 40),
                FrozitRoundedButton(
                  text: 'Verify',
                  onPressed: () => verifyOTP(context),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void verifyOTP(BuildContext context) async {
    String smsCode = _otpController.text;
    context.loaderOverlay.show();
    bool success = await context.read<AccountProvider>().verifyOTP(smsCode);
    context.loaderOverlay.hide();
    if (success) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        ScreenRoutes.navigationRouter,
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid OTP',
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: kContainerColorLight,
        ),
      );
    }
  }
}
