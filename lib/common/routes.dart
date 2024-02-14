import 'package:frozit/common/names.dart';
import 'package:frozit/views/verify/verify_screen.dart';

import '../views/router/navigation_router.dart';
import '../views/welcome_screen.dart';
import '../views/login/login.dart';

final routes = {
  ScreenRoutes.welcome: (_) => const WelcomeScreen(),
  ScreenRoutes.login: (_) => const LoginScreen(),
  // ScreenRoutes.signup: (_) => const SignupScreen(),
  ScreenRoutes.verify: (_) => const VerifyScreen(),
  ScreenRoutes.navigationRouter: (_) => const NavigationRouterScreen(),
  // ScreenRoutes.product: (_) => const ProductScreen(),
  // ScreenRoutes.viewProduct: (_) => const ViewProductScreen(),
  // ScreenRoutes.cart: (_) => const CartScreen(),
  // ScreenRoutes.payment: (_) => const PaymentScreen(),
  // ScreenRoutes.address: (_) => const AddressScreen(),
  // ScreenRoutes.account: (_) => const AccountScreen(),
};
