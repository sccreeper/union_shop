import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/collection_card.dart';

void main() {
  testWidgets("test collection card displays text properly", (tester) async {
    await tester.pumpWidget(Directionality(
      textDirection: TextDirection.ltr,
      child:
        CollectionCard(
            title: "Test Collection",
            id: "test",
            backgroundImage: Image.asset("assets/images/collections/clothing.png").image),
    ));
    await tester.pumpAndSettle();

    expect(find.text("Test Collection"), findsOne);
  });
}
