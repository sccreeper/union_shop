import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/about.dart';

void main() {
  group("about tests", () {
    testWidgets("test about layout", (tester) async {

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: AboutPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text("About Us"), findsOne);
      expect(find.textContaining("Union Shop"), findsOne);


    });
  });
}