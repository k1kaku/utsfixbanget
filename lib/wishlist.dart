// wishlist.dart
import 'models/product.dart'; // Pastikan file Product diimport dengan benar

class Wishlist {
  final List<Product> items = [];

  // Tambahkan produk ke wishlist
  void addToWishlist(Product product) {
    bool productExists = false;
    for (var item in items) {
      if (item.title == product.title) {
        productExists = true;
        break;
      }
    }
    if (!productExists) {
      items.add(product);  // Tambahkan produk baru ke wishlist
    }
  }

  // Hapus produk dari wishlist
  void removeFromWishlist(Product product) {
    items.remove(product);  // Hapus produk dari wishlist
  }

  // Mendapatkan total item jenis yang berbeda
  int get productCount {
    return items.length;
  }

  // Cek apakah wishlist kosong
  bool get isEmpty {
    return items.isEmpty;
  }
}
