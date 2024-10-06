// lib/cart_page.dart
import 'package:flutter/material.dart';
import 'models/product.dart';
import 'cart.dart';

class CartPage extends StatefulWidget {
  final Cart cart;

  CartPage({required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cartItems = widget.cart.cartItems;

    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: cartItems.isEmpty
          ? Center(child: Text("Keranjang kosong"))
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          final product = cartItems[index];
          return ListTile(
            leading: product.imageUrl.startsWith('http')
                ? Image.network(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image))
                : Image.asset(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image)),
            title: Text(product.title),
            subtitle: Text('Rp ${product.price}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                setState(() {
                  widget.cart.removeFromCart(product);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product.title} dihapus dari keranjang')),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
