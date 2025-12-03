import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';

void main() async {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();
  });

  group("base layout test", () {
    testWidgets("test basic layout", (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (_) => Cart(),
        child: MaterialApp(
          home: BaseLayout(
              child: Container(
            height: 100,
          )),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.textContaining("Opening Hours"));
      await tester.pumpAndSettle();
      expect(find.textContaining("Opening Hours"), findsOne);

      expect(find.byIcon(Icons.search), findsOne);
      expect(find.byIcon(Icons.shopping_bag_outlined), findsOne);
      expect(find.byIcon(Icons.menu), findsOne);
    });

    testWidgets("test menu", (tester) async {
      await tester.pumpWidget(ChangeNotifierProvider(
        create: (_) => Cart(),
        child: MaterialApp(
          home: BaseLayout(
              child: Container(
            height: 100,
          )),
        ),
      ));
      await tester.pumpAndSettle();

      await tester.ensureVisible(find.byIcon(Icons.menu));
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      expect(find.text("Home"), findsOne);
      expect(find.text("Shop"), findsOne);
      expect(find.text("Sale"), findsOne);
      expect(find.text("About"), findsOne);

      await tester.tap(find.text("Shop"));
      await tester.pumpAndSettle();

      for (Collection collection
          in CollectionRepository.instance.getCollectionList()) {
        expect(find.text(collection.title), findsOne);
      }
    });
  });
}
