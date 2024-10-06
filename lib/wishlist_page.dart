import 'package:flutter/material.dart';
import 'models/product.dart';
import 'cart.dart';
import 'product_detail.dart'; // Tambahkan import untuk ProductDetail

class WishlistPage extends StatefulWidget {
  final List<Product> wishlist;
  final Cart cart;
  final Function(List<Product>) updateWishlist;

  const WishlistPage({
    Key? key,
    required this.wishlist,
    required this.cart,
    required this.updateWishlist, // Terima fungsi untuk memperbarui wishlist
  }) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Product> wishlist;

  @override
  void initState() {
    super.initState();
    wishlist = List.from(widget.wishlist); // Salin daftar wishlist dari widget
  }

  void _removeFromWishlist(Product product) {
    setState(() {
      wishlist.remove(product);
    });
    widget.updateWishlist(wishlist); // Update wishlist di HomePage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context, wishlist); // Kembali ke halaman sebelumnya dengan membawa wishlist yang telah diperbarui
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        color: Colors.white,
        child: wishlist.isEmpty
            ? const Center(
          child: Text(
            'Wishlist Anda kosong',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        )
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Produk di Wishlist',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: wishlist.length,
                itemBuilder: (context, index) {
                  final product = wishlist[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke ProductDetail ketika produk dipilih
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetail(
                            product: product,
                            cart: widget.cart,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Gambar Produk
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                height: 120, // Memperbesar gambar produk
                                width: 120,
                              ),
                            ),
                            const SizedBox(width: 15),

                            // Informasi Produk
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Rp ${product.price}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Icon untuk menghapus produk dari wishlist
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.red),
                              onPressed: () {
                                _removeFromWishlist(product); // Hapus dari wishlist
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${product.title} dihapus dari wishlist'),
                                    backgroundColor: Colors.blueGrey,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
