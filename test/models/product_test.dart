import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';

const String productJsonString = '''{
    "id" : "sweater-1",
    "imageNames" : ["sweater-1"],
    "name" : "Big Sweater",
    "description" : "A big comfortable sweater",
    "rrp" : 10.00,
    "salePrice" : 0.00,
    "productAttributes" : {
        "size" : {
            "xl" : "XL",
            "l" : "L",
            "m" : "M",
            "s" : "S",
            "xs" : "XS"
        }
    }
}''';

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

    test("json deserialize", () {
      Map<String, dynamic> productData = json.decode(productJsonString);
      final Product product = Product.fromJson(productData);

      expect(product.name, "Big Sweater");
      expect(product.description, "A big comfortable sweater");
      expect(product.rrp, 10.00);
      expect(product.productAttributes, {
        "size": {"xl": "XL", "l": "L", "m": "M", "s": "S", "xs": "XS"}
      });
    });
  });
}
