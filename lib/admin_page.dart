import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/product.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  int _price = 0;
  String _imageUrl = '';
  String _description = '';
  String _category = '';
  int _quantity = 1;

  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    List<Product> products = await _dbHelper.getProducts();
    setState(() {
      _products = products;
    });
  }

  Future<void> _addProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await _dbHelper.insertProduct({
        'title': _title,
        'price': _price,
        'image_url': _imageUrl,
        'description': _description,
        'category': _category,
        'quantity': _quantity,
      });
      _fetchProducts();
      Navigator.of(context).pop();
    }
  }

  Future<void> _deleteProduct(int id) async {
    await _dbHelper.deleteProduct(id);
    _fetchProducts();
  }

  void _showAddProductDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tambah Produk'),
          content: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Judul'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Judul tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Harga'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Harga tidak boleh kosong';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _price = int.parse(value!);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'URL Gambar'),
                    onSaved: (value) {
                      _imageUrl = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Deskripsi'),
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Kategori'),
                    onSaved: (value) {
                      _category = value!;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Batal'),
            ),
            ElevatedButton(
              onPressed: _addProduct,
              child: Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Halaman Admin'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showAddProductDialog,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return ListTile(
            leading: Image.asset(
              product.imageUrl,
              fit: BoxFit.cover,
              width: 50,
              height: 50,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.broken_image);
              },
            ),
            title: Text(product.title),
            subtitle: Text('Rp ${product.price} - ${product.category}'),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteProduct(product.id!),
            ),
          );
        },
      ),
    );
  }
}
