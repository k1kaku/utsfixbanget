import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'models/product.dart';

class WishlistPage extends StatelessWidget {
  final List<Product> wishlist;

  const WishlistPage({Key? key, required this.wishlist}) : super(key: key);
=======

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
<<<<<<< HEAD
      body: wishlist.isEmpty
          ? Center(
=======
      body: Center(
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.favorite_border, size: 100),
            Text('Belum Ada Produk di Wishlist', style: TextStyle(fontSize: 20)),
          ],
        ),
<<<<<<< HEAD
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
=======
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
      ),
    );
  }
}
