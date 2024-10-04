import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart.dart'; // Misalnya, Cart diimport di sini

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Cart cart = Cart(); // Inisialisasi cart

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kpop Store',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false, // Menyembunyikan banner "debug"
      home: HomePage(cart: cart), // Kirim cart ke HomePage
    );
  }
}
