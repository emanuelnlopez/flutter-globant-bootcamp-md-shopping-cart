import 'package:flutter/material.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';

class UserItem extends StatelessWidget {
  const UserItem({
    super.key,
    required this.user, 
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blueAccent,
                child: Text(
                  user.initials,
                  style: const TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                user.fullName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '@${user.username}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                height: 10,
                thickness: 5,
                indent: 50,
                endIndent: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 25),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Icon(Icons.home)
                        ),
                        Expanded(
                          child: Text(
                            '${user.city}, ${user.street}, No. ${user.streetNumber}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ) 
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Icon(Icons.phone)
                        ),
                        Expanded(
                          child: Text(
                            user.phoneNumber,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          )
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 60,
                          child: Icon(Icons.email)
                        ),
                        Expanded(
                          child: Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ) 
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ), 
      ),
    );
  }
}