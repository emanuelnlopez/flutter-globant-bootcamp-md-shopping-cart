import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({
    required this.userId,
    super.key
  });

  final int userId;

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<UserController>().getUserById(widget.userId), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading user data.'),
          );
        }
        else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('User not found.'),
          );
        }
        
        final user = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Payment methods'),
            backgroundColor: Colors.blueAccent,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.credit_card),
                  title: Text('${user.lastName} ${user.firstName}'),
                  subtitle: Text('Payment method: ${index + 1}'),
                  trailing: IconButton(
                        onPressed: () {}, 
                        icon: const Icon(Icons.delete)
                      )
                );
              },
            )
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, 
            label: const Row(
              children: [
                Icon(Icons.add),
                SizedBox(
                  width: 20,
                ),
                Text('Add payment method'),
              ]
            ),
            backgroundColor: Colors.blue,
          ),
        );
      }    
    );
  }
}