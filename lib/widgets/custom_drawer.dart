import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hawker_app/providers/auth_provider.dart';
import 'package:hawker_app/providers/theme_provider.dart';
import 'package:hawker_app/utils/app_routes.dart';
import 'package:hawker_app/utils/constants.dart';
import 'package:hawker_app/utils/helpers.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    final user = authProvider.user;
    final isDarkMode = themeProvider.isDarkMode;
    
    return Drawer(
      child: Column(
        children: [
          // Drawer header
          UserAccountsDrawerHeader(
            accountName: Text(user?.name ?? 'User'),
            accountEmail: Text(user?.email ?? 'user@example.com'),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Text(
                user?.name.isNotEmpty == true
                    ? user!.name[0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          
          // Drawer items
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(AppRoutes.userDashboard);
            },
          ),
          ListTile(
            leading: const Icon(Icons.map),
            title: const Text('Find Hawkers'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRoutes.mapScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(AppRoutes.orderHistory);
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favorite Hawkers'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Navigate to favorite hawkers screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Saved Addresses'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Navigate to saved addresses screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.of(context).pop();
              // TODO: Navigate to settings screen
            },
          ),
          
          // Theme toggle
          ListTile(
            leading: Icon(isDarkMode ? Icons.light_mode : Icons.dark_mode),
            title: Text(isDarkMode ? 'Light Mode' : 'Dark Mode'),
            onTap: () {
              themeProvider.toggleThemeMode();
            },
          ),
          
          const Divider(),
          
          // Logout
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              final confirmed = await Helpers.showConfirmationDialog(
                context,
                title: 'Logout',
                message: 'Are you sure you want to logout?',
                confirmText: 'Logout',
                cancelText: 'Cancel',
              );
              
              if (confirmed && context.mounted) {
                Navigator.of(context).pop();
                await authProvider.logout();
                Navigator.of(context).pushReplacementNamed(AppRoutes.login);
              }
            },
          ),
          
          const Spacer(),
          
          // App version
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Version ${Constants.appVersion}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }
}

