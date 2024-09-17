// cart_page.dart
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(int) removeFromCart;

  const CartPage({
    super.key,
    required this.cartItems,
    required this.removeFromCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang'),
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Keranjang kosong'),
            )
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final shoe = cartItems[index];
                return ListTile(
                  title: Text(shoe['name']),
                  subtitle: Text('Rp ${shoe['price']}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle),
                    onPressed: () {
                      removeFromCart(index);
                    },
                  ),
                );
              },
            ),
    );
  }
}
