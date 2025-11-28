import 'package:flutter/material.dart';

/// Single clean app that satisfies the tests in `test/widget_test.dart`.
void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Sandwich Shop App',
      home: OrderScreen(maxQuantity: 5),
    );
  }
}

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 5});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;
  final String _sandwichType = 'Footlong';

  void _increase() {
    if (_quantity < widget.maxQuantity) setState(() => _quantity++);
  }

  void _decrease() {
    if (_quantity > 0) setState(() => _quantity--);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sandwich Counter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OrderItemDisplay(_quantity, _sandwichType),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: _decrease, child: const Text('Remove')),
                const SizedBox(width: 12),
                ElevatedButton(onPressed: _increase, child: const Text('Add')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String sandwichType;

  const OrderItemDisplay(this.quantity, this.sandwichType, {super.key});

  @override
  Widget build(BuildContext context) {
    // Produce exact strings expected by tests:
    // - quantity == 0 -> '0 Footlong sandwich(es): '
    // - quantity > 0  -> 'N Footlong sandwich(es): 🥪🥪...'
    final String emojiString =
        quantity > 0 ? List.filled(quantity, '🥪').join() : '';
    final String text = '$quantity $sandwichType sandwich(es): ' + emojiString;
    return Text(
      text,
      style: const TextStyle(fontSize: 16),
      textAlign: TextAlign.center,
    );
  }
}
