import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

void main() {
  group("product tests", () {
    test("not on sale", () {
      final product = Product(
          name: "Test",
          description: "Test description",
          rrp: 10.00,
          id: "product-1",
          productAttributes: {},
          imageNames: [""]);

      expect(product.onSale, false);
      expect(product.truePrice, 10.00);
    });

    test("on sale", () {
      final product = Product(
          name: "Test",
          description: "Test description",
          rrp: 10.00,
          salePrice: 5.00,
          id: "product-1",
          productAttributes: {},
          imageNames: [""]);

      expect(product.onSale, true);
      expect(product.truePrice, 5.00);
    });
  });
}
