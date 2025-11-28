import 'package:flutter_test/flutter_test.dart' show expect, group, test;
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    final repository = PricingRepository();

    test('calculates price for a single six-inch sandwich', () {
      final price =
          repository.calculateTotalPrice(quantity: 1, isFootlong: false);
      expect(price, 7.0);
    });

    test('calculates price for multiple footlong sandwiches', () {
      // 2 * 11.0 = 22.0
      final price =
          repository.calculateTotalPrice(quantity: 2, isFootlong: true);
      expect(price, 22.0);
    });

    test('calculates price for zero quantity', () {
      final price =
          repository.calculateTotalPrice(quantity: 0, isFootlong: false);
      expect(price, 0.0);
    });
  });
}
