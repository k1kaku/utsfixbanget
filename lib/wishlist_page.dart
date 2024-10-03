import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 100),
            Text('Belum Ada Produk di Wishlist', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
