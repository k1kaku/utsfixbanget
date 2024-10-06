import 'package:flutter/material.dart';
import 'order_review_page.dart'; // Import halaman OrderReview
import 'models/product.dart';
import 'cart.dart';

class CartPage extends StatefulWidget {
  final Cart cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.cart.items.fold(0, (sum, item) => sum + (item.price * item.quantity)); // Hitung total harga

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.white, // Background putih
        child: widget.cart.items.isEmpty
            ? const Center(
          child: Text(
            'Keranjang kosong',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black54),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produk di Keranjang',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.cart.items.length,
                itemBuilder: (context, index) {
                  final product = widget.cart.items[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: Image.asset(
                        product.imageUrl,
                        width: 100,  // Ukuran gambar diperbesar menjadi lebih besar
                        height: 100, // Ukuran gambar diperbesar menjadi lebih besar
                      ),
                      title: Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22), // Ukuran teks lebih besar
                      ),
                      subtitle: Row(
                        children: [
                          // Tombol mengurangi kuantitas
                          IconButton(
                            icon: const Icon(Icons.remove, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _decreaseQuantity(product);
                              });
                            },
                          ),
                          Text('${product.quantity}', style: const TextStyle(fontSize: 16)), // Tampilkan kuantitas dengan ukuran lebih besar
                          // Tombol menambah kuantitas
                          IconButton(
                            icon: const Icon(Icons.add, color: Colors.black),
                            onPressed: () {
                              setState(() {
                                _increaseQuantity(product);
                              });
                            },
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Rp ${product.price * product.quantity}',
                            style: const TextStyle(fontSize: 18), // Ukuran teks harga lebih besar
                          ),
                          // Tombol delete dengan ikon tempat sampah
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                _deleteProductFromCart(product); // Panggil fungsi hapus produk
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Menampilkan total harga
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  'Rp ${totalPrice.toStringAsFixed(0)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Tombol Checkout
            _buildCheckoutButton(context, totalPrice),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk menghapus produk dari keranjang tanpa mengurangi kuantitas
  void _deleteProductFromCart(Product product) {
    widget.cart.items.remove(product); // Hapus produk langsung dari cart
    setState(() {}); // Perbarui UI setelah menghapus
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${product.title} dihapus dari keranjang')));
  }

  // Fungsi untuk mengurangi kuantitas
  void _decreaseQuantity(Product product) {
    if (product.quantity > 1) {
      setState(() {
        product.quantity--;
      });
    } else {
      // Jika kuantitas 1, hapus dari keranjang
      _deleteProductFromCart(product);
    }
  }

  // Fungsi untuk menambah kuantitas
  void _increaseQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  // Tombol Checkout
  Widget _buildCheckoutButton(BuildContext context, double totalPrice) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.blueGrey,
        ),
        onPressed: () {
          if (totalPrice > 0) {
            // Navigasi ke halaman OrderReview
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OrderReviewPage(
                  products: widget.cart.items,
                  quantities: widget.cart.items.map((product) => product.quantity).toList(),
                  cart: widget.cart,
                  shouldClearCart: true, // Bersihkan keranjang setelah checkout
                  isDirectPurchase: false, // Ini bukan pembelian langsung
                ),
              ),
            );
          }
        },
        child: const Text(
          'Checkout',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}
