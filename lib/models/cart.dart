import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart'; // Import to use pricing logic

class Cart {
  // Map to store Sandwich as key and its quantity as value
  final Map<Sandwich, int> _items = {};
  final PricingRepository _pricingRepository = PricingRepository();

  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  // Add a sandwich to the cart or increase its quantity
  void add(Sandwich sandwich, {int quantity = 1}) {
    // Note: To correctly aggregate the same sandwich,
    // you would typically need to implement equality (== and hashCode) on Sandwich.
    // For this simple exercise, we'll treat two Sandwich objects as different,
    // even if their properties are the same, unless you want to add this complexity.
    // Since the prompt suggests an add(sandwich, quantity) signature,
    // we'll simply add the new sandwich/quantity.
    _items.update(
      sandwich,
      (existingQuantity) => existingQuantity + quantity,
      ifAbsent: () => quantity,
    );
  }

  // Calculate the total price of all items in the cart
  double get totalPrice {
    double total = 0.0;
    _items.forEach((sandwich, quantity) {
      // Pricing logic uses quantity and size (isFootlong)
      total += _pricingRepository.calculatePrice(quantity, sandwich.isFootlong);
    });
    return total;
  }

  // Get the total number of distinct items (pairs of sandwich/quantity)
  int get itemCount => _items.length;

  // Get the total number of sandwiches (sum of all quantities)
  int get totalQuantity {
    return _items.values.fold(0, (sum, quantity) => sum + quantity);
  }
}
