import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'product_detail.dart';
import 'models/product.dart';
import 'wishlist_page.dart';
import 'cart.dart'; // Import kelas keranjang

class HomePage extends StatefulWidget {
  final Cart cart; // Tambahkan cart sebagai parameter untuk diteruskan

  const HomePage({Key? key, required this.cart}) : super(key: key);  // Pastikan cart dikirim ke homepage

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
      imageUrl: 'assets/images.png', // Gunakan gambar dari assets
      description: 'Acrylic Keyring Follow tour SEVENTEEN.',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'S/S T-Shirt',
      price: 4000,
      imageUrl: 'assets/img_3.png', // Ganti dengan gambar lain dari assets jika ada
      description: '(Washing Black) Right here T-Shirt.',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'Mini Shoulder Bag',
      price: 9500,
      imageUrl: 'assets/img_4.png', // Ganti dengan gambar lain dari assets jika ada
      description: 'BONGBONGEE Mini Shoulder Bag.',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'SEOUL DIGITAL CODE',
      price: 9500,
      imageUrl: 'assets/img_6.png', // Ganti dengan gambar lain dari assets jika ada
      description: 'SEVENTEEN TOUR [FOLLOW] TO SEOUL DIGITAL CODE',
      category: 'SEVENTEEN',
    ),
    Product(
      title: 'NCT127 Album [WALK]',
      price: 4500,
      imageUrl: 'assets/img_7.png', // Ganti dengan gambar lain dari assets jika ada
      description: 'The 6th Album [WALK] (Poster Ver.)',
      category: 'NCT',
    ),
    Product(
      title: 'NCT127 Doyoung YOUTH',
      price: 4500,
      imageUrl: 'assets/img_8.png', // Ganti dengan gambar lain dari assets jika ada
      description: 'The 1st Album 청춘의 포말 (YOUTH) (새봄 Ver.)',
      category: 'NCT',
    ),
    Product(
      title: 'ATEEZ Album',
      price: 5000,
      imageUrl: 'assets/img_8.png', // Ganti dengan gambar lain dari assets jika ada
      description: 'The new album by ATEEZ.',
      category: 'ATEEZ',
    ),
    Product(
      title: 'RIIZE Debut Album',
      price: 5500,
      imageUrl: 'assets/img_8.png', // Ganti dengan gambar lain dari assets jika ada
      description: 'The debut album of RIIZE.',
      category: 'RIIZE',
    ),
  ];

  // Filter produk berdasarkan kategori yang dipilih
  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
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
        title: const Text('Toko Merchandise Kpop'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(cart: widget.cart), // Kirim data keranjang ke CartPage
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
                  builder: (context) => WishlistPage(wishlist: _wishlist), // Kirim data wishlist ke WishListPage
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.7, // Mengubah rasio untuk tampilan yang lebih baik
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
                      product: product,      // Kirimkan produk
                      cart: widget.cart,     // Kirimkan instance Cart ke ProductDetail
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Menampilkan gambar dari assets
                    Image.asset(product.imageUrl, height: 100, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        product.title,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis, // Menghindari teks terlalu panjang
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Rp ${product.price}', style: const TextStyle(color: Colors.green)),
                    ),
                    // Tombol "Beli" langsung membawa ke halaman detail produk
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetail(
                              product: product,   // Kirimkan produk
                              cart: widget.cart,  // Kirimkan instance Cart ke ProductDetail
                            ),
                          ),
                        );
                      },
                      child: const Text('Beli'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            _wishlist.contains(product)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            toggleWishlist(product); // Tambah atau hapus dari wishlist
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.shopping_cart, color: Colors.blue),
                          onPressed: () {
                            setState(() {
                              widget.cart.addToCart(product); // Tambahkan produk ke keranjang jika tombol cart ditekan
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text(
                'Pilih Kategori',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: const Text('Semua Produk'),
              onTap: () {
                setState(() {
                  selectedCategory = 'All';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('SEVENTEEN'),
              onTap: () {
                setState(() {
                  selectedCategory = 'SEVENTEEN';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('NCT'),
              onTap: () {
                setState(() {
                  selectedCategory = 'NCT';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('ATEEZ'),
              onTap: () {
                setState(() {
                  selectedCategory = 'ATEEZ';
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('RIIZE'),
              onTap: () {
                setState(() {
                  selectedCategory = 'RIIZE';
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
