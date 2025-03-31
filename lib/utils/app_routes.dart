// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:hawker_app/models/hawker_model.dart';

// Auth Screens
import 'package:hawker_app/screens/splash_screen.dart';
import 'package:hawker_app/screens/auth/login_screen.dart';
import 'package:hawker_app/screens/auth/signup_screen.dart';
import 'package:hawker_app/screens/auth/otp_verification_screen.dart';

// User Screens
import 'package:hawker_app/screens/user/hawker_details_screen.dart';
import 'package:hawker_app/screens/user/map_screen.dart';
import 'package:hawker_app/screens/user/order_history_screen.dart';
import 'package:hawker_app/screens/user/order_screen.dart';
import 'package:hawker_app/screens/user/order_tracking_screen.dart';
import 'package:hawker_app/screens/user/payment_screen.dart';
import 'package:hawker_app/screens/user/return_request_screen.dart';
import 'package:hawker_app/screens/user/user_dashboard_screen.dart';

// Hawker Screens
import 'package:hawker_app/screens/hawker/hawker_dashboard_screen.dart';
import 'package:hawker_app/screens/hawker/hawker_registration_screen.dart';
import 'package:hawker_app/screens/hawker/hawker_verification_screen.dart';

// Admin Screens
import 'package:hawker_app/screens/admin/admin_dashboard_screen.dart';
import 'package:hawker_app/screens/admin/analytics_screen.dart';
import 'package:hawker_app/screens/admin/hawker_approval_screen.dart';
import 'package:hawker_app/screens/admin/inventory_management_screen.dart';
import 'package:hawker_app/screens/admin/return_approval_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String otpVerification = '/otp-verification';
  static const String userDashboard = '/user-dashboard';
  static const String mapScreen = '/map-screen';
  static const String hawkerDetails = '/hawker-details';
  static const String orderScreen = '/order-screen';
  static const String orderTracking = '/order-tracking';
  static const String paymentScreen = '/payment-screen';
  static const String orderHistory = '/order-history';
  static const String returnRequest = '/return-request';
  static const String hawkerRegistration = '/hawker-registration';
  static const String hawkerVerification = '/hawker-verification';
  static const String hawkerDashboard = '/hawker-dashboard';
  static const String inventoryManagement = '/inventory-management';
  static const String orderManagement = '/order-management';
  static const String adminDashboard = '/admin-dashboard';
  static const String hawkerApproval = '/hawker-approval';
  static const String returnApproval = '/return-approval';
  static const String analytics = '/analytics';

  static HawkerModel hawker1 = HawkerModel(
    id: '1',
    userId: '101',
    name: 'Ramesh Fruits',
    phone: '9876543201',
    aadharNumber: '123456789012',
    govtIdType: 'Aadhar',
    govtIdNumber: '123456789012',
    isVerified: true,
    isApproved: true,
    profileImage: null,
    rating: 4.5,
    totalOrders: 120,
    totalReviews: 45,
    createdAt: DateTime.now().subtract(const Duration(days: 120)),
    updatedAt: DateTime.now(),
    currentLatitude: 28.6129,
    currentLongitude: 77.2295,
    isOnline: true,
    areas: ['Connaught Place', 'Janpath', 'Rajiv Chowk'],
    address: 'Connaught Place, New Delhi',
  );
  // Route map
  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignupScreen(),
    otpVerification: (context) => const OtpVerificationScreen(),
    userDashboard: (context) => const UserDashboardScreen(),
    mapScreen: (context) => const MapScreen(),
    hawkerDetails: (context) => HawkerDetailsScreen(hawker: hawker1),
    // orderScreen: (context) => const OrderManagement(),
    orderTracking: (context) => const OrderTrackingScreen(order: {}),
    paymentScreen:
        (context) =>
            const PaymentScreen(amount: 34, paymentMethod: '', orderId: ''),
    orderHistory: (context) => const OrderHistoryScreen(),
    returnRequest: (context) => const ReturnRequestScreen(order: {}),
    hawkerRegistration: (context) => const HawkerRegistration(),
    hawkerVerification: (context) => const HawkerVerification(),
    hawkerDashboard: (context) => const HawkerDashboard(),
    inventoryManagement: (context) => const InventoryManagementScreen(),
    orderManagement:
        (context) => OrderScreen(
          hawker: hawker1,
          inventory: const [],
          cartItems: const {},
        ),
    //adminDashboard: (context) => const AdminDashboardScreen(),
    hawkerApproval: (context) => const HawkerApprovalScreen(),
    returnApproval: (context) => const ReturnApprovalScreen(),
    analytics: (context) => const AnalyticsScreen(),
  };
}
