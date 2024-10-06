// lib/database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/product.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  // Getter untuk database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kpop_store.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Membuat tabel saat database pertama kali dibuat
  Future<void> _onCreate(Database db, int version) async {
    await db.execute(''' 
      CREATE TABLE products (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        price INTEGER NOT NULL,
        image_url TEXT NOT NULL,
        description TEXT NOT NULL,
        category TEXT NOT NULL,
        quantity INTEGER DEFAULT 1,
        average_rating REAL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE ratings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        product_id INTEGER,
        rating INTEGER,
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    await _insertInitialData(db);
  }

  // Menambahkan data awal ke tabel produk
  Future<void> _insertInitialData(Database db) async {
    List<Map<String, dynamic>> initialProducts = [
      {
        'title': 'SEV',
        'price': 200000,
        'image_url': 'assets/images.png',
        'description': 'babibu.',
        'category': 'SEVENTEEN',
        'quantity': 1,
        'average_rating': 0,  // Rata-rata rating awal
      },
      // Produk lainnya
    ];

    for (var product in initialProducts) {
      await db.insert('products', product);
    }
  }

  // Menghapus database
  Future<void> deleteOldDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'kpop_store.db');
    await deleteDatabase(path);  // Menghapus database lama
  }

  // Fungsi untuk menambah rating dan memperbarui rata-rata rating produk
  Future<void> addRating(int productId, int rating) async {
    final db = await database;

    // Menyimpan rating ke tabel ratings
    await db.insert('ratings', {
      'product_id': productId,
      'rating': rating,
    });

    // Hitung rata-rata rating baru
    final result = await db.rawQuery('''
      SELECT AVG(rating) AS average_rating
      FROM ratings
      WHERE product_id = ?
    ''', [productId]);

    double averageRating = result[0]['average_rating'] != null
        ? (result[0]['average_rating'] as double)
        : 0.0;

    // Update rata-rata rating di tabel products
    await db.update(
      'products',
      {'average_rating': averageRating},
      where: 'id = ?',
      whereArgs: [productId],
    );
  }

  // Fungsi untuk mengambil produk berdasarkan ID
  Future<Product?> getProduct(int productId) async {
    final db = await database;
    final result = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [productId],
    );
    if (result.isNotEmpty) {
      return Product.fromMap(result.first);
    } else {
      return null;
    }
  }

  // Fungsi untuk mengambil semua produk
  Future<List<Product>> getProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> result = await db.query('products');
    return List.generate(result.length, (i) {
      return Product.fromMap(result[i]);
    });
  }

  // lib/database_helper.dart
  Future<void> updateProduct(Map<String, dynamic> productMap) async {
    final db = await database;
    await db.update(
      'products',
      productMap,
      where: 'id = ?',
      whereArgs: [productMap['id']],
    );
  }

}

