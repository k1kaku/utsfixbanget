import 'models/product.dart'; // Pastikan file Product diimport dengan benar

class Cart {
  final List<Product> items = [];

  // Tambahkan produk ke keranjang
  void addToCart(Product product) {
    bool productExists = false;
    for (var item in items) {
      if (item.title == product.title) {
        item.quantity += 1;  // Tambahkan jumlah jika produk sudah ada di keranjang
        productExists = true;
        break;
      }
    }
    if (!productExists) {
      items.add(product);  // Tambahkan produk baru ke keranjang
    }
  }

  // Hapus produk dari keranjang
  void removeFromCart(Product product) {
    for (var item in items) {
      if (item.title == product.title) {
        if (item.quantity > 1) {
          item.quantity -= 1;  // Kurangi jumlah jika lebih dari 1
        } else {
          items.remove(item);  // Hapus produk jika jumlahnya tinggal 1
        }
        break;
      }
    }
  }

  // Hapus semua produk dari keranjang (reset)
  void clearCart() {
    items.clear();  // Kosongkan keranjang
  }

  // Mendapatkan total harga semua item di keranjang
  int get totalPrice {
    int total = 0;
    for (var item in items) {
      total += item.price * item.quantity;  // Kalkulasi total harga
    }
    return total;
  }

  // Mendapatkan jumlah total item yang berbeda di keranjang
  int get itemCount {
    int totalItems = 0;
    for (var item in items) {
      totalItems += item.quantity;  // Kalkulasi jumlah item
    }
    return totalItems;
  }

  // Mendapatkan total item jenis yang berbeda
  int get productCount {
    return items.length;
  }

  // Cek apakah keranjang kosong
  bool get isEmpty {
    return items.isEmpty;
  }
}
