import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class CartEntry {
  final Sandwich sandwich;
  int quantity;

  CartEntry({required this.sandwich, required this.quantity});
}

class Cart {
  final Map<Sandwich, CartEntry> _items = {};
  String notes = '';

  List<CartEntry> get items => _items.values.toList();

  void add(Sandwich sandwich, {int quantity = 1}) {
    if (_items.containsKey(sandwich)) {
      _items[sandwich]!.quantity += quantity;
    } else {
      _items[sandwich] = CartEntry(sandwich: sandwich, quantity: quantity);
    }
  }

  double calculatePrice(Sandwich sandwich, int quantity) {
    return PricingRepository.calculatePrice(
      quantity: quantity,
      isFootlong: sandwich.isFootlong,
    );
  }

  int get totalQuantity {
    return _items.values.fold(0, (sum, entry) => sum + entry.quantity);
  }

  double get totalPrice {
    double total = 0.0;
    for (final entry in _items.values) {
      total += calculatePrice(entry.sandwich, entry.quantity);
    }
    return total;
  }

  void updateNotes(String newNotes) {
    notes = newNotes;
  }
}
