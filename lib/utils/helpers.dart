import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:hawker_app/utils/constants.dart';



class Helpers {
  // Format currency
  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(
      symbol: '₹',
      decimalDigits: 2,
      locale: 'en_IN',
    );
    return formatter.format(amount);
  }
  
  // Format date
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
  
  // Format time
  static String formatTime(DateTime time) {
    return DateFormat('hh:mm a').format(time);
  }
  
  // Format date and time
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }
  
  // Show snackbar
  static void showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Constants.errorColor : Constants.successColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
  
  // Show loading dialog
  static void showLoadingDialog(BuildContext context, {String message = 'Loading...'}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(message),
          ],
        ),
      ),
    );
  }
  
  // Show confirmation dialog
  static Future<bool> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }
  
  // Validate email
  static bool isValidEmail(String email) {
    return Constants.emailPattern.hasMatch(email);
  }
  
  // Validate phone
  static bool isValidPhone(String phone) {
    return Constants.phonePattern.hasMatch(phone);
  }
  
  // Validate password
  static bool isValidPassword(String password) {
    return Constants.passwordPattern.hasMatch(password);
  }
  
  // Validate OTP
  static bool isValidOtp(String otp) {
    return Constants.otpPattern.hasMatch(otp);
  }
  
  // Get order status color
  static Color getOrderStatusColor(String status) {
    switch (status) {
      case Constants.orderPlaced:
        return Colors.blue;
      case Constants.orderAccepted:
        return Colors.amber;
      case Constants.orderPacked:
        return Colors.orange;
      case Constants.orderDispatched:
        return Colors.purple;
      case Constants.orderDelivered:
        return Colors.green;
      case Constants.orderCompleted:
        return Colors.teal;
      case Constants.orderCancelled:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  // Get order status icon
  static IconData getOrderStatusIcon(String status) {
    switch (status) {
      case Constants.orderPlaced:
        return Icons.shopping_cart;
      case Constants.orderAccepted:
        return Icons.check_circle;
      case Constants.orderPacked:
        return Icons.inventory;
      case Constants.orderDispatched:
        return Icons.local_shipping;
      case Constants.orderDelivered:
        return Icons.home;
      case Constants.orderCompleted:
        return Icons.done_all;
      case Constants.orderCancelled:
        return Icons.cancel;
      default:
        return Icons.help;
    }
  }
  
  // Calculate distance between two coordinates (in kilometers)
  static double calculateDistance(
    double lat1, 
    double lon1, 
    double lat2, 
    double lon2
  ) {
    const double p = 0.017453292519943295; // Math.PI / 180
    final double a = 0.5 - 
      (0.5 * 
        (Math.cos((lat2 - lat1) * p) - 
         Math.cos(lat1 * p) * 
         Math.cos(lat2 * p) * 
         (1 - Math.cos((lon2 - lon1) * p))
        )
      );
    return 12742 * Math.asin(Math.sqrt(a)); // 2 * R; R = 6371 km
  }
}

// Math utility class for calculations
class Math {
  static double cos(double x) => math.cos(x);
  static double sin(double x) => math.sin(x);
  static double sqrt(double x) => math.sqrt(x);
  static double asin(double x) => math.asin(x);
}
