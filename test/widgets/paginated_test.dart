import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/widgets/paginated.dart';

void main() {
  testWidgets("check pagination works", (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
            body: Paginated(perPage: 2, children: [
          Text("One"),
          Text("Two"),
          Text("Three"),
          Text("Four"),
          Text("Five")
        ])),
      ),
    );
    await tester.pumpAndSettle();

    
  });
}
