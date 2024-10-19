import 'package:shopping_cart_app/src/domain/domain.dart';

abstract class ShoppingCartRepository {
  static const apiProducts = 'https://fakestoreapi.com/products';
  static const apiUsers = 'https://fakestoreapi.com/users';
  static const apiGetUser = 'https://fakestoreapi.com/users/';

  Future<List<Product>> getAllProducts();
  Future<List<User>> getAllUsers();
  Future<User> addANewUser(Map<String, dynamic> requestBody);
  Future<User> getASingleUser(int id);
}