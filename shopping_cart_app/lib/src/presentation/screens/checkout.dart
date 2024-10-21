import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';
import 'package:intl/intl.dart';

class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  late final ShoppingCartController _shoppingCartController;
  bool _isExpanded = false;
  final double _buttonWidth = 150;

  @override
  void initState() {
    super.initState();

    _shoppingCartController = context.read<ShoppingCartController>();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _shoppingCartController.getAllProducts(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<ApplicationPreferences>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product order'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder(
        stream: _shoppingCartController.shoppingCartStream, 
        builder: (context, snapshot) {
          late Widget result;

          if (snapshot.hasError) {
            return result = Center(
              child: Text(snapshot.error.toString()),
            );
          }
          else if (!snapshot.hasData) {
            return result = const Center(
              child: CircularProgressIndicator(),
            );
          }
          else {
             var productList = snapshot.data!;

              var productsInCart = productList.where(
                (product) => prefs.addedToShoppingCart.contains(product.id),
              ).toList();

              _shoppingCartController.addProductToCart(productsInCart);

              if (productsInCart.isEmpty) {
                return const Center(
                  child: Text('No products in the shopping cart yet.'),
                );
              }

              result = _ProductsListBody(productsList: productsInCart);
              
              return result;
          }
        }
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        color: Colors.blueAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total:',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.black,
              )
            ),
            StreamBuilder<List<Product>>(
              stream: _shoppingCartController.shoppingCartStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  double totalPrice = _shoppingCartController.calculateTotalPrice();

                  return Text(
                    formatCurrency(totalPrice),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  );
                }
                else {
                  return Text(
                    formatCurrency(0.0),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: StreamBuilder<List<Product>>(
        stream: context.read<ShoppingCartController>().shoppingCartStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const SizedBox.shrink(); 
          }
          return Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isExpanded ? MediaQuery.of(context).size.width : _buttonWidth,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isExpanded = true;

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processing payment...'),
                        duration: Duration(seconds: 5),
                      ),
                    );
                    
                    Future.delayed(const Duration(milliseconds: 500), () {
                      setState(() {
                        _isExpanded = false;
                  
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Confirmed payment'),
                            duration: Duration(seconds: 2),
                            backgroundColor: Colors.green,
                          ),
                        );
                      });
                    });
                  
                    Future.delayed(const Duration(seconds: 7), () {
                      _shoppingCartController.clearCart();
                              
                      GoRouter.of(context).pop();
                    });
                  });
                }, 
                icon: const Icon(Icons.check),
                label: const Text('Confirm'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: prefs.darkMode ? Colors.black : Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  textStyle: const TextStyle(
                    fontSize: 16,
                  )
                ),
              ),
            ),
          );      
        }
      )
    );
  }

  String formatCurrency(double amount) {
    final format = NumberFormat.currency(locale: 'en_US', symbol: '\$', decimalDigits: 2);

    return format.format(amount);
  }
}

class _ProductsListBody extends StatefulWidget {
  const _ProductsListBody({
    required this.productsList
  });

  final List<Product> productsList;

  @override
  State<_ProductsListBody> createState() => _ProductsListBodyState();
}

class _ProductsListBodyState extends State<_ProductsListBody> {
  double totalPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, right: 7.0, left: 7.0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.productsList.length,
              itemBuilder: (context, index) {
                final product = widget.productsList[index];
                totalPrice = totalPrice + widget.productsList[index].price;
            
                return Card(
                  color: Colors.blueGrey[500],
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: ListTile(
                    leading: const Icon(Icons.arrow_right,),
                    title: Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                      "Price: \$${product.price}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}