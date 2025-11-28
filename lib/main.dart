import 'package:flutter/material.dart';

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

enum SandwichSize { footlong, sixInch }

enum BreadType { white, wholegrain, ciabatta }

class OrderScreen extends StatefulWidget {
  final int maxQuantity;

  const OrderScreen({super.key, this.maxQuantity = 5});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int _quantity = 0;

  SandwichSize _size = SandwichSize.footlong;
  BreadType _bread = BreadType.white;

  final TextEditingController _noteController = TextEditingController();

  void _increase() {
    if (_quantity < widget.maxQuantity) {
      setState(() => _quantity++);
    }
  }

  void _decrease() {
    if (_quantity > 0) {
      setState(() => _quantity--);
    }
  }

  String _sizeLabel() =>
      _size == SandwichSize.footlong ? 'Footlong' : 'Six-inch';

  String _breadLabel() {
    switch (_bread) {
      case BreadType.white:
        return 'White';
      case BreadType.wholegrain:
        return 'Wholegrain';
      case BreadType.ciabatta:
        return 'Ciabatta';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canIncrease = _quantity < widget.maxQuantity;
    final bool canDecrease = _quantity > 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Sandwich Counter')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OrderItemDisplay(
              quantity: _quantity,
              size: _sizeLabel(),
              bread: _breadLabel(),
              note: _noteController.text,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<SandwichSize>(
                  value: _size,
                  onChanged: (newVal) => setState(() => _size = newVal!),
                  items: SandwichSize.values
                      .map((s) => DropdownMenuItem(
                            value: s,
                            child: Text(s == SandwichSize.footlong
                                ? 'Footlong'
                                : 'Six-inch'),
                          ))
                      .toList(),
                ),
                const SizedBox(width: 16),
                DropdownButton<BreadType>(
                  value: _bread,
                  onChanged: (newVal) => setState(() => _bread = newVal!),
                  items: BreadType.values
                      .map((b) => DropdownMenuItem(
                            value: b,
                            child: Text(_breadLabelFor(b)),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StyledButton(
                  label: 'Remove',
                  icon: Icons.remove,
                  background: Colors.grey.shade700,
                  onPressed: canDecrease ? _decrease : null,
                ),
                const SizedBox(width: 12),
                StyledButton(
                  label: 'Add',
                  icon: Icons.add,
                  background: Colors.green,
                  onPressed: canIncrease ? _increase : null,
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Order notes',
                hintText: 'e.g. “no onions”',
              ),
              onChanged: (_) => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }

  String _breadLabelFor(BreadType b) {
    switch (b) {
      case BreadType.white:
        return 'White';
      case BreadType.wholegrain:
        return 'Wholegrain';
      case BreadType.ciabatta:
        return 'Ciabatta';
    }
  }
}

class StyledButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;
  final Color background;

  const StyledButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.background,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      ),
    );
  }
}

class OrderItemDisplay extends StatelessWidget {
  final int quantity;
  final String size;
  final String bread;
  final String note;

  const OrderItemDisplay({
    super.key,
    required this.quantity,
    required this.size,
    required this.bread,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    final String emoji = quantity > 0 ? List.filled(quantity, '🥪').join() : '';

    return Card(
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$quantity × $size sandwich(es)',
              style: const TextStyle(fontSize: 18),
            ),
            Text('Bread: $bread'),
            const SizedBox(height: 6),
            Text('Note: ${note.isEmpty ? "—" : note}'),
            const SizedBox(height: 6),
            Text(emoji),
          ],
        ),
      ),
    );
  }
}
