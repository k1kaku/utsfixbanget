import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'product_detail.dart';
import 'models/product.dart';
import 'wishlist_page.dart';
import 'cart.dart'; // Import kelas keranjang

class HomePage extends StatefulWidget {
  final Cart cart; // Tambahkan cart sebagai parameter untuk diteruskan

  const HomePage({Key? key, required this.cart}) : super(key: key); // Pastikan cart dikirim ke homepage

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = 'All'; // Filter untuk kategori
  final List<Product> _wishlist = []; // Inisialisasi wishlist

  // Dummy data produk dengan gambar dari assets
  final List<Product> allProducts = [
    Product(
      title: 'SEVENTEEN Acrylic Keyring',
      price: 2000,
      imageUrl: 'assets/images.png',
      description: 'Acrylic Keyring Follow tour SEVENTEEN.',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'S/S T-Shirt',
      price: 4000,
      imageUrl: 'assets/img_3.png',
      description: '(Washing Black) Right here T-Shirt.',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'Mini Shoulder Bag',
      price: 9500,
      imageUrl: 'assets/img_4.png',
      description: 'BONGBONGEE Mini Shoulder Bag.',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'SEOUL DIGITAL CODE',
      price: 9500,
      imageUrl: 'assets/img_6.png',
      description: 'SEVENTEEN TOUR [FOLLOW] TO SEOUL DIGITAL CODE',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'NCT127 Album [WALK]',
      price: 4500,
      imageUrl: 'assets/img_7.png',
      description: 'The 6th Album [WALK] (Poster Ver.)',
      category: 'NCT',
    ),
    Product(
      title: 'NCT127 Doyoung YOUTH',
      price: 4500,
      imageUrl: 'assets/img_8.png',
      description: 'The 1st Album 청춘의 포말 (YOUTH) (새봄 Ver.)',
      category: 'NCT',
    ),
    Product(
      title: 'ATEEZ Album',
      price: 5000,
      imageUrl: 'assets/img_8.png',
      description: 'The new album by ATEEZ.',
      category: 'ATEEZ',
    ),
    Product(
      title: 'RIIZE Debut Album',
      price: 5500,
      imageUrl: 'assets/img_8.png',
      description: 'The debut album of RIIZE.',
      category: 'RIIZE',
    ),
  ];

  // Filter produk berdasarkan kategori yang dipilih
  List<Product> get filteredProducts {
    if (selectedCategory == '' || selectedCategory == 'All') {
      return allProducts;
    } else {
      return allProducts.where((product) => product.category == selectedCategory).toList();
    }
  }

  // Fungsi untuk menambah atau menghapus produk dari wishlist
  void toggleWishlist(Product product) {
    setState(() {
      if (_wishlist.contains(product)) {
        _wishlist.remove(product);
      } else {
        _wishlist.add(product);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text(_wishlist.contains(product)
            ? '${product.title} ditambahkan ke wishlist'
            : '${product.title} dihapus dari wishlist'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Toko Merchandise Kpop',
          style: TextStyle(color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: widget.cart),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishlistPage(wishlist: _wishlist),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Kontainer untuk kategori
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blueGrey, Colors.grey],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20), // Perbesar padding vertikal
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Pilih Kategori',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28, // Perbesar ukuran teks
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20), // Tambahkan lebih banyak jarak antar elemen
                _buildCategoryDropdown(),
              ],
            ),
          ),
          const SizedBox(height: 20), // Jarak untuk memisahkan kategori dan list produk
          // Posisikan tulisan "List Produk" di kiri atas
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'List Produk',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return GestureDetector(
                    onTap: () {
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 5,
                      shadowColor: Colors.blueGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(product.imageUrl, fit: BoxFit.cover),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                            child: Text(
                              product.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Text(
                              'Rp ${product.price}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            onPressed: () {
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
                            child: const Text('Beli', style: TextStyle(color: Colors.white)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                icon: Icon(
                                  _wishlist.contains(product) ? Icons.favorite : Icons.favorite_border,
                                  color: _wishlist.contains(product)
                                      ? Colors.red
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  toggleWishlist(product);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                                onPressed: () {
                                  setState(() {
                                    widget.cart.addToCart(product);
                                  });
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('${product.title} telah ditambahkan ke keranjang')),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButton<String>(
      value: selectedCategory,
      dropdownColor: Colors.blueGrey,
      underline: Container(),
      iconEnabledColor: Colors.white,
      isExpanded: true,
      style: const TextStyle(color: Colors.white),
      onChanged: (String? newValue) {
        setState(() {
          selectedCategory = newValue ?? 'All';
        });
      },
      items: ['All', 'SEVENTEEN', 'NCT', 'ATEEZ', 'RIIZE']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20, // Ubah ukuran teks dropdown menjadi lebih besar
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }

}
