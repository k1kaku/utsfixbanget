import 'package:flutter/material.dart';

class AddAddressPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  AddAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
            ),
            TextField(
              controller: streetController,
              decoration: const InputDecoration(labelText: 'Street'),
            ),
            TextField(
              controller: postalCodeController,
              decoration: const InputDecoration(labelText: 'Postal Code'),
            ),
            TextField(
              controller: cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: stateController,
              decoration: const InputDecoration(labelText: 'State'),
            ),
            TextField(
              controller: countryController,
              decoration: const InputDecoration(labelText: 'Country'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic untuk menyimpan alamat baru
                String newAddress = '${streetController.text}, ${cityController.text}, ${stateController.text}, ${countryController.text}';
                Navigator.pop(context, newAddress);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
