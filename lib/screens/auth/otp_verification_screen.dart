// otp-verification-screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:hawker_app/providers/auth_provider.dart';
import 'package:hawker_app/utils/app_routes.dart';
import 'package:hawker_app/utils/constants.dart';
import 'package:hawker_app/utils/helpers.dart';
import 'package:hawker_app/widgets/custom_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  final List<TextEditingController> _otpControllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _resendSeconds = 30;
  bool _canResend = false;

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

    // Start resend timer
    _startResendTimer();
  }

  @override
  void dispose() {
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _animationController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    setState(() {
      _resendSeconds = 30;
      _canResend = false;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _resendSeconds--;
        });

        if (_resendSeconds > 0) {
          _startResendTimer();
        } else {
          setState(() {
            _canResend = true;
          });
        }
      }
    });
  }

  Future<void> _verifyOtp() async {
    final otp = _otpControllers.map((controller) => controller.text).join();

    if (otp.length != 6) {
      Helpers.showSnackBar(
        context,
        'Please enter a valid 6-digit OTP',
        isError: true,
      );
      return;
    }

    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    final success = await authProvider.verifyOtp(otp);

    if (mounted) {
      if (success) {
        Helpers.showSnackBar(context, Constants.otpVerificationSuccessMessage);

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
          Constants.invalidOtpMessage,
          isError: true,
        );
      }
    }
  }

  void _resendOtp() {
    if (!_canResend) {
      return;
    }

    // TODO: Implement resend OTP
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.resendOtp();

    _startResendTimer();

    Helpers.showSnackBar(context, 'OTP resent successfully');
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
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
                        'Verify Your Phone',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        'We have sent a verification code to your phone number',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Text(
                        authProvider.user?.phone ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // OTP input fields
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        6,
                        (index) => _buildOtpField(index),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Verify button
                    CustomButton(
                      text: 'Verify',
                      isLoading: authProvider.isLoading,
                      onPressed: _verifyOtp,
                    ),
                    const SizedBox(height: 24),

                    // Resend OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t receive the code? ',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: _canResend ? _resendOtp : null,
                          child: Text(
                            _canResend
                                ? 'Resend'
                                : 'Resend in $_resendSeconds s',
                          ),
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

  Widget _buildOtpField(int index) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          counterText: '',
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Theme.of(context).dividerColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 2,
            ),
          ),
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: (value) {
          if (value.isNotEmpty) {
            if (index < 5) {
              _focusNodes[index + 1].requestFocus();
            } else {
              _focusNodes[index].unfocus();
              // Auto-verify when all fields are filled
              _verifyOtp();
            }
          } else if (index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }
}