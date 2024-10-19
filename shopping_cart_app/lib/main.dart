import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_app/src/data/data.dart';
import 'package:shopping_cart_app/src/presentation/screens/about_app.dart';
import 'package:shopping_cart_app/src/presentation/screens/address_management.dart';
import 'package:shopping_cart_app/src/presentation/screens/app_start.dart';
import 'package:shopping_cart_app/src/presentation/screens/login.dart';
import 'package:shopping_cart_app/src/presentation/screens/payment_methods.dart';
import 'package:shopping_cart_app/src/presentation/screens/products_list.dart';
import 'package:shopping_cart_app/src/presentation/screens/general_settings.dart';
import 'package:shopping_cart_app/src/presentation/screens/settings.dart';
import 'package:shopping_cart_app/src/presentation/screens/sign_up.dart';
import 'package:shopping_cart_app/src/presentation/screens/user_profile.dart';
import 'package:shopping_cart_app/src/presentation/state/application_preferences.dart';
import 'package:shopping_cart_app/src/presentation/state/shopping_cart_controller.dart';
import 'package:shopping_cart_app/src/presentation/state/user_controller.dart';

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
        ),
        ChangeNotifierProvider<UserController>.value(
          value: UserController(preferences: sharedPreferences, shoppingCartRepository: HttpShoppingCartRepository()),
        ),
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
        theme: ThemeData.light(),
        themeMode: prefs.darkMode ? ThemeMode.dark : ThemeMode.light,
        title: 'Shopping Cart App',
        initialRoute: '/',
        routes: {
          '/': (context) => const AppStart(),
          '/login': (context) => const Login(),
          '/signUp': (context) => const SignUp(),
          '/products': (context) => const ProductsListScreen(),
          '/userProfile': (context) => const UserProfile(),
          '/generalSettings': (context) => const GeneralSettings(),
          '/termsNconditions': (context) => const TermsAndConditions(),
          '/addresses': (context) => const AddressManagement(),
          '/payment-methods': (context) => const PaymentMethods(),
          '/settings': (context) => const Settings(),
        },
      )
    );
  }
} 
      