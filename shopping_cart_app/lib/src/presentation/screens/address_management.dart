import 'package:flutter/material.dart';

class AddressManagement extends StatefulWidget {
  const AddressManagement({super.key});

  @override
  State<AddressManagement> createState() => _AdressManagementState();
}

class _AdressManagementState extends State<AddressManagement> {
  final List<Address> _addresses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage addresses'
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: _addresses.isEmpty 
          ? const Center(
            child: Text('No addresses added.')
          )
          : ListView.builder(
            itemCount: _addresses.length,
            itemBuilder: (context, index) {
              final address = _addresses[index];
        
              return ListTile(
                title: Text('${address.street}, ${address.streetNumber}'),
                subtitle: Text(address.city),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () => _editAddress(context, address, index),
                      icon: const Icon(Icons.edit)
                    ),
                    IconButton(
                      onPressed: () => _deleteAddress(index), 
                      icon: const Icon(Icons.delete)
                    )
                  ],
                ),
              );
            }
          ),
      ),
      floatingActionButton: _addresses.length < 3 
        ? FloatingActionButton(
          onPressed: () => _addAdress(context),
          child: const Icon(Icons.add),
        )
        : null
    );
  }

  void _addAdress(BuildContext context) async {
    final newAddress = await _showAddressDialog(context);

    if (newAddress != null) {
      setState(() {
        _addresses.add(newAddress);
      });
    }
  }

  void _editAddress(BuildContext context, Address address, int index) async {
    final editedAddress = await _showAddressDialog(context, address: address);

    if (editedAddress != null) {
      setState(() {
        _addresses[index] = editedAddress;
      });
    }
  }

  void _deleteAddress(int index) {
    setState(() {
      _addresses.removeAt(index);
    });
  }

  Future<Address?> _showAddressDialog(BuildContext context, {Address? address}) {
    final cityController = TextEditingController(text: address?.city);
    final streetController = TextEditingController(text: address?.street);
    final streetNumberController = TextEditingController(text: address?.streetNumber.toString());

    return showDialog(
      context: context, 
      builder: (context) {
        return AlertDialog(
          title: Text(address == null ? 'Add address' : 'Edit address'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City'
                ),
              ),
              TextField(
                controller: streetController,
                decoration: const InputDecoration(
                  labelText: 'Street'
                ),
              ),
              TextField(
                controller: streetNumberController,
                decoration: const InputDecoration(
                  labelText: 'Street number'
                ),
                keyboardType: TextInputType.number,
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), 
              child: const Text('Cancel')
            ),
            TextButton(
              onPressed: () {
                final streetNumber  = int.tryParse(streetNumberController.text);

                if (streetNumber == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please enter a valid street number.'),
                      backgroundColor: Colors.red,
                    )
                  );

                  return;
                }

                final newAddress = Address(
                  city: cityController.text, 
                  street: streetController.text, 
                  streetNumber: streetNumber,
                );
                Navigator.of(context).pop(newAddress);
              }, 
              child: const Text('Save')
            )
          ],
        );
      }
    );
  }
}

class Address {
  final String city;
  final String street;
  final int streetNumber;

  Address({
    required this.city,
    required this.street,
    required this.streetNumber,
  });
}