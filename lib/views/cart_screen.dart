import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/cart.dart';

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late final TextEditingController _notesController;

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController(text: widget.cart.orderNotes);

    _notesController.addListener(() {
      widget.cart.orderNotes = _notesController.text;
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = widget.cart;
    final String totalPrice = cart.totalPrice.toStringAsFixed(2);

    return Scaffold(
      appBar: AppBar(title: const Text('Your Order Cart')),
      body: Column(
        children: [
          Expanded(
            child: cart.itemCount == 0
                ? const Center(
                    child: Text(
                      'Your cart is empty',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final sandwich = cart.items.keys.elementAt(index);
                      final quantity = cart.items.values.elementAt(index);

                      String sizeText = sandwich.isFootlong
                          ? 'Footlong'
                          : 'Six-inch';
                      String toastedText = sandwich.isToasted
                          ? 'Toasted'
                          : 'Untoasted'; // NEW

                      return ListTile(
                        leading: Image.asset(
                          sandwich.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.fastfood),
                        ),
                        title: Text(
                          sandwich.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '$sizeText on ${sandwich.breadType.name} bread ($toastedText)',
                        ),
                        trailing: Text(
                          'Qty: $quantity',
                          style: const TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _notesController,
              decoration: const InputDecoration(
                labelText: 'Order Notes (e.g., "No onions", "Extra napkins")',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5.0,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$$totalPrice',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: cart.totalQuantity > 0
                      ? () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Order Submitted! Notes: ${cart.orderNotes}',
                              ),
                            ),
                          );
                        }
                      : null,
                  label: const Text('Place Order'),
                  icon: const Icon(Icons.payment),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
