import 'dart:async';

import 'package:shopping_cart_app/src/domain/domain.dart';

abstract class Dispose {
  void dispose();
}

class ShoppingCartController implements Dispose {
  ShoppingCartController({
    required ShoppingCartRepository shoppingCartRepository,
  }) : _shoppingCartRepository = shoppingCartRepository;

  final ShoppingCartRepository _shoppingCartRepository;

  final _shoppingCartStreamController = StreamController<List<Product>>.broadcast();

  Stream<List<Product>> get shoppingCartStream => _shoppingCartStreamController.stream;

  final List<Product> _shoppingCartProducts = [];

  void getAllProducts() async {
    try {
      final products = await _shoppingCartRepository.getAllProducts();

      _shoppingCartStreamController.add(products);
    }
    catch (error) {
      _shoppingCartStreamController.addError(error);
    }
  }

  void addProductToCart(List<Product> products) {
    _shoppingCartProducts.clear();
    _shoppingCartProducts.addAll(products);
    
    _shoppingCartStreamController.add(_shoppingCartProducts);
  }

  double calculateTotalPrice() {
    double total = 0;

    for (var product in _shoppingCartProducts) {
      total += product.price;
    }

    return total;
  }

  @override
  void dispose() {
    _shoppingCartStreamController.close();
  }

}