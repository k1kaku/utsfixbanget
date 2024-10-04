import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'order_review_page.dart';
=======
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
import 'models/product.dart';

class ProductDetail extends StatelessWidget {
  final Product product;

  const ProductDetail({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
=======
    int count = 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
<<<<<<< HEAD
=======
        title: const Text('Detail', style: TextStyle(color: Colors.black)),
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
<<<<<<< HEAD
              // Add to wishlist logic
=======
              // Logika untuk menambahkan ke wishlist
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 8.0),
          Text(
            product.title,
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Center(
<<<<<<< HEAD
            child: Image.asset(product.imageUrl, height: 200),
=======
            child: Image.network(product.imageUrl, height: 200),
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
          ),
          Container(
            color: Colors.grey[200],
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Row(
              children: [
                Text(
                  'Rp ${product.price}',
                  style: const TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.w700),
                ),
                const Text(
                  ' / per item',
                  style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                product.description,
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                textAlign: TextAlign.justify,
              ),
            ),
          ),
          Container(
            height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
<<<<<<< HEAD
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OrderReviewPage(product: product, quantity: 1),
                      ),
                    );
=======
                    // Logika menambah ke keranjang
>>>>>>> 9c964edd192e8a23aa1a4fa6aa13e9a663fc7900
                  },
                  child: const Text('Pesan', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
