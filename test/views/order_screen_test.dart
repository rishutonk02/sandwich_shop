import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/order_screen.dart';

void main() {
  group('OrderScreen widget tests', () {
    testWidgets('displays initial cart summary', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OrderScreen()));

      expect(find.textContaining('Cart:'), findsOneWidget);
      expect(find.textContaining('0 item'), findsOneWidget);
    });

    testWidgets('adds sandwich to cart and shows confirmation message',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OrderScreen()));

      // Tap Add to Cart
      await tester.tap(find.text('Add to Cart'));
      await tester.pump();

      // Confirmation message should appear
      expect(find.textContaining('Added'), findsOneWidget);

      // Cart summary should update
      expect(find.textContaining('1 item'), findsOneWidget);
    });

    testWidgets('quantity controls increase and decrease', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: OrderScreen()));

      // Initial quantity is 1
      expect(find.text('1'), findsOneWidget);

      // Increase
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      // Decrease
      await tester.tap(find.byIcon(Icons.remove));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
  });
}
