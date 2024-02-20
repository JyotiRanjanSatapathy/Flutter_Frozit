import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:frozit/widgets/illustartion.dart';

import '../widgets/button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Welcome'),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            const IllustrationWidget(
              'assets/images/undraw_welcome_re_h3d9.svg',
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FrozitPrimaryButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.of(context).pushNamed(ScreenRoutes.login);
                    },
                  ),
                  const LabelText1(),
                  const FrozitPrimaryButton2(),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          ScreenRoutes.navigationRouter,
                          (route) => false,
                        );
                      },
                      child: const Text(
                        "Continue as a guest",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
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

class LabelText1 extends StatelessWidget {
  const LabelText1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        'OR',
        style: TextStyle(
          color: kPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class FrozitPrimaryButton2 extends StatelessWidget {
  const FrozitPrimaryButton2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ScreenRoutes.signup);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: kContainerColor2,
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
    );
  }
}
