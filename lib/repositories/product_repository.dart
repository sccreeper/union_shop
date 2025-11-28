import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:union_shop/models/product.dart';

class ProductRepository {

  static final ProductRepository instance = ProductRepository._internal();
  factory ProductRepository() => instance;
  ProductRepository._internal();

  late final Map<String, Product> _products;

  Product? getProduct(String key) {
    return _products[key];
  }

  void loadProducts() async {

    String jsonString = await rootBundle.loadString("assets/store/products.json");
    List<dynamic> jsonList = json.decode(jsonString);
    List<Map<String, dynamic>> jsonData = jsonList.map((v) => v as Map<String, dynamic>).toList();

    _products = {};
    
    for (Map<String, dynamic> element in jsonData) {
      Product product = Product.fromJson(element);

      _products[product.id] = product;
    }

  }

}