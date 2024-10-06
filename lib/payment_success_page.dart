import 'package:flutter/material.dart';
import 'cart.dart';
import 'home_page.dart'; // Pastikan HomePage diimpor dengan benar

class PaymentSuccessPage extends StatelessWidget {
  final Cart cart;
  final bool shouldClearCart; // Parameter untuk menghapus keranjang setelah pembayaran

  const PaymentSuccessPage({Key? key, required this.cart, required this.shouldClearCart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (shouldClearCart) {
      cart.clearCart(); // Kosongkan keranjang jika flag shouldClearCart bernilai true
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Pembayaran Berhasil', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animasi ikon berhasil (centang hijau besar)
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100,
            ),
            const SizedBox(height: 20),

            // Pesan sukses
            const Text(
              'Pembayaran Berhasil!',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            const Text(
              'Terima kasih telah berbelanja.',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Tombol untuk kembali ke beranda dan melanjutkan belanja
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () {
                  // Navigasi kembali ke halaman utama
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(cart: cart),
                    ),
                        (route) => false, // Menghapus semua halaman sebelumnya dari tumpukan
                  );
                },
                child: const Text(
                  'Lanjutkan Belanja',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
