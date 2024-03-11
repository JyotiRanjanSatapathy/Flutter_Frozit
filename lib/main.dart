import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:frozit/common/colors.dart';
import 'package:frozit/common/routes.dart';
import 'package:frozit/views/account/model/account_provider.dart';
import 'package:frozit/views/product/model/products.dart';
import 'package:frozit/views/router/model/navigation_provider.dart';
import 'package:frozit/views/welcome_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'views/cart/model/cart_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationProvider()),
        ChangeNotifierProvider(create: (context) => ProductsModel()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
        ChangeNotifierProvider(create: (context) => AccountProvider()),
      ],
      child: GlobalLoaderOverlay(
        child: MaterialApp(
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
        ),
      ),
    );
  }
}
