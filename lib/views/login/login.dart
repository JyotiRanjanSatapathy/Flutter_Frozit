import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frozit/common/api.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/names.dart';
import 'package:frozit/widgets/appbar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import '../../widgets/button.dart';
import '../../widgets/illustartion.dart';
import '../../widgets/text_field.dart';
import '../account/model/account_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const FrozitAppbar(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: SvgPicture.asset(
                'assets/images/undraw_login_re_4vu2.svg',
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  FrozitPrimaryButton(
                    text: 'Login',
                    onPressed: () => login(context),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Or login with",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: kSecondaryColor,
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ScreenRoutes.phoneLogin);
                          },
                          icon: const Icon(
                            Icons.phone_rounded,
                            color: kPrimaryColor,
                            size: 70,
                          ),
                        ),
                        const SizedBox(width: 30),
                        IconButton(
                          onPressed: () => signInWithGoogle(),
                          icon: Image.asset('assets/images/google.png'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    log('signing in with google');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: [
          'email',
          'profile',
        ],
      ).signIn();
      // log(googleUser.toString());

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // log(googleAuth.toString());
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // TODO: Call the API to get user details from firebase token
        String? firebaseToken = await userCredential.user?.getIdToken();
        log('Firebase Token: $firebaseToken');
        if (firebaseToken != null) {
          context.loaderOverlay.show();
          final account = await Api.getUser(firebaseToken: firebaseToken);
          if (account != null) {
            log("Account: $account");
            context.read<AccountProvider>().saveUserDetails(account);
            context.loaderOverlay.hide();
            Navigator.pushNamedAndRemoveUntil(
              context,
              ScreenRoutes.navigationRouter,
              (route) => false,
            );
          } else {
            Fluttertoast.showToast(msg: "Account not found");
          }
        } else {
          Fluttertoast.showToast(
            msg: 'Failed to get user details',
            toastLength: Toast.LENGTH_LONG,
          );
        }
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> login(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.loaderOverlay.show();
    final accountModel = context.read<AccountProvider>();
    final account = await Api.loginEmail(
      email: emailController.text,
      password: passwordController.text,
    );
    if (account != null) {
      accountModel.saveUserDetails(account);
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
  }
}
