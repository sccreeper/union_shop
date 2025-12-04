import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:union_shop/views/error_page.dart';

const String errMsgString = "Test Error Message";

void main() {
  testWidgets("error page shows messsage", (tester) async {
    await tester.pumpWidget(const MaterialApp(
        home: Scaffold(
          body: ErrorPage(errorMessage: errMsgString,),
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text(errMsgString), findsOne);
  });
}