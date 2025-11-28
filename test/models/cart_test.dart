import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/models/cart.dart';

// Helper sandwiches for testing
final sixInchVeggie = Sandwich(
  type: SandwichType.veggieDelight,
  isFootlong: false, // Six-inch
  breadType: BreadType.white,
);

final footlongTuna = Sandwich(
  type: SandwichType.tunaMelt,
  isFootlong: true, // Footlong
  breadType: BreadType.wheat,
);

void main() {
  group('Cart Model Tests', () {
    test('Cart starts empty', () {
      final cart = Cart();
      expect(cart.itemCount, 0);
      expect(cart.totalPrice, 0.0);
      expect(cart.totalQuantity, 0);
    });

    test('Adding a single item works correctly', () {
      final cart = Cart();
      cart.add(sixInchVeggie, quantity: 1);

      expect(cart.itemCount, 1);
      // Assuming PricingRepository's logic: 1 six-inch item price
      expect(cart.totalPrice > 0.0, true);
      expect(cart.totalQuantity, 1);
    });

    test('Adding multiple of the same item increases quantity and price', () {
      final cart = Cart();
      cart.add(sixInchVeggie, quantity: 1);
      cart.add(sixInchVeggie, quantity: 2); // Should update the quantity

      // Due to the simple Map key, this may result in 1 item with quantity 3
      // IF Sandwich implements == and hashCode. Without it, it's 2 distinct entries.
      // Based on the provided Cart code, it will merge them if the object identity is the same.
      // Assuming for now that the object is added, and the simple Map is used:
      expect(cart.itemCount, 1); // 1 key
      expect(cart.items[sixInchVeggie], 3); // Quantity is 3
    });

    test('Adding different items works correctly and calculates total price',
        () {
      final cart = Cart();
      cart.add(sixInchVeggie, quantity: 1);
      cart.add(footlongTuna, quantity: 1);

      expect(cart.itemCount, 2);
      expect(cart.totalQuantity, 2);
      // Total price should be sum of 1 six-inch + 1 footlong price
      expect(cart.totalPrice > 0.0, true);
    });
  });
}
