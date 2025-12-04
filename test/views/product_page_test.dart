import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/product_page.dart';

void main() async {
  final List<Product> testProducts = [];

  for (var i = 0; i < 3; i++) {
    testProducts.add(Product(
        name: "Product ${i + 1}",
        description: "Test",
        rrp: 30.00,
        id: "product-${i + 1}",
        productAttributes: {
          "size": {"large": "Large", "small": "Small", "medium": "Medium"}
        },
        imageNames: [
          "badge-pin-1-crest",
          "badge-pin-1-mascot",
          "badge-pin-1-motto"
        ]));
  }

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();
  });
  testWidgets("test product page functionality", (tester) async {
    final cart = Cart();

    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: cart,
        child: MaterialApp(home: BaseLayout(child: ProductPage(product: testProducts[0]))),
      ),
    );
    await tester.pumpAndSettle();

    // Change quantity 
    await tester.ensureVisible(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Check quantity
    await tester.ensureVisible(find.textContaining("2"));
    expect(find.textContaining("2"), findsOne);

    // Remove and check quantity again
    await tester.ensureVisible(find.byIcon(Icons.remove));
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.textContaining("1"));
    expect(find.textContaining("1"), findsOne);

    // Change size

    await tester.ensureVisible(find.byKey(const Key("attribute-size")));
    await tester.tap(find.byKey(const Key("attribute-size")));
    await tester.pumpAndSettle();

    await tester.tap(find.text("Small"));
    await tester.pumpAndSettle();

    // Add to cart

    await tester.tap(find.text("Add to cart"));
    await tester.pumpAndSettle();

    // Check cart items are correct

    expect(cart.items[0].attributes["size"], "small");
    expect(cart.items[0].product.id, "product-1");

  });
  
}
