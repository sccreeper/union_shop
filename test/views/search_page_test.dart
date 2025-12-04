import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/search_page.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

void main() {

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();
  });
  testWidgets("page functionality", (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => Cart(),
        child: const MaterialApp(
          home: BaseLayout(child: SearchPage()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(const Key("search-field")), "mug");
    await tester.pumpAndSettle();

    expect(tester.widgetList(find.byType(ProductCard)).length,
        1);
  });
}
