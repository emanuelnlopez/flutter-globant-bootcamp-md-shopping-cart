import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_app/src/data/data.dart';
import 'package:shopping_cart_app/src/presentation/screens/products_list.dart';
import 'package:shopping_cart_app/src/presentation/state/application_preferences.dart';
import 'package:shopping_cart_app/src/presentation/state/shopping_cart_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    MultiProvider(
      providers: [
        Provider<ShoppingCartController>.value(
          value: ShoppingCartController(shoppingCartRepository: HttpShoppingCartRepository()),
        ),
        ChangeNotifierProvider<ApplicationPreferences>.value(
          value: ApplicationPreferences(preferences: sharedPreferences),
        )
      ],
      child: const ShoppingCartApp(),
    )
  );
}

class ShoppingCartApp extends StatelessWidget {
  const ShoppingCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationPreferences>(
      builder: (context, prefs, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        home: const ProductsListScreen(),
        theme: ThemeData.light(),
        themeMode: prefs.darkMode ? ThemeMode.dark : ThemeMode.light,
        title: 'Shopping Cart App',
      )
    );
  }
} 
      