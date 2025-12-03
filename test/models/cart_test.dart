import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group("cart tests", () {
    final List<Product> testProducts = [];

    for (var i = 0; i < 3; i++) {
      testProducts.add(Product(
          name: "Product ${i + 1}",
          description: "Test",
          rrp: 10.00,
          id: "product-${i + 1}",
          productAttributes: {},
          imageNames: [""]));
    }

    test("test adding items", () {
      final Cart cart = Cart();

      cart.addItem(
          CartItem(product: testProducts[0], attributes: {}, quantity: 2));
      cart.addItem(
          CartItem(product: testProducts[1], attributes: {}, quantity: 1));

      expect(cart.totalPrice, 30.00);
      expect(cart.length, 2);
      expect(cart.totalItems, 3);
    });

    test("removing items", () {
      final Cart cart = Cart();

      cart.addItem(
          CartItem(product: testProducts[0], attributes: {}, quantity: 2));
      cart.addItem(
          CartItem(product: testProducts[1], attributes: {}, quantity: 1));
      cart.removeItem(1);

      expect(cart.totalPrice, 20.00);
      expect(cart.length, 1);
      expect(cart.totalItems, 2);
    });

    test("item quantity", () {
      final Cart cart = Cart();

      cart.addItem(
          CartItem(product: testProducts[0], attributes: {}, quantity: 2));

      expect(cart.getQuantity(0), 2);

      cart.setQuantity(0, 3);

      expect(cart.getQuantity(0), 3);
    });

    test("clearing", () {
      final Cart cart = Cart();

      cart.addItem(
          CartItem(product: testProducts[0], attributes: {}, quantity: 2));
      
      cart.clear();

      expect(cart.length, 0);
    });
  });
}
