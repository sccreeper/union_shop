import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/collections_page.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();
  });

  group("collection page tests", () {
    testWidgets("page layout", (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Cart(),
          child: const MaterialApp(
            home: BaseLayout(child: CollectionsPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.textContaining("Collections"), findsOne);
    });

    testWidgets("page data", (tester) async {
      List<Collection> collections =
          CollectionRepository.instance.getCollectionList();

      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Cart(),
          child: const MaterialApp(
            home: BaseLayout(child: CollectionsPage()),
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (Collection collection in collections) {
        await tester.ensureVisible(find.textContaining(collection.title));
        await tester.pumpAndSettle();
        expect(find.textContaining(collection.title), findsOne);
      }
    });
  });
}
