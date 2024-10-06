import 'package:flutter/material.dart';
import 'home_page.dart';
import 'cart.dart';
import 'database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper();

  try {
    // Hapus database lama
    print("Menghapus database lama...");
    await dbHelper.deleteOldDatabase();

    // Inisialisasi database baru
    print("Inisialisasi database baru...");
    await dbHelper.database;

    print("Database berhasil diinisialisasi. Menjalankan aplikasi...");
  } catch (e) {
    print("Error saat menginisialisasi database: $e");
  }

  // Jalankan aplikasi
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Cart cart = Cart();

  MyApp({super.key}); // Inisialisasi cart

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VibeMerch',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false, // Menyembunyikan banner "debug"
      home: HomePage(cart: cart), // Kirim cart ke HomePage
    );
  }
}
