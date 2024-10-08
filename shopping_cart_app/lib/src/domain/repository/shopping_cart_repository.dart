import 'package:shopping_cart_app/src/domain/domain.dart';

abstract class ShoppingCartRepository {
  static const endpoint = 'https://fakestoreapi.com/products';

  Future<List<Product>> getAllProducts();
}