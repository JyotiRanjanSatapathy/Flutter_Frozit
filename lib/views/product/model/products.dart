import 'package:flutter/foundation.dart';

import '../../home/model/product_category.dart';
import '../../view_product/model/product_info.dart';

class ProductsModel with ChangeNotifier {
  List<ProductInfo> products = [];
  List<ProductCategory> categories = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Get products list from server
  final List<Map<String, dynamic>> _productList = [
    {
      'name': 'Choco Bites',
      'category': 'Cookies',
      'price': '200',
      'image': 'assets/images/Choco bites.png',
      'weight': '200g',
      'description':
          'Delicious and crunchy cookies, perfect for tea time. Made with the finest ingredients and love.'
    },
    {
      'name': 'Choco Chip Cookies',
      'category': 'Cookies',
      'price': '150',
      'image': 'assets/images/Cookies (1).png',
      'weight': '200g',
      'description':
          'Delicious and crunchy cookies, perfect for tea time. Made with the finest ingredients and love.'
    },
    {
      'name': 'Tea Cookies',
      'category': 'Cookies',
      'price': '100',
      'image': 'assets/images/Cookies (2).png',
      'weight': '200g',
      'description':
          'Delicious and crunchy cookies, perfect for tea time. Made with the finest ingredients and love.'
    },
    {
      'name': 'Salt and Sweet Cookies',
      'description': 'Delicious and crunchy',
      'category': 'Cookies',
      'price': '250',
      'image': 'assets/images/Cookies (3).png',
      'weight': '200g'
    },
    {
      'name': 'Ragi Flour',
      'category': 'Flour',
      'description': 'Healthy and nutritious',
      'price': '100',
      'image': 'assets/images/Ragi Flour.png',
      'weight': '500g'
    },
    {
      'name': 'Corn Flour',
      'category': 'Flour',
      'description': 'Healthy and nutritious',
      'price': '200',
      'image': 'assets/images/Ruchi Corn Flour.png',
      'weight': '500g'
    },
    {
      'name': 'Sagoo',
      'category': 'Healthy Food',
      'description': 'Healthy and nutritious',
      'price': '300',
      'image': 'assets/images/Sagoo.png',
      'weight': '500g'
    },
  ];

  final List<Map<String, dynamic>> _categoryList = [
    {
      'name': 'Cookies',
      'image': 'assets/images/Cookies.png',
    },
    {
      'name': 'Flour',
      'image': 'assets/images/Ragi Flour.png',
    },
    {
      'name': 'Healthy Food',
      'image': 'assets/images/Sagoo.png',
    },
  ];

  List<ProductInfo> getProductsByCategory(String category) {
    return products.where((product) => product.category == category).toList();
  }

  Future<void> getProducts() async {
    if (products.isNotEmpty) return;

    isLoading = true;

    // TODO: Get products from server
    // await Future.delayed(const Duration(milliseconds: 500));

    // Add products to the list
    products =
        _productList.map((product) => ProductInfo.fromJson(product)).toList();

    isLoading = false;
    notifyListeners();
  }

  Future<void> getCategories() async {
    isLoading = true;

    categories = _categoryList
        .map((category) => ProductCategory.fromJson(category))
        .toList();

    isLoading = false;
  }

  ProductInfo getProductByIndex(String index) {
    return products[int.parse(index)];
  }

  ProductInfo? _currentProduct;
  ProductInfo? get currentProduct => _currentProduct;
  set currentProduct(ProductInfo? product) {
    _currentProduct = product;
    notifyListeners();
  }

  ProductCategory _currentCategory = ProductCategory(name: 'All', image: '');
  ProductCategory get currentCategory => _currentCategory;
  set currentCategory(ProductCategory category) {
    _currentCategory = category;

    products = category.name == 'All'
        ? _productList.map((product) => ProductInfo.fromJson(product)).toList()
        : _productList
            .where((product) => product['category'] == category.name)
            .map((product) => ProductInfo.fromJson(product))
            .toList();
    notifyListeners();
  }
}
