import 'dart:convert';
import 'dart:io';

import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:http/http.dart' as http;


class HttpShoppingCartRepository implements ShoppingCartRepository {
  @override
  Future<List<Product>> getAllProducts() async {
    final uri = Uri.parse(ShoppingCartRepository.endpoint);

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

}