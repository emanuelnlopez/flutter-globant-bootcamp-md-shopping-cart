import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_cart_app/src/data/data.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';

abstract class PreferencesKeys {
  static const loggedIn = 'loggedIn';
}

class UserController with ChangeNotifier {
  UserController({
    required SharedPreferences preferences,
    required this.shoppingCartRepository,
  }) : _preferences = preferences {
    _loggedIn = _preferences.getBool(PreferencesKeys.loggedIn) ?? false;
  }

  final SharedPreferences _preferences;
  final HttpShoppingCartRepository shoppingCartRepository;

  late bool _loggedIn;

  bool get isLoggedIn => _loggedIn;

  Future<void> logIn() async {
    await _preferences.setBool(PreferencesKeys.loggedIn, true);

    _loggedIn = true;
    notifyListeners();
  }

  Future<void> logOut() async {
    await _preferences.setBool(PreferencesKeys.loggedIn, false);

    _loggedIn = false;
    notifyListeners();
  }

  Future<String> signUp(
    String email, 
    String username, 
    String password, 
    String firstName, 
    String lastName, 
    String city, 
    String street, 
    int streetNumber, 
    String zipcode, 
    String latitude, 
    String longitude, 
    String phoneNumber
    ) async {
      final Map<String, dynamic> requestBody = {
        'email': email,
        'username': username,
        'password': password,
        'name': {
          'firstname': firstName,
          'lastname': lastName
        },
        'address': {
          'city': city,
          'street': street,
          'number': streetNumber,
          'zipcode': zipcode,
          'geolocation': {
            'lat': latitude,
            'long': longitude
          },
        },
        'phone': phoneNumber
      };

    bool isUserAlreadyExists = await isExistingUser(username);

    if (!isUserAlreadyExists) {
      try {
         await shoppingCartRepository.addANewUser(requestBody);

         return 'User account created successfully.';
      }
      catch (error) {   
        return 'Error creating account. Try again.';
      } 
    }
    else {
      return 'Error creating account. Existing username.';
    }
  }

  Future<User?> validateUserCredentials(String username, String password) async {
      final List<User> users = await shoppingCartRepository.getAllUsers();

      for (var user in users) {
        if (user.username == username && user.password == password) {
          await logIn();

          return user;
        }
      }

      return null;
  }

  Future<bool> isExistingUser(String username) async {
    final List<User> users = await shoppingCartRepository.getAllUsers();

    for (var user in users) {
      if (user.username == username) {
        return true;
      }
    }

    return false;
  }

  Future<User?> getUserById(int id) async {
    try {
      final user = await shoppingCartRepository.getASingleUser(id);

      return user;
    }
    catch (error) {
      print('Error fetching user: $error');
      return null;
    }
  }
}