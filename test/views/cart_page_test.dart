import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/product.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/cart_page.dart';

void main() async {
  final List<Product> testProducts = [];

  for (var i = 0; i < 3; i++) {
    testProducts.add(Product(
        name: "Product ${i + 1}",
        description: "Test",
        rrp: 10.00,
        id: "product-${i + 1}",
        productAttributes: {
          "size": {"large": "Large", "small": "Small", "medium": "Medium"}
        },
        imageNames: [
          ""
        ]));
  }

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();
  });
  testWidgets("test cart page functionality", (tester) async {
    final cart = Cart();

    tester.view.physicalSize = const Size(1920, 1080);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: cart,
        child: const MaterialApp(home: CartPage()),
      ),
    );
    await tester.pumpAndSettle();

    // First ensure cart is empty
    expect(find.text("Your cart is empty."), findsOne);

    cart.addItem(CartItem(
        product: testProducts.first,
        attributes: {"size": "large"},
        quantity: 3));
    await tester.pumpAndSettle();

    expect(find.textContaining("Product 1"), findsOne);
    expect(find.textContaining("size"), findsOne);
    expect(find.textContaining("Large"), findsOne);

    expect(find.textContaining("30.00"), findsExactly(2));

    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    expect(find.textContaining("40.00"), findsExactly(2));

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pumpAndSettle();

    expect(find.textContaining("30.00"), findsExactly(2));

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    // Ensure cart is empty again
    expect(find.text("Your cart is empty."), findsOne);
  });
  
}
