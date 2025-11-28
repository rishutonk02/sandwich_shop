import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  final Map<Sandwich, int> _items = {};
  final PricingRepository _pricingRepository = PricingRepository();
  String orderNotes = '';

  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  void add(Sandwich sandwich, {int quantity = 1}) {
    _items.update(
      sandwich,
      (existingQuantity) => existingQuantity + quantity,
      ifAbsent: () => quantity,
    );
  }

  /// Remove [quantity] of [sandwich] from the cart.
  ///
  /// If the sandwich is not present, returns false. If the quantity to
  /// remove is greater than or equal to the existing quantity the item is
  /// removed entirely and the method returns true. Otherwise the quantity is
  /// decremented and returns true.
  bool remove(Sandwich sandwich, {int quantity = 1}) {
    if (!_items.containsKey(sandwich)) return false;

    final current = _items[sandwich]!;
    if (quantity >= current) {
      _items.remove(sandwich);
    } else {
      _items[sandwich] = current - quantity;
    }
    return true;
  }

  /// Remove all instances of [sandwich] from the cart.
  void removeAll(Sandwich sandwich) {
    _items.remove(sandwich);
  }

  /// Clear the cart entirely.
  void clear() {
    _items.clear();
  }

  double get totalPrice {
    double total = 0.0;
    _items.forEach((sandwich, quantity) {
      total += _pricingRepository.calculatePrice(quantity, sandwich.isFootlong);
    });
    return total;
  }

  int get itemCount => _items.length;

  int get totalQuantity {
    return _items.values.fold(0, (sum, quantity) => sum + quantity);
  }
}
