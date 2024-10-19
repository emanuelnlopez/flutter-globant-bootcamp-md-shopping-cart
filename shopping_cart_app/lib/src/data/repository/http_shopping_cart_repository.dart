import 'dart:convert';
import 'dart:io';

import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:http/http.dart' as http;


class HttpShoppingCartRepository implements ShoppingCartRepository {
  @override
  Future<List<Product>> getAllProducts() async {
    final uri = Uri.parse(ShoppingCartRepository.apiProducts);

    final response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final shoppingCartList = Product.fromDynamicList(
        json.decode(response.body),
      );
      
      return shoppingCartList;
    }
    else {
      throw Exception('Failed to load shopping cart data.');
    }
  }

  @override
  Future<List<User>> getAllUsers() async {
    final uri = Uri.parse(ShoppingCartRepository.apiUsers);

    final response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      final userList = User.fromDynamicList(
        json.decode(response.body),
      );

      return userList;
    }
    else {
      throw Exception('Failed to load user data.');
    }
  }

  @override
  Future<User> addANewUser(Map<String, dynamic> requestBody) async {
    final uri = Uri.parse(ShoppingCartRepository.apiUsers);

    final response = await http.post(uri, 
      body: jsonEncode(requestBody),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200 || response.statusCode == 201) { 
      final newUser = User.fromDynamic({
        'id': json.decode(response.body)['id'],
        ...requestBody
      });

      return newUser;
    }
    else {
      throw Exception('Failed to create a new user.');
    }
  }

  @override
  Future<User> getASingleUser(int id) async {
    final uri = Uri.parse('${ShoppingCartRepository.apiGetUser}$id');

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final userFound = User.fromDynamic(
        json.decode(response.body)
      );

      return userFound;
    }
    else {
      throw Exception('Failed to fetch a user with id: $id');
    }
  }
}