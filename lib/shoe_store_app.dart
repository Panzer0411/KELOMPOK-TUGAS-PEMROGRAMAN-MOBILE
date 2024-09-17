// shoe_store_app.dart
import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'shoe_detail_page.dart';

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
  final List<Map<String, dynamic>> shoes = [
    {'name': 'Nike Air Max', 'price': 1500000},
    {'name': 'Adidas Ultraboost', 'price': 1700000},
    {'name': 'Puma Suede', 'price': 1300000},
    {'name': 'Converse All Star', 'price': 1200000},
    {'name': 'Vans Old Skool', 'price': 1100000},
  ];

  // Daftar barang di keranjang
  List<Map<String, dynamic>> cartItems = [];

  void addToCart(Map<String, dynamic> shoe) {
    setState(() {
      cartItems.add(shoe);
    });
  }

  void removeFromCart(int index) {
    setState(() {
      cartItems.removeAt(index);
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
                  builder: (context) => CartPage(
                    cartItems: cartItems,
                    removeFromCart: removeFromCart,
                  ),
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
