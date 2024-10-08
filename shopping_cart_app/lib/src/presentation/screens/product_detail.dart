import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/state/application_preferences.dart';
import 'package:shopping_cart_app/src/presentation/widgets/product_image.dart';

class ProductDetail extends StatefulWidget {
  const ProductDetail({
    super.key,
    required this.product,
  });

  final Product product;

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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          widget.product.title,
          style: theme.textTheme.titleSmall,
          overflow: TextOverflow.fade,
        ),
        
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: prefs ? 
            [Colors.blue, Colors.black] : [Colors.blue, Colors.white], 
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(  // Cambiamos el Stack por una Column
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImage(
                  height: screenHeight * .45,
                  width: double.infinity,
                  tag: widget.product.id,
                  url: widget.product.image,
                ),
                const SizedBox(height: 20),
                RichText(
                  text: TextSpan(
                    text: 'Description: \n',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold, 
                      color: prefs ? Colors.white : Colors.black
                    ),
                    children: [
                      TextSpan(
                        text: widget.product.description,
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
                        text: '\$ ${widget.product.price}',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}