import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hawker_app/providers/auth_provider.dart';
import 'package:hawker_app/utils/app_routes.dart';
import 'package:hawker_app/utils/constants.dart';
import 'package:hawker_app/widgets/animated_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Constants.longAnimationDuration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _controller.forward();

    _initializeApp();
  }

  Future<void> _initializeApp() async {
    try {
      // Initialize auth state
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      await authProvider.initAuth();

      // Delay for splash screen animation
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        // Navigate based on auth state
        if (authProvider.isLoggedIn) {
          if (authProvider.isUser) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.userDashboard);
          } else if (authProvider.isHawker) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.hawkerDashboard);
          } else if (authProvider.isAdmin) {
            Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
          } else {
            Navigator.of(context).pushReplacementNamed(AppRoutes.login);
          }
        } else {
          Navigator.of(context).pushReplacementNamed(AppRoutes.login);
        }
      }
    } catch (e) {
      debugPrint('Error during initialization: $e');
      if (mounted) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.login);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor.withOpacity(0.8),
            ],
          ),
        ),
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const AnimatedLogo(size: 120),
                      const SizedBox(height: 24),
                      Text(
                        Constants.appName,
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Connect with nearby hawkers real-time',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 48),
                      const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}