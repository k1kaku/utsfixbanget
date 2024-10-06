import 'package:flutter/material.dart';
import 'order_review_page.dart';
import 'models/product.dart';
import 'cart.dart'; // Tambahkan import Cart

class ProductDetail extends StatefulWidget {
  final Product product;
  final Cart cart;

  const ProductDetail({Key? key, required this.product, required this.cart}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isInWishlist = false; // Status wishlist
  bool isInCart = false; // Status keranjang

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
            // Gambar Produk dengan Efek Rounded
            Center(
              child: Hero(
                tag: widget.product.title,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset(widget.product.imageUrl, height: 220, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nama dan Harga Produk
            Text(
              widget.product.title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Rp ${widget.product.price}',
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),

            // Bintang Rating Produk dengan warna hitam
            _buildRatingStars(4.5),
            const SizedBox(height: 8),

            // Informasi Stok Produk
            _buildStockInfo(10),
            const SizedBox(height: 8),

            // Deskripsi Produk
            _buildProductDescription(widget.product.description),
            const Spacer(),

            // Tombol Wishlist, Cart, dan Beli
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildWishlistButton(),
                _buildCartButton(),
                _buildPurchaseButton(context),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Tombol "Beli Sekarang"
  Widget _buildPurchaseButton(BuildContext context) {
    return Expanded(
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
                products: [widget.product], // Produk dikirim sebagai list
                quantities: [1], // Kuantitas dalam bentuk list
                cart: widget.cart, // Kirimkan instance Cart ke OrderReviewPage
                shouldClearCart: false, // Jangan bersihkan keranjang setelah pembayaran
                isDirectPurchase: true, // Tampilkan sebagai pembelian langsung, tanpa masuk ke keranjang
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

  // Tombol Wishlist (hanya ikon)
  Widget _buildWishlistButton() {
    return IconButton(
      icon: Icon(isInWishlist ? Icons.favorite : Icons.favorite_border, color: isInWishlist ? Colors.red : Colors.black),
      onPressed: () {
        setState(() {
          isInWishlist = !isInWishlist; // Ubah status wishlist
          if (isInWishlist) {
            // Tambah ke wishlist
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.product.title} ditambahkan ke Wishlist')));
          } else {
            // Hapus dari wishlist
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.product.title} dihapus dari Wishlist')));
          }
        });
      },
    );
  }

  // Tombol Cart (hanya ikon)
  Widget _buildCartButton() {
    return IconButton(
      icon: Icon(isInCart ? Icons.shopping_cart : Icons.shopping_cart_outlined, color: isInCart ? Colors.blue : Colors.black),
      onPressed: () {
        setState(() {
          isInCart = !isInCart; // Ubah status keranjang
          if (isInCart) {
            // Tambah ke keranjang
            widget.cart.addToCart(widget.product);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.product.title} ditambahkan ke Keranjang')));
          } else {
            // Hapus dari keranjang
            widget.cart.removeFromCart(widget.product);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${widget.product.title} dihapus dari Keranjang')));
          }
        });
      },
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
