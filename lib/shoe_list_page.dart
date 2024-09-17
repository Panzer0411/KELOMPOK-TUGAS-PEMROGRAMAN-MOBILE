import 'package:flutter/material.dart';

void main() {
  runApp(const ShoeStoreApp());
}

class ShoeStoreApp extends StatelessWidget {
  const ShoeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Sepatu',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ShoeListPage(),
    );
  }
}

class ShoeListPage extends StatefulWidget {
  const ShoeListPage({super.key});

  @override
  _ShoeListPageState createState() => _ShoeListPageState();
}

class _ShoeListPageState extends State<ShoeListPage> {
  // Daftar produk sepatu
  final List<Map<String, dynamic>> shoes = [
    {'name': 'Nike Air Max', 'price': 1500000},
    {'name': 'Adidas Ultraboost', 'price': 1700000},
    {'name': 'Puma Suede', 'price': 1300000},
    {'name': 'Converse All Star', 'price': 1200000},
    {'name': 'Vans Old Skool', 'price': 1100000},
  ];

  // Daftar barang di keranjang
  List<Map<String, dynamic>> cartItems = [];

  // Menambahkan barang ke keranjang
  void addToCart(Map<String, dynamic> shoe) {
    setState(() {
      cartItems.add(shoe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Sepatu'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cartItems: cartItems),
                ),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: shoes.length,
        itemBuilder: (context, index) {
          final shoe = shoes[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShoeDetailPage(
                    shoe: shoe,
                    addToCart: addToCart,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      shoe['name'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Rp ${shoe['price']}',
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ShoeDetailPage extends StatelessWidget {
  final Map<String, dynamic> shoe;
  final Function(Map<String, dynamic>) addToCart;

  const ShoeDetailPage({super.key, required this.shoe, required this.addToCart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shoe['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              shoe['name'],
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Rp ${shoe['price']}',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                addToCart(shoe); // Menambahkan barang ke keranjang
                Navigator.pop(context); // Kembali ke halaman daftar
              },
              child: const Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({super.key, required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text('Keranjang belanja kosong'))
          : ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Rp ${item['price']}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // Logika untuk menghapus item dari keranjang
                      },
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // Logika untuk checkout
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CheckoutPage()),
            );
          },
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Total Pembayaran: Rp 1500000',
              style: TextStyle(fontSize: 20),
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
