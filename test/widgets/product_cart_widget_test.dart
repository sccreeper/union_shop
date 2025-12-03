import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

void main() {
  group("product card tests", () {
    testWidgets("product card displays correctly", (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ProductCard(
                product: Product(
                    description: "test",
                    rrp: 10.00,
                    id: "product-id",
                    productAttributes: {},
                    name: "Test Product",
                    imageNames: ["badge-pin-1-crest"]))),
      ));
      await tester.pumpAndSettle();

      expect(find.text("Test Product"), findsOne);
      expect(find.textContaining("10.00"), findsOne);
      expect(
          find.image(Image.asset("assets/images/products/badge-pin-1-crest.png")
              .image),
          findsOne);
    });

    testWidgets("product card displays sale price correctly",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: ProductCard(
                product: Product(
                    description: "test",
                    rrp: 10.00,
                    salePrice: 5.00,
                    id: "product-id",
                    productAttributes: {},
                    name: "Test Product",
                    imageNames: ["badge-pin-1-crest"]))),
      ));
      await tester.pumpAndSettle();

      expect(find.textContaining("10.00"), findsOne);
      expect(find.textContaining("5.00"), findsOne);
    });
  });
}
