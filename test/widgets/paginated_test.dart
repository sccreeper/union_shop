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

    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pumpAndSettle();

    expect(find.text("Page 2 of 3"), findsOne);
    expect(find.text("Three"), findsOne);
    expect(find.text("Four"), findsOne);

    await tester.tap(find.byIcon(Icons.arrow_left));
    await tester.pumpAndSettle();

    expect(find.text("Page 1 of 3"), findsOne);
    expect(find.text("One"), findsOne);
    expect(find.text("Two"), findsOne);

    await tester.tap(find.byIcon(Icons.arrow_left));
    await tester.pumpAndSettle();

    expect(find.text("Page 3 of 3"), findsOne);
    expect(find.text("Five"), findsOne);

    await tester.tap(find.byIcon(Icons.arrow_right));
    await tester.pumpAndSettle();
    
    expect(find.text("Page 1 of 3"), findsOne);
    expect(find.text("One"), findsOne);
    expect(find.text("Two"), findsOne);
  });
}
