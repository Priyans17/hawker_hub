import 'dart:convert';
import 'package:flutter/material.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profileImage;
  final String userType; // 'user', 'hawker', 'admin'
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String> favoriteHawkers;
  final List<String> recentOrders;
  final String? address;
  final double? latitude;
  final double? longitude;
  final List<String>? preferredCategories;
  final Map<String, dynamic>? preferences;
  final String? fcmToken;
  final bool isVerified;
  final String? referralCode;
  final int loyaltyPoints;
  final List<String>? savedAddresses;
  final String? defaultPaymentMethod;
  final bool notificationsEnabled;
  final String? language;
  final String? theme;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profileImage,
    required this.userType,
    required this.createdAt,
    required this.updatedAt,
    this.favoriteHawkers = const [],
    this.recentOrders = const [],
    this.address,
    this.latitude,
    this.longitude,
    this.preferredCategories,
    this.preferences,
    this.fcmToken,
    this.isVerified = false,
    this.referralCode,
    this.loyaltyPoints = 0,
    this.savedAddresses,
    this.defaultPaymentMethod,
    this.notificationsEnabled = true,
    this.language = 'en',
    this.theme = 'system',
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profileImage: json['profile_image'],
      userType: json['user_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      favoriteHawkers: List<String>.from(json['favorite_hawkers'] ?? []),
      recentOrders: List<String>.from(json['recent_orders'] ?? []),
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      preferredCategories: json['preferred_categories'] != null 
          ? List<String>.from(json['preferred_categories']) 
          : null,
      preferences: json['preferences'],
      fcmToken: json['fcm_token'],
      isVerified: json['is_verified'] ?? false,
      referralCode: json['referral_code'],
      loyaltyPoints: json['loyalty_points'] ?? 0,
      savedAddresses: json['saved_addresses'] != null 
          ? List<String>.from(json['saved_addresses']) 
          : null,
      defaultPaymentMethod: json['default_payment_method'],
      notificationsEnabled: json['notifications_enabled'] ?? true,
      language: json['language'] ?? 'en',
      theme: json['theme'] ?? 'system',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profile_image': profileImage,
      'user_type': userType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'favorite_hawkers': favoriteHawkers,
      'recent_orders': recentOrders,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'preferred_categories': preferredCategories,
      'preferences': preferences,
      'fcm_token': fcmToken,
      'is_verified': isVerified,
      'referral_code': referralCode,
      'loyalty_points': loyaltyPoints,
      'saved_addresses': savedAddresses,
      'default_payment_method': defaultPaymentMethod,
      'notifications_enabled': notificationsEnabled,
      'language': language,
      'theme': theme,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static UserModel fromJsonString(String jsonString) {
    return UserModel.fromJson(jsonDecode(jsonString));
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    String? userType,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? favoriteHawkers,
    List<String>? recentOrders,
    String? address,
    double? latitude,
    double? longitude,
    List<String>? preferredCategories,
    Map<String, dynamic>? preferences,
    String? fcmToken,
    bool? isVerified,
    String? referralCode,
    int? loyaltyPoints,
    List<String>? savedAddresses,
    String? defaultPaymentMethod,
    bool? notificationsEnabled,
    String? language,
    String? theme,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      userType: userType ?? this.userType,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favoriteHawkers: favoriteHawkers ?? this.favoriteHawkers,
      recentOrders: recentOrders ?? this.recentOrders,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      preferredCategories: preferredCategories ?? this.preferredCategories,
      preferences: preferences ?? this.preferences,
      fcmToken: fcmToken ?? this.fcmToken,
      isVerified: isVerified ?? this.isVerified,
      referralCode: referralCode ?? this.referralCode,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      savedAddresses: savedAddresses ?? this.savedAddresses,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      theme: theme ?? this.theme,
    );
  }

  // Get user avatar widget
  Widget getAvatar({double radius = 20}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: _getAvatarColor(),
      backgroundImage: profileImage != null ? NetworkImage(profileImage!) : null,
      child: profileImage == null
          ? Text(
              name.isNotEmpty ? name[0].toUpperCase() : '?',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: radius * 0.7,
              ),
            )
          : null,
    );
  }

  // Get color based on user type
  Color _getAvatarColor() {
    switch (userType) {
      case 'user':
        return Colors.blue;
      case 'hawker':
        return Colors.green;
      case 'admin':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  // Get user type display name
  String getUserTypeDisplay() {
    switch (userType) {
      case 'user':
        return 'Customer';
      case 'hawker':
        return 'Vendor';
      case 'admin':
        return 'Administrator';
      default:
        return 'Unknown';
    }
  }

  // Mock data for testing
  static UserModel mockUser() {
    return UserModel(
      id: '1',
      name: 'John Doe',
      email: 'john.doe@example.com',
      phone: '9876543210',
      profileImage: 'https://randomuser.me/api/portraits/men/1.jpg',
      userType: 'user',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
      favoriteHawkers: ['1', '2'],
      recentOrders: ['1', '2', '3'],
      address: '123 Main St, Delhi, India',
      latitude: 28.6139,
      longitude: 77.2090,
      preferredCategories: ['fruit', 'vegetable'],
      loyaltyPoints: 150,
      isVerified: true,
      savedAddresses: [
        '123 Main St, Delhi, India',
        'Office: 456 Work Ave, Delhi, India'
      ],
      defaultPaymentMethod: 'upi',
    );
  }

  static UserModel mockHawker() {
    return UserModel(
      id: '2',
      name: 'Vendor Kumar',
      email: 'vendor.kumar@example.com',
      phone: '9876543211',
      profileImage: 'https://randomuser.me/api/portraits/men/2.jpg',
      userType: 'hawker',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      updatedAt: DateTime.now(),
      favoriteHawkers: [],
      recentOrders: [],
      address: '456 Market St, Delhi, India',
      latitude: 28.6219,
      longitude: 77.2190,
      isVerified: true,
    );
  }

  static UserModel mockAdmin() {
    return UserModel(
      id: '3',
      name: 'Admin Singh',
      email: 'admin.singh@example.com',
      phone: '9876543212',
      profileImage: 'https://randomuser.me/api/portraits/men/3.jpg',
      userType: 'admin',
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      updatedAt: DateTime.now(),
      favoriteHawkers: [],
      recentOrders: [],
      address: null,
      latitude: null,
      longitude: null,
      isVerified: true,
    );
  }
}