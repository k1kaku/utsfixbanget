// lib/wishlist_page.dart
import 'package:flutter/material.dart';
import 'models/product.dart';
import 'cart.dart';

class WishlistPage extends StatefulWidget {
  final List<Product> wishlist;
  final Cart cart;
  final Function(List<Product>) updateWishlist;

  WishlistPage({required this.wishlist, required this.cart, required this.updateWishlist});

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  late List<Product> _wishlist;

  @override
  void initState() {
    super.initState();
    _wishlist = widget.wishlist;
  }

  void removeFromWishlist(Product product) {
    setState(() {
      _wishlist.remove(product);
    });
    widget.updateWishlist(_wishlist);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} dihapus dari wishlist')),
    );
  }

  void addToCart(Product product) {
    widget.cart.addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} telah ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: _wishlist.isEmpty
          ? Center(child: Text("Wishlist kosong"))
          : ListView.builder(
        itemCount: _wishlist.length,
        itemBuilder: (context, index) {
          final product = _wishlist[index];
          return ListTile(
            leading: product.imageUrl.startsWith('http')
                ? Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image))
                : Image.asset(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image)),
            title: Text(product.title),
            subtitle: Text('Rp ${product.price}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () => addToCart(product),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => removeFromWishlist(product),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
