import 'package:flutter/widgets.dart';
import 'package:union_shop/models/product.dart';

class CartItem {
  final Product product;
  final Map<String, String> attributes;
  late int _quantity;

  CartItem(
      {required this.product,
      required this.attributes,
      required int quantity}) {
    _quantity = quantity;
  }

  int get quantity => _quantity;

  set quantity(v) {
    if (v < 0) {
      return;
    }

    _quantity = v;
  }
}

class Cart extends ChangeNotifier {
  late List<CartItem> _items;

  Cart() {
    _items = [];
  }

  void addItem(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  CartItem getItem(int index) {
    return _items[index];
  }

  CartItem removeItem(int index) {
    CartItem item = _items.removeAt(index);
    notifyListeners();
    return item;
  }

  int getQuantity(int index) {
    return _items[index].quantity;
  }

  void setQuantity(int index, int newQuantity) {
    _items[index].quantity = newQuantity;
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  int get length => _items.length;
  bool get isEmpty => _items.isEmpty;

  double get totalPrice => _items.fold(
      0.00,
      (previousValue, element) =>
          previousValue + element.product.truePrice);
}
