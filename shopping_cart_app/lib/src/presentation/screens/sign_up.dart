import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/state/user_controller.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    super.key,
    this.user,  
  });

  final User? user;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final ScrollController _scrollController = ScrollController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _numberStreetController = TextEditingController();
  final TextEditingController _zipcodeController = TextEditingController();
  final TextEditingController _latController = TextEditingController();
  final TextEditingController _longController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        backgroundColor: Colors.blue,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20
          ),
          children: [
             const Text(
                'Personal data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _FormField(
                controller: _firstNameController, 
                labelText: 'First name', 
                prefixIcon: const Icon(Icons.badge_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a first name.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _lastNameController, 
                labelText: 'Last name', 
                prefixIcon: const Icon(Icons.badge_outlined),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a last name.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _usernameController,
                labelText: 'Username', 
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a username.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _passwordController,
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Divider(
                thickness: 5,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Adress data',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _FormField(
                controller: _cityController,
                labelText: 'City',
                prefixIcon: const Icon(Icons.location_city),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a city.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _streetController,
                labelText: 'Street',
                prefixIcon: const Icon(Icons.streetview),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a street.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _numberStreetController,
                labelText: 'Street number',
                prefixIcon: const Icon(Icons.home),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a street number.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _zipcodeController,
                labelText: 'Zipcode',
                prefixIcon: const Icon(Icons.local_post_office),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a zipcode.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _latController,
                labelText: 'Latitude',
                prefixIcon: const Icon(Icons.my_location),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a latitude.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _longController,
                labelText: 'Longitude',
                prefixIcon: const Icon(Icons.explore),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a longitude.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 25,
              ),
              const Divider(
                thickness: 5,
              ),
              const SizedBox(
                height: 25,
              ),
              const Text(
                'Contact Detail',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              _FormField(
                controller: _emailController,
                labelText: 'Email',
                prefixIcon: const Icon(Icons.mail_outline),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a email.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              _FormField(
                controller: _phoneController,
                labelText: 'Phone',
                prefixIcon: const Icon(Icons.phone),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a zipcode.';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      String message = await context.read<UserController>().signUp(
                        _emailController.text,
                        _usernameController.text,
                        _passwordController.text,
                        _firstNameController.text,
                        _lastNameController.text,
                        _cityController.text,
                        _streetController.text,
                        int.parse(_numberStreetController.text),
                        _zipcodeController.text,
                        _latController.text,
                        _longController.text,
                        _phoneController.text,
                      );

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: message.startsWith('Error') ? Colors.red : Colors.green,
                          duration: const Duration(seconds: 5),
                          content: Text(message)
                        ),
                      );

                      if (context.mounted && !message.startsWith('Error')) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login',
                          (Route<dynamic> route) => false,
                        );
                      }
                    }
                    else {
                      _scrollToFirstError();
                    }
                  },  
                  label: const Text('Save'),
                  icon: const Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.black
                  ),  
                )
              ),
            ],
          ),
        ),
    );
  }

  void _scrollToFirstError() {
    final firstInvalidField = _formKey.currentState?.validate() == false ? _formKey.currentState?.context : null;

    if (firstInvalidField != null) {
      _scrollController.animateTo(
        0.0, 
        duration: const Duration(seconds: 1), 
        curve: Curves.ease
      );
    }
  }
}

class _FormField extends StatelessWidget {
  const _FormField({
    required this.controller,
    required this.labelText,
    required this.validator,
    required this.prefixIcon,
  });

  final TextEditingController controller;
  final String labelText;
  final FormFieldValidator validator;
  final Icon prefixIcon;

  @override
  Widget build(BuildContext context) => TextFormField(
    controller: controller,
    decoration: InputDecoration(
      labelText: labelText,
      border: const OutlineInputBorder(),
      prefixIcon: prefixIcon,
    ),
    validator: validator,
  );
}