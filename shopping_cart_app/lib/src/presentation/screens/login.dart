import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/presentation/state/user_controller.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Container(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 40,
                      offset: Offset(0, 0),
                      spreadRadius: 0,
                      blurStyle: BlurStyle.outer,
                      color: Colors.blueAccent,
                    )
                  ]
                ),
                child: Image.asset(
                  'assets/images/image.png', 
                  width: 500,
                  height: 250,
                ),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    final username = usernameController.text;
                    final password = passwordController.text;

                    if (username.isEmpty || password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.blue,
                          content: Text('Please complete all fields.')
                        )
                      );
                      return;
                    }

                    final user = await context.read<UserController>().validateUserCredentials(username, password);

                    if (user != null) {
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                          context, 
                          '/products',
                          arguments: user.id
                        );
                      }
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Incorrect user or password.'),
                        )
                      );
                    }
                  }, 
                  child: const Text('Login')
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context, 
                      '/signUp',
                    );
                  }, 
                  child: const Text('Sign up')
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}