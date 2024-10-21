import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    final prefs = context.read<ApplicationPreferences>().darkMode;
    final theme = Theme.of(context);

    return FutureBuilder<Product?>(
      future: context.read<ShoppingCartController>().getProductById(widget.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(),
          );
        }
        else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading product details.'),
          );
        }
        else if (!snapshot.hasData) {
          return const Center(
            child: Text('Product not found.'),
          );
        }

        final product = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: Text(
              product.title,
              style: theme.textTheme.titleMedium,
              overflow: TextOverflow.fade,
            ),  
          ),
          body: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: prefs 
                ? [Colors.blue, Colors.blueAccent, const Color.fromARGB(255, 9, 78, 182) ,const Color.fromARGB(255, 2, 7, 129)] 
                : [Colors.blue, Colors.white], 
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(  
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImage(
                      height: screenHeight * .45,
                      width: double.infinity,
                      tag: product.id,
                      url: product.image,
                    ),
                    const SizedBox(
                      height: 20
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Description: \n',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold, 
                          color: prefs ? Colors.white : Colors.black
                        ),
                        children: [
                          TextSpan(
                            text: product.description,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ]
                      ),
                    ),
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        text: 'Price: \n',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: formatCurrency(product.price),
                            style: theme.textTheme.bodyLarge,
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        );  
      },
    );
  }

  String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return format.format(amount);
  }
}