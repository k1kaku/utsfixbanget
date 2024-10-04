import 'models/product.dart'; // Pastikan file Product diimport dengan benar

class Cart {
  final List<Product> _items = []; // Daftar produk di keranjang, ubah ke _items untuk menjaga enkapsulasi

  // Mendapatkan daftar produk di keranjang
  List<Product> get items => _items; // Getter untuk mengakses produk di keranjang

  // Tambahkan produk ke keranjang
  void addToCart(Product product) {
    bool productExists = false;
    for (var item in _items) {
      if (item.title == product.title) {
        item.quantity += 1;  // Jika produk sudah ada, tambahkan kuantitasnya
        productExists = true;
        break;
      }
    }
    if (!productExists) {
      // Jika produk belum ada, tambahkan produk ke keranjang
      _items.add(product);
    }
  }

  // Hapus produk dari keranjang
  void removeFromCart(Product product) {
    for (var item in _items) {
      if (item.title == product.title) {
        if (item.quantity > 1) {
          item.quantity -= 1;  // Kurangi jumlah jika lebih dari 1
        } else {
          _items.remove(item);  // Hapus produk jika jumlahnya tinggal 1
        }
        break;
      }
    }
  }

  // Hapus semua produk dari keranjang (reset)
  void clearCart() {
    _items.clear();  // Kosongkan keranjang
  }

  // Mendapatkan total harga semua item di keranjang
  int get totalPrice {
    int total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;  // Kalkulasi total harga
    }
    return total;
  }

  // Mendapatkan jumlah total item yang berbeda di keranjang
  int get itemCount {
    int totalItems = 0;
    for (var item in _items) {
      totalItems += item.quantity;  // Kalkulasi jumlah item
    }
    return totalItems;
  }

  // Mendapatkan total item jenis yang berbeda
  int get productCount {
    return _items.length;
  }

  // Cek apakah keranjang kosong
  bool get isEmpty {
    return _items.isEmpty;
  }
}
