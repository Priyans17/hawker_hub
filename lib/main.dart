import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hawker_app/providers/auth_provider.dart';
import 'package:hawker_app/providers/theme_provider.dart';
import 'package:hawker_app/providers/location_provider.dart';
import 'package:hawker_app/providers/hawker_provider.dart';
import 'package:hawker_app/providers/order_provider.dart';
import 'package:hawker_app/screens/splash_screen.dart';
import 'package:hawker_app/utils/app_routes.dart';
import 'package:hawker_app/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hawker App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.storefront,
              size: 80,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 16),
            Text(
              'Hawker App',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
