import 'package:flutter/material.dart';
import 'package:sandwich_shop/views/app_styles.dart';
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
    _notesController = TextEditingController(text: widget.cart.notes);
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart', style: heading1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: items.isEmpty
            ? const Center(child: Text('Your cart is empty', style: normalText))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final it = items[index];
                        final sandwich = it.sandwich;
                        final sizeText =
                            sandwich.isFootlong ? 'Footlong' : 'Six-inch';

                        return Card(
                          child: ListTile(
                            title: Text('${sandwich.name} • $sizeText',
                                style: normalText),
                            subtitle: Text(
                              'Bread: ${sandwich.breadType.name} • Qty: ${it.quantity}',
                              style: normalText,
                            ),
                            trailing: Text(
                              '£${widget.cart.calculatePrice(it.sandwich, it.quantity).toStringAsFixed(2)}',
                              style: heading2,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Total: £${widget.cart.totalPrice.toStringAsFixed(2)}',
                    style: heading2,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
      ),
    );
  }
}
