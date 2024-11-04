import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

class AppStart extends StatefulWidget {
  const AppStart({super.key});

  @override
  State<AppStart> createState() => _AppStartState();
}

class _AppStartState extends State<AppStart> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      final userController = context.read<UserController>();
      var route = '/login';
      if (userController.isLoggedIn) {
        route = '/products/${userController.userId}';
      }
      GoRouter.of(context).pushReplacement(route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/lottie/shopping_cart.json',
              width: 450,
              height: 300,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Loading...',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
