import 'package:flutter/material.dart';
import 'models/product.dart';
import 'payment_success_page.dart'; // Pastikan PaymentSuccessPage diimpor dengan benar

class OrderReviewPage extends StatefulWidget {
  final Product product;
  final int quantity;

  const OrderReviewPage({
    Key? key,
    required this.product,
    required this.quantity,
  }) : super(key: key);

  @override
  _OrderReviewPageState createState() => _OrderReviewPageState();
}

class _OrderReviewPageState extends State<OrderReviewPage> {
  String _selectedPaymentMethod = 'Master Card';
  String _shippingAddress = 'Taimoor Sikander, +923329121290, Muhallah Usman a bad, Chakwal, Punjab 48800, Pakistan';

  final List<String> _paymentMethods = ['Master Card', 'BCA', 'BNI', 'SPAY', 'OVO', 'MANDIRI'];
  final List<String> _addresses = [
    'Taimoor Sikander, +923329121290, Muhallah Usman a bad, Chakwal, Punjab 48800, Pakistan',
    '123 Main Street, Jakarta, Indonesia',
    '456 Second Street, Bandung, Indonesia'
  ];

  @override
  Widget build(BuildContext context) {
    final double shippingFee = 5000.0;
    final double tax = widget.product.price * widget.quantity * 0.1; // 10% tax
    final double subtotal = widget.product.price * widget.quantity.toDouble();
    final double total = subtotal + shippingFee + tax;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Review'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Details
            ListTile(
              leading: Image.asset(widget.product.imageUrl, width: 50, height: 50),
              title: Text(widget.product.title),
              subtitle: Text('Qty: ${widget.quantity}'),
              trailing: Text('Rp ${subtotal.toStringAsFixed(0)}'),
            ),
            const Divider(),

            // Promo Code
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Have a promo code? Enter here',
                suffixIcon: ElevatedButton(
                  onPressed: () {
                    // Logic for applying promo code
                  },
                  child: const Text('Apply'),
                ),
              ),
            ),
            const Divider(),

            // Subtotal, Shipping Fee, Tax Fee
            ListTile(
              title: const Text('Subtotal'),
              trailing: Text('Rp ${subtotal.toStringAsFixed(0)}'),
            ),
            ListTile(
              title: const Text('Shipping Fee'),
              trailing: Text('Rp ${shippingFee.toStringAsFixed(0)}'),
            ),
            ListTile(
              title: const Text('Tax Fee'),
              trailing: Text('Rp ${tax.toStringAsFixed(0)}'),
            ),
            const Divider(),

            // Total
            ListTile(
              title: const Text(
                'Order Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Text(
                'Rp ${total.toStringAsFixed(0)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Method
            const Text(
              'Payment Method',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.credit_card),
              title: Text(_selectedPaymentMethod),
              trailing: TextButton(
                onPressed: () {
                  _selectPaymentMethod(context);
                },
                child: const Text('Change'),
              ),
            ),

            // Shipping Address
            const Text(
              'Shipping Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: const Icon(Icons.location_on),
              title: Text(_shippingAddress),
              trailing: TextButton(
                onPressed: () {
                  _selectShippingAddress(context);
                },
                child: const Text('Change'),
              ),
            ),
            const Spacer(),

            // Checkout Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentSuccessPage(),
                    ),
                  );
                },
                child: Text('Checkout Rp ${total.toStringAsFixed(0)}'),
              ),
            ),
          ],
        ),
      ),
    );
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
          actions: [
            TextButton(
              child: const Text('Add new address'),
              onPressed: () {
                _addNewAddress(context);
              },
            ),
          ],
        );
      },
    );

    if (selectedAddress != null && selectedAddress != _shippingAddress) {
      setState(() {
        _shippingAddress = selectedAddress;
      });
    }
  }

  // Fungsi untuk menambahkan alamat baru
  void _addNewAddress(BuildContext context) {
    // Implementasi Add New Address di sini
  }
}
