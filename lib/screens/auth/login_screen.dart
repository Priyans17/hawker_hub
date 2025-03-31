// login-screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hawker_app/providers/auth_provider.dart';
import 'package:hawker_app/utils/app_routes.dart';
import 'package:hawker_app/utils/app_theme.dart';
import 'package:hawker_app/utils/constants.dart';
import 'package:hawker_app/utils/helpers.dart';
import 'package:hawker_app/widgets/custom_button.dart';
import 'package:hawker_app/widgets/custom_text_field.dart';
import 'package:hawker_app/widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  String _userType = Constants.userType;
  bool _isPasswordVisible = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Constants.mediumAnimationDuration,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.login(email, password);

    if (mounted) {
      if (success) {
        Helpers.showSnackBar(context, Constants.loginSuccessMessage);

        if (authProvider.isUser) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.userDashboard);
        } else if (authProvider.isHawker) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.hawkerDashboard);
        } else if (authProvider.isAdmin) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.adminDashboard);
        }
      } else {
        Helpers.showSnackBar(
          context,
          Constants.invalidCredentialsMessage,
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: size.height - MediaQuery.of(context).padding.top,
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 40),
                    Center(
                      child: Text(
                        'Welcome Back',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Login to your account',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // User type selector
                    Container(
                      decoration: BoxDecoration(
                        color:
                            isDarkMode ? AppTheme.darkCardColor : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          _buildUserTypeButton(Constants.userType, 'User'),
                          _buildUserTypeButton(Constants.hawkerType, 'Hawker'),
                          _buildUserTypeButton(Constants.adminType, 'Admin'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Login form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Constants.emptyFieldMessage;
                              }
                              if (!Helpers.isValidEmail(value)) {
                                return Constants.invalidEmailMessage;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _passwordController,
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: Icons.lock,
                            obscureText: !_isPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Constants.emptyFieldMessage;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),

                          // Remember me and forgot password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Checkbox(
                                    value: _rememberMe,
                                    onChanged: (value) {
                                      setState(() {
                                        _rememberMe = value ?? false;
                                      });
                                    },
                                  ),
                                  const Text('Remember me'),
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(AppRoutes.forgotPassword);
                                },
                                child: const Text('Forgot Password?'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Login button
                          CustomButton(
                            text: 'Login',
                            isLoading: authProvider.isLoading,
                            onPressed: _login,
                          ),
                          const SizedBox(height: 24),

                          // Or divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: Text(
                                  'OR',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Social login buttons
                          SocialLoginButton(
                            text: 'Continue with Google',
                            icon: 'assets/icons/google.png',
                            onPressed: () {
                              // TODO: Implement Google login
                            },
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed(AppRoutes.signup);
                          },
                          child: const Text('Sign Up'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserTypeButton(String userType, String label) {
    final isSelected = _userType == userType;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _userType = userType;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : Theme.of(context).textTheme.bodyLarge!.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}