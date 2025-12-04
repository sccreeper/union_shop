import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:union_shop/layouts/base_layout.dart';
import 'package:union_shop/models/cart.dart';
import 'package:union_shop/models/collection.dart';
import 'package:union_shop/repositories/collection_repository.dart';
import 'package:union_shop/repositories/product_repository.dart';
import 'package:union_shop/views/collection_page.dart';
import 'package:union_shop/widgets/product_card_widget.dart';

void main() {
  late Collection drinkwareCollection;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();

    await ProductRepository.instance.loadProducts();
    await CollectionRepository.instance.loadCollections();

    drinkwareCollection =
        CollectionRepository.instance.getCollection("drinkware")!;
  });

  group("collection page tests", () {
    testWidgets("page layout", (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Cart(),
          child: MaterialApp(
            home: BaseLayout(
                child: CollectionPage(
              collection: drinkwareCollection,
            )),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(drinkwareCollection.title), findsOne);
      expect(find.textContaining("2 Products"), findsOne);
    });

    testWidgets("filtering", (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Cart(),
          child: MaterialApp(
            home: BaseLayout(
                child: CollectionPage(collection: drinkwareCollection)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("2 Products"), findsOne);

      await tester.tap(find.byKey(Key("filter-by")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("onSale"));
      await tester.pumpAndSettle();

      expect(find.text("1 Products"), findsOne);
    });

    testWidgets("sorting", (tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => Cart(),
          child: MaterialApp(
            home: BaseLayout(
                child: CollectionPage(collection: drinkwareCollection)),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text("2 Products"), findsOne);

      await tester.tap(find.byKey(Key("sort-by")));
      await tester.pumpAndSettle();

      await tester.tap(find.text("priceHighLow"));
      await tester.pumpAndSettle();

      ProductCard productCard1 = tester.widgetList<ProductCard>(find.byType(ProductCard)).elementAt(0);
      ProductCard productCard2 = tester.widgetList<ProductCard>(find.byType(ProductCard)).elementAt(1);

      expect(productCard1.product.truePrice > productCard2.product.truePrice, true);

    });
  });
}
