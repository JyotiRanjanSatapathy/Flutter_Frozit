import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:frozit/widgets/illustartion.dart';
import 'package:provider/provider.dart';

import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import 'phone_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: ScreenRoutes.login),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const IllustrationWidget(
              'assets/images/undraw_login_re_4vu2.svg',
            ),
            const Text(
              "OTP will be sent to your mobile number",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: kSecondaryColor,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PhoneInputField(_phoneController),
                  const SizedBox(height: 30),
                  FrozitRoundedButton(
                    text: 'Get OTP',
                    onPressed: () async {
                      // TODO: Do API call here
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
                        return;
                      }

                      await context
                          .read<AccountProvider>()
                          .loginUserByPhone(phone);

                      Navigator.of(context).pushNamed(ScreenRoutes.verify);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
