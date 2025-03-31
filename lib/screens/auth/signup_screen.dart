// signup-screen.dart
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

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String _userType = Constants.userType;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _agreeToTerms = true;
  
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
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text.trim();
    
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    
    final success = await authProvider.signup(name, email, phone, password, _userType);
    
    if (mounted) {
      if (success) {
        Helpers.showSnackBar(context, Constants.signupSuccessMessage);
        Navigator.of(context).pushReplacementNamed(AppRoutes.otpVerification);
      } else {
        Helpers.showSnackBar(
          context, 
          Constants.unknownErrorMessage,
          isError: true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    Center(
                      child: Text(
                        'Create Account',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        'Sign up to get started',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    // User type selector
                    Container(
                      decoration: BoxDecoration(
                        color: isDarkMode ? AppTheme.darkCardColor : Colors.white,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Signup form
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomTextField(
                            controller: _nameController,
                            labelText: 'Full Name',
                            hintText: 'Enter your full name',
                            prefixIcon: Icons.person,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Constants.emptyFieldMessage;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
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
                            controller: _phoneController,
                            labelText: 'Phone Number',
                            hintText: 'Enter your phone number',
                            prefixIcon: Icons.phone,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Constants.emptyFieldMessage;
                              }
                              if (!Helpers.isValidPhone(value)) {
                                return Constants.invalidPhoneMessage;
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
                                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
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
                              if (!Helpers.isValidPassword(value)) {
                                return Constants.invalidPasswordMessage;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: _confirmPasswordController,
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            prefixIcon: Icons.lock,
                            obscureText: !_isConfirmPasswordVisible,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isConfirmPasswordVisible ? Icons.visibility_off : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                                });
                              },
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return Constants.emptyFieldMessage;
                              }
                              if (value != _passwordController.text) {
                                return Constants.passwordMismatchMessage;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          
                          // Terms and conditions
                          Row(
                            children: [
                              Checkbox(
                                value: _agreeToTerms,
                                onChanged: (value) {
                                  setState(() {
                                    _agreeToTerms = value ?? true;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  'I agree to the Terms and Conditions and Privacy Policy',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          // Signup button
                          CustomButton(
                            text: 'Sign Up',
                            isLoading: authProvider.isLoading,
                            onPressed: _signup,
                          ),
                          const SizedBox(height: 24),
                          
                          // Or divider
                          Row(
                            children: [
                              const Expanded(child: Divider()),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Text(
                                  'OR',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              const Expanded(child: Divider()),
                            ],
                          ),
                          const SizedBox(height: 24),
                          
                          // Social signup button
                          SocialLoginButton(
                            text: 'Continue with Google',
                            icon: 'assets/icons/google.png',
                            onPressed: () {
                              // TODO: Implement Google signup
                            },
                          ),
                          const SizedBox(height: 24),
                          
                          // Login link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account? ',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacementNamed(AppRoutes.login);
                                },
                                child: const Text('Login'),
                              ),
                            ],
                          ),
                        ],
                      ),
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
            color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyLarge!.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}