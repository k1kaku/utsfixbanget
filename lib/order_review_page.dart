import 'package:flutter/material.dart';
import 'models/product.dart';
import 'payment_success_page.dart'; // Pastikan PaymentSuccessPage diimpor dengan benar
import 'cart.dart'; // Import class Cart

class OrderReviewPage extends StatefulWidget {
  final List<Product> products;
  final List<int> quantities;
  final Cart cart;
  final bool shouldClearCart;
  final bool isDirectPurchase;

  const OrderReviewPage({
    Key? key,
    required this.products,
    required this.quantities,
    required this.cart,
    required this.shouldClearCart,
    required this.isDirectPurchase,
  }) : super(key: key);

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  String _selectedPaymentMethod = 'Master Card';
  String _shippingAddress = 'Grasya B Lampala, Grogol, Jakarta, Indonesia';

  final List<String> _paymentMethods = ['Master Card', 'BCA', 'BNI', 'SPAY', 'OVO', 'MANDIRI'];
  final List<String> _addresses = [
    'Grasya B Lampala, Grogol, Jakarta, Indonesia',
    'Andri Rizkika, Cengkareng, Jakarta, Indonesia',
    'Hana Fathiyah, Buah Batu, Bandung, Indonesia'
  ];

  @override
  Widget build(BuildContext context) {
    final double shippingFee = 5000.0;
    final double subtotal = _calculateSubtotal();
    final double tax = subtotal * 0.1; // 10% tax
    final double total = subtotal + shippingFee + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Review', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Produk yang dibeli
              ...List.generate(widget.products.length, (index) {
                final product = widget.products[index];
                final quantity = widget.quantities[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: Hero(
                      tag: product.title,
                      child: Image.asset(product.imageUrl, width: 50, height: 50),
                    ),
                    title: Text(product.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('Qty: $quantity'),
                    trailing: Text('Rp ${(product.price * quantity).toStringAsFixed(0)}'),
                  ),
                );
              }),
              const Divider(),

              // Total harga
              _buildPriceSummary(subtotal, shippingFee, tax, total),

              const SizedBox(height: 20),

              // Payment Method
              _buildPaymentMethodSelector(context),

              // Shipping Address
              _buildShippingAddressSelector(context),

              const Spacer(),

              // Checkout Button
              _buildCheckoutButton(context, total),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriceSummary(double subtotal, double shippingFee, double tax, double total) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: const Text('Subtotal', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text('Rp ${subtotal.toStringAsFixed(0)}'),
        ),
        ListTile(
          title: const Text('Shipping Fee', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text('Rp ${shippingFee.toStringAsFixed(0)}'),
        ),
        ListTile(
          title: const Text('Tax Fee', style: TextStyle(fontWeight: FontWeight.bold)),
          trailing: Text('Rp ${tax.toStringAsFixed(0)}'),
        ),
        const Divider(),
        ListTile(
          title: const Text(
            'Total',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          trailing: Text(
            'Rp ${total.toStringAsFixed(0)}',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Method',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListTile(
          leading: const Icon(Icons.credit_card, color: Colors.blueAccent),
          title: Text(_selectedPaymentMethod),
          trailing: TextButton(
            onPressed: () {
              _selectPaymentMethod(context);
            },
            child: const Text('Change'),
          ),
        ),
      ],
    );
  }

  Widget _buildShippingAddressSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shipping Address',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        ListTile(
          leading: const Icon(Icons.location_on, color: Colors.redAccent),
          title: Text(_shippingAddress),
          trailing: TextButton(
            onPressed: () {
              _selectShippingAddress(context);
            },
            child: const Text('Change'),
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton(BuildContext context, double total) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.all(15),
          backgroundColor: Colors.green, // Ganti 'primary' dengan 'backgroundColor'
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentSuccessPage(
                cart: widget.cart,
                shouldClearCart: widget.shouldClearCart,
                isDirectPurchase: widget.isDirectPurchase,
              ),
            ),
          );
        },
        child: Text(
          'Checkout Rp ${total.toStringAsFixed(0)}',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // Fungsi untuk menghitung subtotal
  double _calculateSubtotal() {
    double subtotal = 0.0;
    for (int i = 0; i < widget.products.length; i++) {
      subtotal += widget.products[i].price * widget.quantities[i];
    }
    return subtotal;
  }

  // Fungsi untuk memilih metode pembayaran
  void _selectPaymentMethod(BuildContext context) async {
    final selectedMethod = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Payment Method'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _paymentMethods.map((String method) {
              return RadioListTile<String>(
                title: Text(method),
                value: method,
                groupValue: _selectedPaymentMethod,
                onChanged: (String? value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedMethod != null && selectedMethod != _selectedPaymentMethod) {
      setState(() {
        _selectedPaymentMethod = selectedMethod;
      });
    }
  }

  // Fungsi untuk memilih alamat pengiriman
  void _selectShippingAddress(BuildContext context) async {
    final selectedAddress = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Shipping Address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _addresses.map((String address) {
              return RadioListTile<String>(
                title: Text(address),
                value: address,
                groupValue: _shippingAddress,
                onChanged: (String? value) {
                  Navigator.pop(context, value);
                },
              );
            }).toList(),
          ),
        );
      },
    );

    if (selectedAddress != null && selectedAddress != _shippingAddress) {
      setState(() {
        _shippingAddress = selectedAddress;
      });
    }
  }
}
