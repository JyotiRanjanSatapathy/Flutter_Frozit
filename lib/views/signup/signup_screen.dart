import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frozit/common/api.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:frozit/widgets/button.dart';
import 'package:frozit/widgets/text_field.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../common/colors.dart';
import '../../common/names.dart';
import '../account/model/account_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/undraw_sign_up_n6im.svg',
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  FrozitTextField(
                    controller: emailController,
                    label: 'Email',
                  ),
                  const SizedBox(height: 20),
                  FrozitTextField(
                    controller: passwordController,
                    label: 'Password',
                  ),
                  const SizedBox(height: 20),
                  FrozitTextField(
                    controller: phoneController,
                    label: 'Phone',
                    maxLength: 10,
                  ),
                  const SizedBox(height: 30),
                  FrozitPrimaryButton(
                      text: "Create Account",
                      onPressed: () async {
                        // TODO: Do API call here
                        final String email = emailController.text;
                        final String phone = phoneController.text;
                        final String password = passwordController.text;
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        context.loaderOverlay.show();
                        final user = await Api.register(email, phone, password);
                        if (user != null) {
                          context.read<AccountProvider>().saveUserDetails(user);
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            ScreenRoutes.navigationRouter,
                            (route) => false,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Invalid email or password',
                                style: TextStyle(color: kPrimaryColor),
                              ),
                              backgroundColor: kContainerColorLight,
                            ),
                          );
                        }
                        context.loaderOverlay.hide();
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
