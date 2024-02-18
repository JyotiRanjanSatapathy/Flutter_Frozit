import '../views/address/address_screen.dart';
import '../views/cart/cart_screen.dart';
import '../views/checkout/checkout_Screen.dart';
import '../views/login/login.dart';
import '../views/product/product_screen.dart';
import '../views/router/navigation_router.dart';
import '../views/verify/verify_screen.dart';
import '../views/view_product/view_product_screen.dart';
import '../views/welcome_screen.dart';
import 'names.dart';

final routes = {
  ScreenRoutes.welcome: (_) => const WelcomeScreen(),
  ScreenRoutes.login: (_) => const LoginScreen(),
  // ScreenRoutes.signup: (_) => const SignupScreen(),
  ScreenRoutes.verify: (_) => const VerifyScreen(),
  ScreenRoutes.navigationRouter: (_) => const NavigationRouterScreen(),
  ScreenRoutes.product: (_) => const ProductScreen(),
  ScreenRoutes.viewProduct: (_) => const ViewProductScreen(),
  ScreenRoutes.cart: (_) => const CartScreen(),
  ScreenRoutes.checkout: (_) => const CheckoutScreen(),
  ScreenRoutes.address: (_) => const AddressScreen(),
  // ScreenRoutes.payment: (_) => const PaymentScreen(),
  // ScreenRoutes.account: (_) => const AccountScreen(),
};
