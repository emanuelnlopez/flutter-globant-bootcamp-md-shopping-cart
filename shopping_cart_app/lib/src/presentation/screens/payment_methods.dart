import 'package:flutter/material.dart';
import 'package:shopping_cart_app/src/domain/model/user.dart';

class PaymentMethods extends StatefulWidget {
  const PaymentMethods({super.key});

  @override
  State<PaymentMethods> createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {  
  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)?.settings.arguments as User;

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
}

class Pay {
  
}