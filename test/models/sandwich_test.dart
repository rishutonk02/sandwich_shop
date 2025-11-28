import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich Model Tests', () {
    test('Name getter returns correct human-readable name', () {
      final sandwich = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );
      expect(sandwich.name, 'Veggie Delight');
    });

    test('Image getter returns correct path for six-inch sandwich', () {
      final sandwich = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      expect(sandwich.image, 'assets/images/chickenTeriyaki_six_inch.png');
    });

    test('Image getter returns correct path for footlong sandwich', () {
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );
      expect(sandwich.image, 'assets/images/tunaMelt_footlong.png');
    });
  });
}
