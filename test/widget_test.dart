import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart'; // change to your correct package name

void main() {
  testWidgets('App loads with quantity 0', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    expect(find.text('0 × Footlong sandwich(es)'), findsOneWidget);
  });

  testWidgets('Add button increments quantity', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pump();

    expect(find.text('1 × Footlong sandwich(es)'), findsOneWidget);
  });

  testWidgets('Remove button decrements quantity', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    await tester.tap(find.widgetWithText(ElevatedButton, 'Add'));
    await tester.pump();
    await tester.tap(find.widgetWithText(ElevatedButton, 'Remove'));
    await tester.pump();

    expect(find.text('0 × Footlong sandwich(es)'), findsOneWidget);
  });

  testWidgets('Notes update display', (WidgetTester tester) async {
    await tester.pumpWidget(const App());

    await tester.enterText(find.byType(TextField), 'extra cheese');
    await tester.pump();

    expect(find.text('Note: extra cheese'), findsOneWidget);
  });
}
