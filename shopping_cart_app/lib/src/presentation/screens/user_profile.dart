import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({
    required this.userId,
    super.key
  });

  final int userId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: context.read<UserController>().getUserById(userId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else if (snapshot.hasError) {
          return const Center(
            child: Text('Error loading user data.'),
          );
        }
        else if (!snapshot.hasData || snapshot.data == null) {
          return const Center(
            child: Text('User not found.'),
          );
        }

        final user = snapshot.data!;
    
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
    );
  }
}