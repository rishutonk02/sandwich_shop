import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/cart_screen.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('CartScreen widget tests', () {
    testWidgets('shows empty cart message', (tester) async {
      final cart = Cart();

      await tester.pumpWidget(MaterialApp(home: CartScreen(cart: cart)));

      expect(find.text('Your cart is empty'), findsOneWidget);
    });

    testWidgets('displays items in cart with correct details', (tester) async {
      final cart = Cart();
      cart.add(
          Sandwich(
            type: SandwichType.veggieDelight,
            isFootlong: true,
            breadType: BreadType.white,
          ),
          quantity: 2);

      await tester.pumpWidget(MaterialApp(home: CartScreen(cart: cart)));

      // Item name and size
      expect(find.textContaining('Veggie Delight'), findsOneWidget);
      expect(find.textContaining('Footlong'), findsOneWidget);

      // Quantity
      expect(find.textContaining('Qty: 2'), findsOneWidget);

      // Total price
      expect(find.textContaining('Total:'), findsOneWidget);
    });
  });
}
