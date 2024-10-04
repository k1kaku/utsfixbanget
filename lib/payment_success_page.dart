import 'package:flutter/material.dart';
import 'cart.dart'; // Pastikan Cart diimpor untuk mengakses keranjang
import 'home_page.dart'; // Pastikan HomePage diimpor sebagai halaman utama

class PaymentSuccessPage extends StatelessWidget {
  final Cart cart;
  final bool shouldClearCart; // Parameter untuk membersihkan keranjang
  final bool isDirectPurchase; // Tambahkan parameter untuk mengetahui pembelian langsung

  const PaymentSuccessPage({
    Key? key,
    required this.cart,
    required this.shouldClearCart,
    required this.isDirectPurchase,  // Tambahkan parameter untuk pembelian langsung
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran Berhasil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Jika pembelian melalui keranjang dan `shouldClearCart` bernilai true, bersihkan keranjang
                if (shouldClearCart && !isDirectPurchase) {
                  cart.clearCart();
                }

                // Navigasi kembali ke halaman utama
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(cart: cart), // Kirim data cart ke homepage
                  ),
                      (Route<dynamic> route) => false, // Menghapus semua halaman sebelumnya
                );
              },
              child: const Text('Lanjutkan Belanja'),
            ),
          ],
        ),
      ),
    );
  }
}
