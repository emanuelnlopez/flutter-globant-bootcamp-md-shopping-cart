import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/screens/checkout.dart';
import 'package:shopping_cart_app/src/presentation/state/application_preferences.dart';
import 'package:shopping_cart_app/src/presentation/state/shopping_cart_controller.dart';
import 'package:shopping_cart_app/src/presentation/widgets/product_item.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  late final ShoppingCartController _shoppingCartController;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();

    _shoppingCartController = context.read<ShoppingCartController>();

    WidgetsBinding.instance.addPostFrameCallback( 
      (_) => _shoppingCartController.getAllProducts(),
    );
  }

  @override
  void dispose() {
    _shoppingCartController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = context.watch<ApplicationPreferences>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(prefs.onlyInShoppingCart ? 'Selected products' : 'List of products'),
        actions: [
          IconButton(
            onPressed: prefs.toggleOnlyInShoppingCart,
            icon: Icon(
              prefs.onlyInShoppingCart ? Icons.shopping_cart_rounded : Icons.shopping_cart_outlined,
              color: prefs.onlyInShoppingCart ? Colors.black : null,
            )
          ),
          IconButton(
            onPressed: prefs.toggleTheme, 
            icon: Icon(
              prefs.darkMode ? Icons.dark_mode : Icons.dark_mode_outlined,
              color: prefs.darkMode ? Colors.black : null,
            )
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => _shoppingCartController.getAllProducts(),
        child: StreamBuilder(
          stream: _shoppingCartController.shoppingCartStream, 
          builder: (context, snapshot) {
            late Widget result;

            if (snapshot.hasError) {
              result = Center(
                child: Text(snapshot.error.toString()),
              );
            }
            else if (!snapshot.hasData) {
              result = const Center(
                child: CircularProgressIndicator(),
              );
            }
            else {
              var productsList = snapshot.data!;

              if (prefs.onlyInShoppingCart) {
                productsList = productsList.where(
                  (product) => prefs.addedToShoppingCart.contains(product.id)
                ).toList();
              }

              result = _ProductsListBody(productsList: productsList);
            }

            return result;
          }
        ),
      ),
      floatingActionButton: AnimatedScale(
        scale: isClicked ? 1.5 : 1.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            setState(() {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Processing your purchase...'),
                  duration: Duration(seconds: 2),
                ),
              );
              isClicked = true;
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => const Checkout())
              ).then((_) {
                _shoppingCartController.getAllProducts();
              });
            });

            Future.delayed(const Duration(milliseconds: 200), () {
              setState(() {
                isClicked = false;
              });

            });
          },

          backgroundColor: Colors.blue,
          shape: const CircleBorder(),
          tooltip: 'Finalize purchase',
          splashColor:  Colors.indigo,
          child: const Icon(
            Icons.shopping_cart_checkout,
          ),
        ),
      ),
    );
  }
}

class _ProductsListBody extends StatelessWidget {
  const _ProductsListBody({
    required this.productsList,
  });

  final List<Product> productsList;

  @override
  Widget build(BuildContext context) {
    final prefs = context.read<ApplicationPreferences>();

    return ListView.separated(
      itemCount: productsList.length,
      itemBuilder: (context, index) {
        final product = productsList[index];

        return ProductItem(
          product: product,
          isInShoppingCart: prefs.addedToShoppingCart.contains(product.id),
          onShoppingCartPressed: () => prefs.toggleAddedToShoppingCart(product.id),
        );
      },
      separatorBuilder: (_, __) => const Divider(
        endIndent: 0.0,
        height: 1.0,
        indent: 0.0,
        thickness: 3.0,
      ),
    );
  }
}