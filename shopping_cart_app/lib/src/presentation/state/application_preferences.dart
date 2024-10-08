import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PreferencesKeys {
  static const darkMode = 'darkMode';
  static const addedToShoppingCart = 'addedToShoppingCart';
  static const onlyInShoppingCart = 'onlyInShoppingCart';
}

class ApplicationPreferences with ChangeNotifier, WidgetsBindingObserver {
  ApplicationPreferences({
    required SharedPreferences preferences,
  }) : _preferences = preferences {
    _addedToShoppingCart.addAll(
      _preferences.getStringList(PreferencesKeys.addedToShoppingCart)?.map((e) => int.parse(e)) ?? [],
    );
    _darkMode = _preferences.getBool(PreferencesKeys.darkMode) ?? false;
    _onlyInShoppingCart = _preferences.getBool(PreferencesKeys.onlyInShoppingCart) ?? false;

    WidgetsBinding.instance.addObserver(this);
  }

  final SharedPreferences _preferences;

  final _addedToShoppingCart = <int>{};
  late bool _darkMode;
  late bool _onlyInShoppingCart;

  Set<int> get addedToShoppingCart => _addedToShoppingCart;
  bool get darkMode => _darkMode;
  bool get onlyInShoppingCart => _onlyInShoppingCart;

  void toggleAddedToShoppingCart(int id) {
    if (_addedToShoppingCart.contains(id)) {
      _addedToShoppingCart.remove(id);
    }
    else {
      _addedToShoppingCart.add(id);
    }

    notifyListeners();
  }

  void toggleTheme() {
    _darkMode = !_darkMode;

    notifyListeners();
  }

  void toggleOnlyInShoppingCart() {
    _onlyInShoppingCart = !_onlyInShoppingCart;

    notifyListeners();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive) {
      _updatePreferences();
    }
  }

  void _updatePreferences() async {
    await _preferences.setStringList(
      PreferencesKeys.addedToShoppingCart,
      _addedToShoppingCart.map((e) => e.toString()).toList(growable: false),
    );
    await _preferences.setBool(
      PreferencesKeys.darkMode,
      _darkMode,
    );
    await _preferences.setBool(
      PreferencesKeys.onlyInShoppingCart,
      _onlyInShoppingCart,
    );
  }
}