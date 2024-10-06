// lib/payment_success_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';  // Impor RatingBar
import 'database_helper.dart';
import 'models/product.dart';

class PaymentSuccessPage extends StatefulWidget {
  final Product product;

  PaymentSuccessPage({required this.product});

  @override
  _PaymentSuccessPageState createState() => _PaymentSuccessPageState();
}

class _PaymentSuccessPageState extends State<PaymentSuccessPage> {
  final TextEditingController _ratingController = TextEditingController();
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  // Fungsi untuk menambah rating
  void addRating(int productId, int rating) async {
    await _databaseHelper.addRating(productId, rating);

    // Memperbarui rating produk setelah diberi rating baru
    setState(() {
      widget.product.averageRating = double.parse(_ratingController.text);
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Rating berhasil diberikan!")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pembayaran Berhasil!'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 80),
            SizedBox(height: 16),
            Text(
              'Terima kasih telah berbelanja!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Sekarang Anda dapat memberikan rating untuk produk yang telah dibeli.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            // Rating yang diberikan oleh pengguna menggunakan RatingBar
            RatingBar(
              initialRating: widget.product.averageRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 40.0,
              ratingWidget: RatingWidget(
                full: Icon(Icons.star, color: Colors.amber),
                half: Icon(Icons.star_half, color: Colors.amber),
                empty: Icon(Icons.star_border, color: Colors.amber),
              ),
              onRatingUpdate: (rating) {
                _ratingController.text = rating.toString();
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int rating = int.parse(_ratingController.text);
                addRating(widget.product.id!, rating);
              },
              child: Text("Berikan Rating"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Kembali ke halaman utama atau lanjut belanja
                Navigator.pop(context);
              },
              child: Text("Kembali ke Beranda"),
            ),
          ],
        ),
      ),
    );
  }
}
