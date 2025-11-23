import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:union_shop/models/product.dart';

class ProductRepository {

  static final ProductRepository instance = ProductRepository();
  factory ProductRepository() => instance;
  // ignore: unused_element
  ProductRepository._internal();

  late final Map<String, Product> _products;

  Product? getProduct(String key) {
    return _products[key];
  }

  void loadProducts() async {

    final String jsonString = await rootBundle.loadString("assets/store/products.json");
    final List<Map<String, dynamic>> jsonData = json.decode(jsonString);

    _products = {};
    
    for (Map<String, dynamic> element in jsonData) {
      Product product = Product.fromJson(element);

      _products[product.id] = product;
    }

  }

}