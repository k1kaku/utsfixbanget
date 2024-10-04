import 'package:flutter/material.dart';
import 'cart_page.dart'; // Halaman Keranjang Belanja
import 'wishlist_page.dart'; // Halaman Wishlist
import 'home_page.dart'; // Halaman Utama

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Merch Kpop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    );
  }
}
