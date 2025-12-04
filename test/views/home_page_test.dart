import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/home.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();
  });

  testWidgets("home page displays correctly", (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Cart(),
        child: const MaterialApp(
          home: BaseLayout(child: HomeScreen()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text("Product Selection"), findsOne);
    expect(find.text("Popular Collections"), findsOne);

    expect(tester.widgetList(find.byType(ProductCard)).length,
        4);
  });
}
