import 'package:flutter/material.dart';
import 'order_review_page.dart';
import 'cart.dart'; // Pastikan file Cart diimport
import 'models/product.dart';

class CartPage extends StatelessWidget {
  final Cart cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
      body: cart.items.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_cart, size: 100),
            Text('Keranjang Belanja Anda Kosong', style: TextStyle(fontSize: 20)),
          ],
        ),
      )
          : ListView.builder(
        itemCount: cart.items.length,
        itemBuilder: (context, index) {
          final product = cart.items[index];
          return ListTile(
            leading: Image.asset(product.imageUrl, width: 50, height: 50),
            title: Text(product.title),
            subtitle: Text('Jumlah: ${product.quantity}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Rp ${product.price * product.quantity}'),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    // Menghapus produk dari keranjang
                    cart.removeFromCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${product.title} telah dihapus dari keranjang')),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: cart.items.isNotEmpty
          ? Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Harga: Rp ${cart.totalPrice}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderReviewPage(
                      products: cart.items,  // Mengirimkan item keranjang ke OrderReviewPage
                      quantities: cart.items.map((e) => e.quantity).toList(), // Kuantitas untuk setiap item
                      cart: cart,            // Mengirimkan instance Cart
                      shouldClearCart: true, // Karena ini melalui keranjang, bersihkan setelah pembayaran
                      isDirectPurchase: false, // Bukan pembelian langsung
                    ),
                  ),
                );
              },
              child: const Text('Checkout'),
            ),
          ],
        ),
      )
          : null,
    );
  }
}
