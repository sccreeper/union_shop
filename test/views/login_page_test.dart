import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/login_page.dart';

void main() {
  testWidgets("login page test", (tester) async {

      await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: LoginPage(),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text("Email"), findsOne);
      expect(find.text("Password"), findsOne);
      expect(find.text("Login"), findsOne);

  });
}