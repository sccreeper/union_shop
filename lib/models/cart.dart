import 'package:union_shop/models/product.dart';

class CartItem {
  final Product product;
  late int _quantity;

  CartItem({required this.product, required int quantity}) {
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

class Cart {
  
  late List<CartItem> items;

  Cart() {
    items = [];
  }

  double get totalPrice => items.fold(
      0.00,
      (previousValue, item) =>
          previousValue + (item.product.truePrice) * item.quantity);

}
