import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/slideshow_widget.dart';

void main() {
  testWidgets("test if buttons work", (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: Scaffold(
        body: Slideshow(imagePaths: [
          "assets/images/collections/accessories.png",
          "assets/images/collections/clothing.png",
          "assets/images/collections/drinkware.png"
        ]),
      ),
    ));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pumpAndSettle();

    expect(find.image(Image.asset("assets/images/collections/clothing.png").image), findsOne);

    await tester.tap(find.byIcon(Icons.arrow_left));
    await tester.pumpAndSettle();

    expect(find.image(Image.asset("assets/images/collections/accessories.png").image), findsOne);

  });
}
