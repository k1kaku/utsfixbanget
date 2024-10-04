import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'models/product.dart';
import 'cart.dart'; // Import class Cart yang sudah kita buat

class CartPage extends StatelessWidget {
  final Cart cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);
=======

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
      ),
<<<<<<< HEAD
      body: cart.items.isEmpty
          ? Center(
=======
      body: Center(
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.shopping_cart, size: 100),
            Text('Keranjang Belanja Anda Kosong', style: TextStyle(fontSize: 20)),
          ],
        ),
<<<<<<< HEAD
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
                // Logika checkout bisa ditambahkan di sini
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Checkout Berhasil"),
                      content: const Text("Terima kasih sudah berbelanja!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            cart.clearCart(); // Bersihkan keranjang setelah checkout
                            Navigator.of(context).pop(); // Kembali ke halaman sebelumnya
                          },
                          child: const Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Checkout', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      )
          : null,
=======
      ),
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
    );
  }
}
