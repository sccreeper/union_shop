import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/header_slideshow.dart';

void main() {
  group("header slideshow tests", () {
    testWidgets("check buttons work", (tester) async {
      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: HeaderSlideshow(
            slideshowItems: [
              HeaderSlideshowItem(
                  title: "Slide 1",
                  subtitle: "Sub 1",
                  buttonText: "Button 1",
                  route: "/1",
                  imagePath: "assets/images/collections/accessories.png"),
              HeaderSlideshowItem(
                  title: "Slide 2",
                  subtitle: "Sub 2",
                  buttonText: "Button 2",
                  route: "/2",
                  imagePath: "assets/images/collections/clothing.png")
            ],
          ),
        ),
      ));

      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.arrow_right));
      await tester.pumpAndSettle();

      expect(find.text("Slide 2"), findsOne);
      expect(find.text("Sub 2"), findsOne);
      expect(find.text("Button 2"), findsOne);

      await tester.tap(find.byIcon(Icons.arrow_left));
      await tester.pumpAndSettle();

      expect(find.text("Slide 1"), findsOne);
      expect(find.text("Sub 1"), findsOne);
      expect(find.text("Button 1"), findsOne);
    });
  });
}
