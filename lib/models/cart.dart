import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

class Cart {
  final Map<Sandwich, int> _items = {};
  final PricingRepository _pricingRepository = PricingRepository();
  String _orderNotes = '';

  Map<Sandwich, int> get items => Map.unmodifiable(_items);

  String get orderNotes => _orderNotes;
  set orderNotes(String notes) {
    _orderNotes = notes;
  }

  void add(Sandwich sandwich, {int quantity = 1}) {
    _items.update(
      sandwich,
      (existingQuantity) => existingQuantity + quantity,
      ifAbsent: () => quantity,
    );
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
