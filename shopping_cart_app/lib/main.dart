import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_app/src/data/data.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

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
    final routes = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const AppStart(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const Login(),
        ),
        GoRoute(
          path: '/signUp',
          builder: (context, state) => const SignUp(),
        ),
        GoRoute(
          path: '/products/:id',
          builder: (context, state) => ProductsListScreen(
            userId: int.parse(state.pathParameters['id']!)
          ),
        ),
        GoRoute(
          path: '/productDetail/:productId',
          builder: (context, state) => ProductDetail(
            productId: int.parse(state.pathParameters['productId']!)
          ),
        ),
        GoRoute(
          path: '/checkout',
          builder: (context, state) => const Checkout(),
        ),
        GoRoute(
          path: '/userProfile/:id',
          builder: (context, state) => UserProfile(
            userId: int.parse(state.pathParameters['id']!)
          ),
        ),
        GoRoute(
          path: '/generalSettings/:id',
          builder: (context, state) => GeneralSettings(
            userId: int.parse(state.pathParameters['id']!)
          ),
        ),
        GoRoute(
          path: '/termsNconditions',
          builder: (context, state) => const TermsAndConditions(),
        ),
        GoRoute(
          path: '/addresses',
          builder: (context, state) => const AddressManagement(),
        ),
        GoRoute(
          path: '/payment-methods/:id',
          builder: (context, state) => PaymentMethods(
            userId: int.parse(state.pathParameters['id']!)
          ),
        ),
        GoRoute(
          path: '/settings',
          builder: (context, state) => const Settings(),
        ),
      ] 
    );

    return Consumer<ApplicationPreferences>(
      builder: (context, prefs, child) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        theme: ThemeData.light(),
        themeMode: prefs.darkMode ? ThemeMode.dark : ThemeMode.light,
        title: 'Shopping Cart App',
        routerConfig: routes,
      )
    );
  }
} 
      