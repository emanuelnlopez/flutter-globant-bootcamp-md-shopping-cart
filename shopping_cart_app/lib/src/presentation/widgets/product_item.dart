import 'package:flutter/material.dart';
import 'package:shopping_cart_app/src/domain/model/product.dart';
import 'package:shopping_cart_app/src/presentation/screens/product_detail.dart';
import 'package:shopping_cart_app/src/presentation/widgets/product_image.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  final bool isInShoppingCart;
  final VoidCallback onShoppingCartPressed;
  
  const ProductItem({
    super.key,
    required this.product,
    required this.isInShoppingCart,
    required this.onShoppingCartPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetail(product: product)
          )
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.id.toString(),
              style: theme.textTheme.labelSmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ProductImage(
                height: 60,
                width: 50,
                tag: product.id,
                url: product.image,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    product.category.toUpperCase(),
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                '\$ ${product.price.toStringAsFixed(2)}',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.end,
              ),
            ),
            IconButton(
              onPressed: onShoppingCartPressed,
              icon: Icon(
                isInShoppingCart ? Icons.shopping_cart_rounded : Icons.shopping_cart_outlined,
                color: isInShoppingCart ? Colors.blue : null,
              )
            )
          ],
        ),
      ),
    );
  }
}