import 'package:flutter/material.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:frozit/widgets/button.dart';
import 'package:frozit/widgets/illustartion.dart';

import '../../common/colors.dart';
import 'dotted_field.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

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
          children: [
            const IllustrationWidget(
                'assets/images/undraw_access_account_re_8spm.svg'),
            const Text(
              'We have sent a verification code to your phone number',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: kSecondaryColor,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DottedTextField(controller: _otpController),
                  const SizedBox(height: 50),
                  FrozitRoundedButton(
                    text: 'Verify',
                    onPressed: () {
                      // TODO: Do API call here
                      // final String otp = _otpController.text;
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        ScreenRoutes.navigationRouter,
                        (route) => false,
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
