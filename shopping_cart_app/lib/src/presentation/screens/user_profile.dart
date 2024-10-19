import 'package:flutter/material.dart';
import 'package:shopping_cart_app/src/domain/model/user.dart';
import 'package:shopping_cart_app/src/presentation/widgets/user_item.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)?.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome ${user.username} !',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(3.0, 3.0),
                blurRadius: 3.0,
                color: Colors.black26,
              )
            ]
          ),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: UserItem(user: user),
    );
  }
}