import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

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
        GoRouter.of(context).push(
          '/productDetail/${product.id}'
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
                formatCurrency(product.price),
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

  String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return format.format(amount);
  }
}