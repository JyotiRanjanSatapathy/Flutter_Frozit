import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/routes.dart';
import 'package:frozit/views/welcome_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Avenir',
        colorScheme: const ColorScheme.light(
          primary: kPrimaryColor,
          secondary: kSecondaryColor,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: kPrimaryColor,
        ),
      ),
      routes: routes,
      home: const WelcomeScreen(),
    );
  }
}
