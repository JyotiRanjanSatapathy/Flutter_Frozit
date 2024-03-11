import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frozit/common/api.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/widgets/illustartion.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import '../account/model/account_provider.dart';
import 'phone_input.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController =
      TextEditingController(text: "+91");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: ScreenRoutes.login),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const IllustrationWidget(
              'assets/images/undraw_login_re_4vu2.svg',
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  "OTP will be sent to your mobile number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: kSecondaryColor,
                  ),
                ),
                const SizedBox(height: 20),
                PhoneInputField(_phoneController),
                const SizedBox(height: 30),
                FrozitRoundedButton(
                  text: 'Get OTP',
                  onPressed: () async => await getOTP(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getOTP(BuildContext context) async {
    final String phone = _phoneController.text;
    if (phone.isEmpty || phone.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please enter a valid phone number',
            style: TextStyle(color: kPrimaryColor),
          ),
          backgroundColor: kContainerColorLight,
        ),
      );
      // return;
    }

    log('Phone: $phone');
    FirebaseAuth auth = FirebaseAuth.instance;
    context.loaderOverlay.show();
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto verification (works on some devices, not all)
        log('verificationCompleted, $credential');
        
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        String? firebaseToken = await userCredential.user?.getIdToken();
        log('Firebase Token: $firebaseToken');
        if (firebaseToken != null) {
          Api.getUser(firebaseToken: firebaseToken).then((user) {
            if (user != null) {
              context.read<AccountProvider>().saveUserDetails(user);
            }
          });
        }

        context.loaderOverlay.hide();
      },
      verificationFailed: (FirebaseAuthException e) {
        log('verificationFailed, $e');
        context.loaderOverlay.hide();
      },
      codeSent: (String verificationId, int? resendToken) async {
        log('codeSent, $verificationId, $resendToken');
        context.read<AccountProvider>().verificationId = verificationId;
        context.read<AccountProvider>().resendToken = resendToken;
        context.read<AccountProvider>().phone = phone;
        context.loaderOverlay.hide();
        Navigator.of(context).pushNamed(ScreenRoutes.verify);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('codeAutoRetrievalTimeout, $verificationId');
      },
    );

    // await context.read<AccountProvider>().loginUserByPhone(phone);
  }
}
