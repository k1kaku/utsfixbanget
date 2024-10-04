import 'package:flutter/material.dart';
import 'cart_page.dart'; // Halaman Keranjang Belanja
<<<<<<< HEAD
import 'wishlist_page.dart'; // Halaman Wishlist
import 'home_page.dart'; // Halaman Utama
=======
import 'product_detail.dart'; // Halaman Detail Produk
import 'models/product.dart'; // Model Produk
import 'wishlist_page.dart'; // Halaman Wishlist
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
<<<<<<< HEAD
      title: 'Merch Kpop',
=======
      title: 'Toko Sembako',
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}
<<<<<<< HEAD
=======

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data produk
    final List<Product> products = [
      Product(title: 'Bayam', price: 2000, imageUrl: 'https://via.placeholder.com/150', description: 'Bayam segar satu ikat.'),
      Product(title: 'Alpukat', price: 4000, imageUrl: 'https://via.placeholder.com/150', description: 'Alpukat segar 1 kg.'),
      Product(title: 'Jagung', price: 9500, imageUrl: 'https://via.placeholder.com/150', description: 'Jagung manis 1 bungkus.'),
      Product(title: 'Kiwi', price: 4500, imageUrl: 'https://via.placeholder.com/150', description: 'Kiwi segar 1 kg.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Buah & Sayur'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const WishlistPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetail(product: product),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.network(product.imageUrl, height: 120, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Rp ${product.price}', style: const TextStyle(color: Colors.green)),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Logika untuk menambahkan ke keranjang
                      },
                      child: const Text('Beli'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
