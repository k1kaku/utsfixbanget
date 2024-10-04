import 'package:flutter/material.dart';
import 'models/product.dart';

class WishlistPage extends StatelessWidget {
  final List<Product> wishlist;

  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: wishlist.isEmpty
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 100),
            Text('Belum Ada Produk di Wishlist', style: TextStyle(fontSize: 20)),
          ],
        ),
      )
          : ListView.builder(
        itemCount: wishlist.length,
        itemBuilder: (context, index) {
          final product = wishlist[index];
          return ListTile(
            leading: Image.asset(product.imageUrl, width: 50, height: 50),
            title: Text(product.title),
            subtitle: Text('Rp ${product.price}'),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Tambahkan logika untuk menghapus dari wishlist
              },
            ),
          );
        },
      ),
    );
  }
}
