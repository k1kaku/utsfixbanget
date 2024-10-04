import 'package:flutter/material.dart';
import 'order_review_page.dart';
import 'models/product.dart';
import 'cart.dart'; // Tambahkan import Cart

class ProductDetail extends StatelessWidget {
  final Product product;
  final Cart cart; // Tambahkan cart sebagai parameter

  const ProductDetail({Key? key, required this.product, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              // Logika untuk menambahkan ke wishlist
            },
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16.0),
            Center(
              child: Hero(
                tag: product.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(product.imageUrl, height: 180, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${product.price}',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.green,
              ),
            ),
            const Spacer(),
            // Tombol Beli dengan Desain Modern
            _buildPurchaseButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.green, // Ganti dengan warna tombol yang diinginkan
        ),
        onPressed: () {
          // Navigasi ke OrderReviewPage TANPA menambahkan produk ke keranjang
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderReviewPage(
                products: [product],  // Produk dikirim sebagai list
                quantities: [1],      // Kuantitas dalam bentuk list
                cart: cart,           // Kirimkan instance Cart ke OrderReviewPage
                shouldClearCart: false, // Jangan bersihkan keranjang setelah pembayaran
                isDirectPurchase: true, // Tampilkan sebagai pembelian langsung, tanpa masuk ke keranjang
              ),
            ),
          );
        },
        child: const Text(
          'Beli Sekarang',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
