import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<bool> _switchStates = List.generate(6, (_) => false);

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = context.watch<ApplicationPreferences>().darkMode;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Remember that you will receive notifications of your order in progress,'
              ' but you can personalize the following communications.',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            const Divider(
              height: 40,
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.blueAccent,
            ),
            const Text(
              'Pushes',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            _buildSettingsRow(
              title: 'Promotions', 
              description: 'Find out about exclusive offers and promotions.', 
              switchIndex: 0,
            ),
            _buildSettingsRow(
              title: 'Vouchers', 
              description: 'Do not miss vouchers or discounts.', 
              switchIndex: 1,
            ),
            _buildSettingsRow(
              title: 'Polls', 
              description: 'Comment on your experience in the app.', 
              switchIndex: 2,
            ),
            _buildSettingsRow(
              title: 'News', 
              description: 'Discover new sections and functions of the app.', 
              switchIndex: 3,
            ),
            _buildSettingsRow(
              title: 'Challenges', 
              description: 'Follow the status of your challenges and prizes', 
              switchIndex: 4,
            ),
            const Divider(
              height: 40,
              thickness: 2,
              indent: 10,
              endIndent: 10,
              color: Colors.blueAccent,
            ),
            const Text(
              'Theme',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            _buildSettingsRow(
              title: 'Theme mode', 
              description: 'Change to the mode you like best!', 
              switchIndex: 5,
              initialValue: isDarkMode,
              onToggle: (value) {
                setState(() {
                  context.read<ApplicationPreferences>().setDarkMode(value);
                });
              }
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsRow({
  required String title,
  required String description,
  required int switchIndex,
  bool? initialValue,
  Function(bool)? onToggle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 17.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(description)
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 30,
        ),
        Switch(
          value: initialValue ?? _switchStates[switchIndex], 
          onChanged: (value) {
            setState(() {
              _switchStates[switchIndex] = value;
            });

            if (onToggle != null) {
              onToggle(value);
            }
          },
          activeColor: Colors.blueAccent,
          activeTrackColor: Colors.blue[200],
          inactiveThumbColor: Colors.grey,
          inactiveTrackColor: Colors.black,
        ),
      ],
    );
  }
}

