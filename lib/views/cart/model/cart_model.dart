import 'package:flutter/foundation.dart';
import 'package:frozit/views/view_product/model/product_info.dart';

class CartProduct {
  final ProductInfo product;
  final int quantity;

  CartProduct(this.product, this.quantity);
}

class CartProvider with ChangeNotifier {
  Map<String, CartProduct> _cartItems = {};
  double gstPercent = .18;

  void addToCart(ProductInfo product) {
    String name = product.name;
    _cartItems.update(
      name,
      (value) => CartProduct(value.product, value.quantity + 1),
      ifAbsent: () => CartProduct(product, 1),
    );
    _cartItems = Map.from(_cartItems);
    notifyListeners();
  }

  void reduceFromCart(ProductInfo product) {
    String name = product.name;
    if (_cartItems[name]?.quantity == 1) {
      removeFromCart(product);
      return;
    }
    _cartItems.update(
      name,
      (value) => CartProduct(value.product, value.quantity - 1),
    );
    _cartItems = Map.from(_cartItems);
    notifyListeners();
  }

  void removeFromCart(ProductInfo product) {
    _cartItems.remove(product.name);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  int getCartItemsCount() {
    return _cartItems.length;
  }

  int getQuantity(ProductInfo product) {
    return _cartItems[product]?.quantity ?? 0;
  }

  List<CartProduct> getCartItems() {
    return _cartItems.values.toList();
  }

  double getGSTAmount() {
    return double.parse((getCartTotalPrice() / (1 + gstPercent) * gstPercent)
        .toStringAsFixed(2));
  }

  double getCartTotalPriceWithoutGST() {
    return double.parse(
        (getCartTotalPrice() / (1 + gstPercent)).toStringAsFixed(2));
  }

  double getCartTotalPrice() {
    double total = 0;
    _cartItems.forEach((_, cartProduct) {
      total += double.parse(cartProduct.product.price) * cartProduct.quantity;
    });
    return double.parse(total.toStringAsFixed(2));
  }
}
