import 'package:flutter/material.dart';
import 'order_review_page.dart';
import 'models/product.dart';
import 'cart.dart'; // Tambahkan import Cart

class ProductDetail extends StatelessWidget {
  final Product product;
  final Cart cart;

  const ProductDetail({Key? key, required this.product, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
            // Gambar Produk
            Center(
              child: Hero(
                tag: product.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(product.imageUrl, height: 220, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama dan Harga Produk
            Text(
              product.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${product.price}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Bintang Rating Produk
            _buildRatingStars(4.5),
            const SizedBox(height: 8),

            // Informasi Stok Produk
            _buildStockInfo(10),
            const SizedBox(height: 8),

            // Deskripsi Produk
            _buildProductDescription(product.description),
            const Spacer(),

            // Tombol Beli
            _buildPurchaseButton(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Tombol "Beli Sekarang"
  Widget _buildPurchaseButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.green,
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderReviewPage(
                products: [product],
                quantities: [1],
                cart: cart,
                shouldClearCart: false,
                isDirectPurchase: true,
              ),
            ),
          );
        },
        child: const Text(
          'Beli Sekarang',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // Widget Bintang Rating
  Widget _buildRatingStars(double rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.black, // Warna bintang diubah menjadi hitam
        );
      }),
    );
  }

  // Widget Stok Produk
  Widget _buildStockInfo(int stockCount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Text(
        stockCount > 0 ? 'In Stock: $stockCount items' : 'Out of Stock',
        style: TextStyle(
          color: stockCount > 0 ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Widget Deskripsi Produk
  Widget _buildProductDescription(String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: Text(
        description,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black54,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
