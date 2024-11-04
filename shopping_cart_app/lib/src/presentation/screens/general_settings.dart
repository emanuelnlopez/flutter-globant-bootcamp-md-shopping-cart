import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_app/src/domain/domain.dart';
import 'package:shopping_cart_app/src/presentation/presentation.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({
    required this.userId,
    super.key
  });

  final int userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('General settings'),
      ),
      body: FutureBuilder<User?>(
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

          return SingleChildScrollView(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  onTap: () => GoRouter.of(context).push(
                    '/userProfile/${user.id}',
                  ),
                  subtitle: Text(user.username),
                  title: const Text('User profile'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: const Icon(Icons.notifications),
                  onTap: () => GoRouter.of(context).push(
                    '/settings',
                  ),
                  subtitle: const Text('Theme, Notifications, etc'),
                  title: const Text('Settings'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  onTap: () => GoRouter.of(context).push(
                    '/addresses',
                  ),
                  subtitle: const Text('Manage your shipping addresses'),
                  title: const Text('Addresses'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: const Icon(Icons.credit_card),
                  onTap: () => GoRouter.of(context).push(
                    '/payment-methods/${user.id}',
                  ),
                  subtitle: const Text('Manage your saved payment methods'),
                  title: const Text('Payment methods'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: const Icon(Icons.help_center),
                  onTap: () => GoRouter.of(context).push(
                    '/termsNconditions',
                  ),
                  subtitle: const Text('Learn more about the app'),
                  title: const Text('Terms and Conditions'),
                  trailing: const Icon(Icons.chevron_right),
                ),
                ListTile(
                  leading: const Icon(Icons.exit_to_app_sharp),
                  onTap: () async {
                    await context.read<UserController>().logOut();

                    if (context.mounted) {
                      GoRouter.of(context).go('/login');
                    }
                  },
                  subtitle: const Text('End user session'),
                  title: const Text('Log out'),
                  trailing: const Icon(Icons.chevron_right),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}