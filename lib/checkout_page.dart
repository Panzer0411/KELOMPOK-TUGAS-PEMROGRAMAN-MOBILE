import 'package:flutter/material.dart';

class CheckoutPage extends StatelessWidget {
  // Variabel untuk menyimpan data total harga dan barang di keranjang
  final List<Map<String, dynamic>> cartItems;
  final int totalPrice;

  const CheckoutPage({super.key, required this.cartItems, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Pembayaran: Rp $totalPrice',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Nama',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Alamat Pengiriman',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logika penyelesaian checkout
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Pembelian berhasil!')),
                );
                // Setelah pembelian berhasil, kembali ke halaman utama
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Selesaikan Pembelian'),
            ),
          ],
        ),
      ),
    );
  }
}
