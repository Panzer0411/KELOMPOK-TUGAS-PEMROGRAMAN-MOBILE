// shoe_detail_page.dart
import 'package:flutter/material.dart';

class ShoeDetailPage extends StatelessWidget {
  final Map<String, dynamic> shoe;
  final Function(Map<String, dynamic>) addToCart;

  const ShoeDetailPage({
    super.key,
    required this.shoe,
    required this.addToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(shoe['name'])),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              shoe['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Rp ${shoe['price']}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            const Text('Deskripsi Produk:'),
            const Text(
              'Ini adalah sepatu berkualitas tinggi dengan desain yang trendi dan bahan yang nyaman digunakan dalam berbagai aktivitas.',
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                addToCart(shoe); // Menambahkan ke keranjang
                Navigator.pop(context); // Kembali ke halaman sebelumnya
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sepatu berhasil ditambahkan ke keranjang!'),
                  ),
                );
              },
              child: const Text('Tambahkan ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}
