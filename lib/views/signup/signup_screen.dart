import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:frozit/widgets/button.dart';
import 'package:frozit/widgets/text_field.dart';
import 'package:provider/provider.dart';

import '../../common/names.dart';
import '../account/model/account_provider.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Sign Up'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/undraw_sign_up_n6im.svg',
                height: 200,
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    FrozitTextField(
                      controller: nameController,
                      label: 'Name',
                    ),
                    const SizedBox(height: 20),
                    FrozitTextField(
                      controller: emailController,
                      label: 'Email',
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
                        onPressed: () {
                          // TODO: Do API call here
                          final String name = nameController.text;
                          final String email = emailController.text;
                          final String phone = phoneController.text;
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          context.read<AccountProvider>().signupUser(
                                name: name,
                                email: email,
                                phone: phone,
                              );
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            ScreenRoutes.verify,
                            (route) => false,
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
