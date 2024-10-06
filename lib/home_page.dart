// lib/home_page.dart
import 'package:flutter/material.dart';
import 'database_helper.dart'; // Import DatabaseHelper dari lib/
import 'cart_page.dart';
import 'product_detail.dart'; // Import ProductDetail untuk navigasi
import 'models/product.dart'; // Import Product dari lib/models/
import 'wishlist_page.dart';
import 'cart.dart'; // Import Cart dari lib/
import 'package:kelompok_uts/product_detail.dart';  // Pastikan untuk mengimpor ProductDetail


class HomePage extends StatefulWidget {
  final Cart cart; // Tambahkan cart sebagai parameter untuk diteruskan

  const HomePage({Key? key, required this.cart}) : super(key: key); // Pastikan cart dikirim ke homepage

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  String selectedCategory = 'All'; // Filter untuk kategori
  List<Product> _wishlist = []; // Inisialisasi wishlist
  List<Product> _allProducts = []; // Semua produk dari database
  bool _isLoading = true; // Tambahkan indikator loading

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Ambil data produk saat halaman dimuat
  }

  // Fungsi untuk mengambil produk dari database
  Future<void> fetchProducts() async {
    try {
      setState(() {
        _isLoading = true; // Mulai loading
      });

      List<Product> products = await _databaseHelper.getProducts();
      setState(() {
        _allProducts = products;
        _isLoading = false; // Selesai loading
      });

      // Debugging untuk memeriksa data produk
      if (products.isEmpty) {
        print("Tidak ada produk di database.");
      } else {
        for (var product in products) {
          print("Produk: ${product.title}, Gambar: ${product.imageUrl}");
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false; // Selesai loading meskipun error
      });
      // Tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengambil data produk: $e')),
      );
    }
  }

  // Filter produk berdasarkan kategori yang dipilih
  List<Product> get filteredProducts {
    if (selectedCategory == 'All') {
      return _allProducts;
    } else {
      return _allProducts.where((product) => product.category == selectedCategory).toList();
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

  // Fungsi untuk menambahkan produk ke keranjang
  void addToCart(Product product) async {
    widget.cart.addToCart(product);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${product.title} telah ditambahkan ke keranjang')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'VibeMerch',
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
                  builder: (context) => WishlistPage(
                    wishlist: _wishlist,
                    cart: widget.cart,
                    updateWishlist: (updatedWishlist) {
                      setState(() {
                        _wishlist = updatedWishlist; // Update wishlist di HomePage
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Tampilkan loading saat mengambil data
          : Column(
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
            child: filteredProducts.isEmpty
                ? Center(
              child: Text(
                "Tidak ada produk yang sesuai.",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            )
                : Padding(
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
                          builder: (context) => ProductDetail(  // Memastikan menggunakan ProductDetailPage dengan parameter yang benar
                            product: product,
                            cart: widget.cart,  // Kirimkan cart ke ProductDetailPage
                          ),
                        ),
                      ).then((_) => fetchProducts()); // Refresh saat kembali // Refresh saat kembali
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
                              child: Image.asset(
                                product.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(Icons.broken_image, size: 50);
                                },
                              ),
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
                              addToCart(product);
                            },
                            child: const Text('Beli', style: TextStyle(color: Colors.white)),
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

  // Dropdown untuk memilih kategori
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
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      }).toList(),
    );
  }
}
