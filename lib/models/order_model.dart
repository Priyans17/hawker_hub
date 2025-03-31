import 'dart:convert';
import 'package:flutter/material.dart';

class HawkerModel {
  final String id;
  final String userId;
  final String name;
  final String phone;
  final String? aadharNumber;
  final String? govtIdType;
  final String? govtIdNumber;
  final bool isVerified;
  final bool isApproved;
  final String? profileImage;
  final double? rating;
  final int totalOrders;
  final int totalReviews;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double? currentLatitude;
  final double? currentLongitude;
  final bool isOnline;
  final List<String> areas;
  final String? address;
  final List<String>? categories;
  final String? description;
  final String? businessName;
  final List<String>? businessPhotos;
  final Map<String, dynamic>? businessHours;
  final List<String>? paymentMethods;
  final bool acceptsOnlinePayment;
  final bool offersDelivery;
  final double? deliveryRadius;
  final double? deliveryFee;
  final double? minimumOrderAmount;
  final String? bankAccountNumber;
  final String? bankIfscCode;
  final String? upiId;
  final List<HawkerReview>? reviews;
  final String? fcmToken;
  final Map<String, dynamic>? preferences;
  final String? vehicleType;
  final String? vehicleNumber;

  HawkerModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.phone,
    this.aadharNumber,
    this.govtIdType,
    this.govtIdNumber,
    this.isVerified = false,
    this.isApproved = false,
    this.profileImage,
    this.rating,
    this.totalOrders = 0,
    this.totalReviews = 0,
    required this.createdAt,
    required this.updatedAt,
    this.currentLatitude,
    this.currentLongitude,
    this.isOnline = false,
    this.areas = const [],
    this.address,
    this.categories,
    this.description,
    this.businessName,
    this.businessPhotos,
    this.businessHours,
    this.paymentMethods,
    this.acceptsOnlinePayment = false,
    this.offersDelivery = false,
    this.deliveryRadius,
    this.deliveryFee,
    this.minimumOrderAmount,
    this.bankAccountNumber,
    this.bankIfscCode,
    this.upiId,
    this.reviews,
    this.fcmToken,
    this.preferences,
    this.vehicleType,
    this.vehicleNumber,
  });

  factory HawkerModel.fromJson(Map<String, dynamic> json) {
    return HawkerModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      phone: json['phone'],
      aadharNumber: json['aadhar_number'],
      govtIdType: json['govt_id_type'],
      govtIdNumber: json['govt_id_number'],
      isVerified: json['is_verified'] ?? false,
      isApproved: json['is_approved'] ?? false,
      profileImage: json['profile_image'],
      rating: json['rating'],
      totalOrders: json['total_orders'] ?? 0,
      totalReviews: json['total_reviews'] ?? 0,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      currentLatitude: json['current_latitude'],
      currentLongitude: json['current_longitude'],
      isOnline: json['is_online'] ?? false,
      areas: List<String>.from(json['areas'] ?? []),
      address: json['address'],
      categories: json['categories'] != null ? List<String>.from(json['categories']) : null,
      description: json['description'],
      businessName: json['business_name'],
      businessPhotos: json['business_photos'] != null ? List<String>.from(json['business_photos']) : null,
      businessHours: json['business_hours'],
      paymentMethods: json['payment_methods'] != null ? List<String>.from(json['payment_methods']) : null,
      acceptsOnlinePayment: json['accepts_online_payment'] ?? false,
      offersDelivery: json['offers_delivery'] ?? false,
      deliveryRadius: json['delivery_radius'],
      deliveryFee: json['delivery_fee'],
      minimumOrderAmount: json['minimum_order_amount'],
      bankAccountNumber: json['bank_account_number'],
      bankIfscCode: json['bank_ifsc_code'],
      upiId: json['upi_id'],
      reviews: json['reviews'] != null
          ? (json['reviews'] as List).map((review) => HawkerReview.fromJson(review)).toList()
          : null,
      fcmToken: json['fcm_token'],
      preferences: json['preferences'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'phone': phone,
      'aadhar_number': aadharNumber,
      'govt_id_type': govtIdType,
      'govt_id_number': govtIdNumber,
      'is_verified': isVerified,
      'is_approved': isApproved,
      'profile_image': profileImage,
      'rating': rating,
      'total_orders': totalOrders,
      'total_reviews': totalReviews,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'current_latitude': currentLatitude,
      'current_longitude': currentLongitude,
      'is_online': isOnline,
      'areas': areas,
      'address': address,
      'categories': categories,
      'description': description,
      'business_name': businessName,
      'business_photos': businessPhotos,
      'business_hours': businessHours,
      'payment_methods': paymentMethods,
      'accepts_online_payment': acceptsOnlinePayment,
      'offers_delivery': offersDelivery,
      'delivery_radius': deliveryRadius,
      'delivery_fee': deliveryFee,
      'minimum_order_amount': minimumOrderAmount,
      'bank_account_number': bankAccountNumber,
      'bank_ifsc_code': bankIfscCode,
      'upi_id': upiId,
      'reviews': reviews?.map((review) => review.toJson()).toList(),
      'fcm_token': fcmToken,
      'preferences': preferences,
      'vehicle_type': vehicleType,
      'vehicle_number': vehicleNumber,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static HawkerModel fromJsonString(String jsonString) {
    return HawkerModel.fromJson(jsonDecode(jsonString));
  }

  HawkerModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? phone,
    String? aadharNumber,
    String? govtIdType,
    String? govtIdNumber,
    bool? isVerified,
    bool? isApproved,
    String? profileImage,
    double? rating,
    int? totalOrders,
    int? totalReviews,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? currentLatitude,
    double? currentLongitude,
    bool? isOnline,
    List<String>? areas,
    String? address,
    List<String>? categories,
    String? description,
    String? businessName,
    List<String>? businessPhotos,
    Map<String, dynamic>? businessHours,
    List<String>? paymentMethods,
    bool? acceptsOnlinePayment,
    bool? offersDelivery,
    double? deliveryRadius,
    double? deliveryFee,
    double? minimumOrderAmount,
    String? bankAccountNumber,
    String? bankIfscCode,
    String? upiId,
    List<HawkerReview>? reviews,
    String? fcmToken,
    Map<String, dynamic>? preferences,
    String? vehicleType,
    String? vehicleNumber,
  }) {
    return HawkerModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      aadharNumber: aadharNumber ?? this.aadharNumber,
      govtIdType: govtIdType ?? this.govtIdType,
      govtIdNumber: govtIdNumber ?? this.govtIdNumber,
      isVerified: isVerified ?? this.isVerified,
      isApproved: isApproved ?? this.isApproved,
      profileImage: profileImage ?? this.profileImage,
      rating: rating ?? this.rating,
      totalOrders: totalOrders ?? this.totalOrders,
      totalReviews: totalReviews ?? this.totalReviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      currentLatitude: currentLatitude ?? this.currentLatitude,
      currentLongitude: currentLongitude ?? this.currentLongitude,
      isOnline: isOnline ?? this.isOnline,
      areas: areas ?? this.areas,
      address: address ?? this.address,
      categories: categories ?? this.categories,
      description: description ?? this.description,
      businessName: businessName ?? this.businessName,
      businessPhotos: businessPhotos ?? this.businessPhotos,
      businessHours: businessHours ?? this.businessHours,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      acceptsOnlinePayment: acceptsOnlinePayment ?? this.acceptsOnlinePayment,
      offersDelivery: offersDelivery ?? this.offersDelivery,
      deliveryRadius: deliveryRadius ?? this.deliveryRadius,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrderAmount: minimumOrderAmount ?? this.minimumOrderAmount,
      bankAccountNumber: bankAccountNumber ?? this.bankAccountNumber,
      bankIfscCode: bankIfscCode ?? this.bankIfscCode,
      upiId: upiId ?? this.upiId,
      reviews: reviews ?? this.reviews,
      fcmToken: fcmToken ?? this.fcmToken,
      preferences: preferences ?? this.preferences,
      vehicleType: vehicleType ?? this.vehicleType,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
    );
  }

  // Get hawker avatar widget
  Widget getAvatar({double radius = 20}) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.green,
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

  // Get status badge
  Widget getStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isOnline ? 'Online' : 'Offline',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Get verification badge
  Widget getVerificationBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isVerified ? Colors.blue : Colors.orange,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isVerified ? 'Verified' : 'Unverified',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Get formatted rating
  String getFormattedRating() {
    return rating != null ? rating!.toStringAsFixed(1) : 'N/A';
  }

  // Get business hours for a specific day
  String? getBusinessHoursForDay(String day) {
    if (businessHours == null || !businessHours!.containsKey(day)) {
      return null;
    }
    
    final hours = businessHours![day];
    if (hours == null || hours is! Map) {
      return null;
    }
    
    final open = hours['open'];
    final close = hours['close'];
    
    if (open == null || close == null) {
      return null;
    }
    
    return '$open - $close';
  }

  // Check if hawker is open now
  bool isOpenNow() {
    if (businessHours == null) return false;
    
    final now = DateTime.now();
    final days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];
    final today = days[now.weekday - 1];
    
    if (!businessHours!.containsKey(today)) return false;
    
    final hours = businessHours![today];
    if (hours == null || hours is! Map) return false;
    
    final open = hours['open'];
    final close = hours['close'];
    
    if (open == null || close == null) return false;
    
    // Parse hours
    final openTime = _parseTime(open);
    final closeTime = _parseTime(close);
    final currentTime = TimeOfDay(hour: now.hour, minute: now.minute);
    
    return _isTimeBetween(openTime, closeTime, currentTime);
  }
  
  // Parse time string (e.g., "09:00 AM")
  TimeOfDay _parseTime(String timeStr) {
    final parts = timeStr.split(' ');
    final timeParts = parts[0].split(':');
    int hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    
    if (parts.length > 1 && parts[1] == 'PM' && hour < 12) {
      hour += 12;
    } else if (parts.length > 1 && parts[1] == 'AM' && hour == 12) {
      hour = 0;
    }
    
    return TimeOfDay(hour: hour, minute: minute);
  }
  
  // Check if a time is between two other times
  bool _isTimeBetween(TimeOfDay start, TimeOfDay end, TimeOfDay time) {
    final startMinutes = start.hour * 60 + start.minute;
    final endMinutes = end.hour * 60 + end.minute;
    final timeMinutes = time.hour * 60 + time.minute;
    
    if (endMinutes < startMinutes) {
      // Handles overnight hours (e.g., 10:00 PM - 2:00 AM)
      return timeMinutes >= startMinutes || timeMinutes <= endMinutes;
    } else {
      return timeMinutes >= startMinutes && timeMinutes <= endMinutes;
    }
  }

  // Mock data for testing
  static List<HawkerModel> getMockHawkers() {
    return [
      HawkerModel(
        id: '1',
        userId: '101',
        name: 'Ramesh Fruits',
        phone: '9876543201',
        aadharNumber: '123456789012',
        govtIdType: 'Aadhar',
        govtIdNumber: '123456789012',
        isVerified: true,
        isApproved: true,
        profileImage: 'https://randomuser.me/api/portraits/men/32.jpg',
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
        categories: ['fruit', 'vegetable'],
        description: 'Selling fresh fruits and vegetables directly from farms in Himachal Pradesh.',
        businessName: 'Ramesh Fresh Fruits & Vegetables',
        businessPhotos: [
          'https://images.unsplash.com/photo-1542838132-92c53300491e',
          'https://images.unsplash.com/photo-1573246123716-6b1782bfc499',
        ],
        businessHours: {
          'monday': {'open': '8:00 AM', 'close': '8:00 PM'},
          'tuesday': {'open': '8:00 AM', 'close': '8:00 PM'},
          'wednesday': {'open': '8:00 AM', 'close': '8:00 PM'},
          'thursday': {'open': '8:00 AM', 'close': '8:00 PM'},
          'friday': {'open': '8:00 AM', 'close': '8:00 PM'},
          'saturday': {'open': '9:00 AM', 'close': '6:00 PM'},
          'sunday': {'open': '10:00 AM', 'close': '4:00 PM'},
        },
        paymentMethods: ['Cash', 'UPI', 'Card'],
        acceptsOnlinePayment: true,
        offersDelivery: true,
        deliveryRadius: 5.0,
        deliveryFee: 30.0,
        minimumOrderAmount: 200.0,
        upiId: 'ramesh@upi',
        vehicleType: 'Cart',
        reviews: [
          HawkerReview(
            id: '1',
            userId: '1',
            userName: 'John Doe',
            rating: 5.0,
            review: 'Great quality fruits and vegetables. Always fresh!',
            createdAt: DateTime.now().subtract(const Duration(days: 5)),
          ),
          HawkerReview(
            id: '2',
            userId: '2',
            userName: 'Jane Smith',
            rating: 4.0,
            review: 'Good service and reasonable prices.',
            createdAt: DateTime.now().subtract(const Duration(days: 10)),
          ),
        ],
      ),
      HawkerModel(
        id: '2',
        userId: '102',
        name: 'Suresh Vegetables',
        phone: '9876543202',
        aadharNumber: '123456789013',
        govtIdType: 'Aadhar',
        govtIdNumber: '123456789013',
        isVerified: true,
        isApproved: true,
        profileImage: 'https://randomuser.me/api/portraits/men/45.jpg',
        rating: 4.2,
        totalOrders: 95,
        totalReviews: 32,
        createdAt: DateTime.now().subtract(const Duration(days: 90)),
        updatedAt: DateTime.now(),
        currentLatitude: 28.6219,
        currentLongitude: 77.2090,
        isOnline: true,
        areas: ['Karol Bagh', 'Patel Nagar', 'Rajendra Place'],
        address: 'Karol Bagh, New Delhi',
        categories: ['vegetable'],
        description: 'Organic vegetables grown in our own farms. No pesticides used.',
        businessName: 'Suresh Organic Vegetables',
        businessPhotos: [
          'https://images.unsplash.com/photo-1488459716781-31db52582fe9',
          'https://images.unsplash.com/photo-1518843875459-f738682238a6',
        ],
        businessHours: {
          'monday': {'open': '7:00 AM', 'close': '7:00 PM'},
          'tuesday': {'open': '7:00 AM', 'close': '7:00 PM'},
          'wednesday': {'open': '7:00 AM', 'close': '7:00 PM'},
          'thursday': {'open': '7:00 AM', 'close': '7:00 PM'},
          'friday': {'open': '7:00 AM', 'close': '7:00 PM'},
          'saturday': {'open': '7:00 AM', 'close': '5:00 PM'},
          'sunday': {'open': '8:00 AM', 'close': '2:00 PM'},
        },
        paymentMethods: ['Cash', 'UPI'],
        acceptsOnlinePayment: true,
        offersDelivery: true,
        deliveryRadius: 3.0,
        deliveryFee: 20.0,
        minimumOrderAmount: 150.0,
        upiId: 'suresh@upi',
        vehicleType: 'Bicycle',
      ),
      HawkerModel(
        id: '3',
        userId: '103',
        name: 'Mahesh Fresh Fruits',
        phone: '9876543203',
        aadharNumber: '123456789014',
        govtIdType: 'Aadhar',
        govtIdNumber: '123456789014',
        isVerified: true,
        isApproved: true,
        profileImage: 'https://randomuser.me/api/portraits/men/67.jpg',
        rating: 4.7,
        totalOrders: 150,
        totalReviews: 60,
        createdAt: DateTime.now().subtract(const Duration(days: 150)),
        updatedAt: DateTime.now(),
        currentLatitude: 28.6329,
        currentLongitude: 77.2190,
        isOnline: false,
        areas: ['Lajpat Nagar', 'Defence Colony', 'South Extension'],
        address: 'Lajpat Nagar, New Delhi',
        categories: ['fruit'],
        description: 'Premium quality fruits imported from various countries. Exotic varieties available.',
        businessName: 'Mahesh Exotic Fruits',
        businessPhotos: [
          'https://images.unsplash.com/photo-1519996529931-28324d5a630e',
          'https://images.unsplash.com/photo-1577234286642-fc512a5f8f11',
        ],
        businessHours: {
          'monday': {'open': '10:00 AM', 'close': '9:00 PM'},
          'tuesday': {'open': '10:00 AM', 'close': '9:00 PM'},
          'wednesday': {'open': '10:00 AM', 'close': '9:00 PM'},
          'thursday': {'open': '10:00 AM', 'close': '9:00 PM'},
          'friday': {'open': '10:00 AM', 'close': '9:00 PM'},
          'saturday': {'open': '10:00 AM', 'close': '9:00 PM'},
          'sunday': {'open': '11:00 AM', 'close': '6:00 PM'},
        },
        paymentMethods: ['Cash', 'UPI', 'Card', 'Net Banking'],
        acceptsOnlinePayment: true,
        offersDelivery: true,
        deliveryRadius: 8.0,
        deliveryFee: 50.0,
        minimumOrderAmount: 500.0,
        upiId: 'mahesh@upi',
        vehicleType: 'Auto',
      ),
      HawkerModel(
        id: '4',
        userId: '104',
        name: 'Dinesh Organic Veggies',
        phone: '9876543204',
        aadharNumber: '123456789015',
        govtIdType: 'Aadhar',
        govtIdNumber: '123456789015',
        isVerified: true,
        isApproved: true,
        profileImage: 'https://randomuser.me/api/portraits/men/22.jpg',
        rating: 4.8,
        totalOrders: 200,
        totalReviews: 75,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        updatedAt: DateTime.now(),
        currentLatitude: 28.6429,
        currentLongitude: 77.2090,
        isOnline: true,
        areas: ['Vasant Kunj', 'Vasant Vihar', 'Munirka'],
        address: 'Vasant Kunj, New Delhi',
        categories: ['vegetable', 'fruit'],
        description: 'Certified organic produce. Farm to table concept with same-day harvesting.',
        businessName: 'Dinesh Farm Fresh Organics',
        businessPhotos: [
          'https://images.unsplash.com/photo-1550989460-0adf9ea622e2',
          'https://images.unsplash.com/photo-1594282486552-05a4a0f6d0b5',
        ],
        businessHours: {
          'monday': {'open': '6:00 AM', 'close': '10:00 PM'},
          'tuesday': {'open': '6:00 AM', 'close': '10:00 PM'},
          'wednesday': {'open': '6:00 AM', 'close': '10:00 PM'},
          'thursday': {'open': '6:00 AM', 'close': '10:00 PM'},
          'friday': {'open': '6:00 AM', 'close': '10:00 PM'},
          'saturday': {'open': '6:00 AM', 'close': '10:00 PM'},
          'sunday': {'open': '6:00 AM', 'close': '10:00 PM'},
        },
        paymentMethods: ['Cash', 'UPI', 'Card', 'Net Banking'],
        acceptsOnlinePayment: true,
        offersDelivery: true,
        deliveryRadius: 10.0,
        deliveryFee: 0.0, // Free delivery
        minimumOrderAmount: 300.0,
        upiId: 'dinesh@upi',
        vehicleType: 'Electric Cart',
      ),
      HawkerModel(
        id: '5',
        userId: '105',
        name: 'Jignesh Fruit Corner',
        phone: '9876543205',
        aadharNumber: '123456789016',
        govtIdType: 'Aadhar',
        govtIdNumber: '123456789016',
        isVerified: true,
        isApproved: true,
        profileImage: 'https://randomuser.me/api/portraits/men/55.jpg',
        rating: 4.0,
        totalOrders: 80,
        totalReviews: 25,
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        updatedAt: DateTime.now(),
        currentLatitude: 28.6529,
        currentLongitude: 77.2390,
        isOnline: true,
        areas: ['Dwarka', 'Janakpuri', 'Uttam Nagar'],
        address: 'Dwarka, New Delhi',
        categories: ['fruit'],
        description: 'Seasonal fruits at affordable prices. Special discounts for bulk orders.',
        businessName: 'Jignesh Seasonal Fruits',
        businessPhotos: [
          'https://images.unsplash.com/photo-1610832958506-aa56368176cf',
          'https://images.unsplash.com/photo-1519996529931-28324d5a630e',
        ],
        businessHours: {
          'monday': {'open': '9:00 AM', 'close': '7:00 PM'},
          'tuesday': {'open': '9:00 AM', 'close': '7:00 PM'},
          'wednesday': {'open': '9:00 AM', 'close': '7:00 PM'},
          'thursday': {'open': '9:00 AM', 'close': '7:00 PM'},
          'friday': {'open': '9:00 AM', 'close': '7:00 PM'},
          'saturday': {'open': '9:00 AM', 'close': '7:00 PM'},
          'sunday': {'open': '10:00 AM', 'close': '5:00 PM'},
        },
        paymentMethods: ['Cash', 'UPI'],
        acceptsOnlinePayment: true,
        offersDelivery: false,
        upiId: 'jignesh@upi',
        vehicleType: 'Cart',
      ),
    ];
  }
}

class HawkerReview {
  final String id;
  final String userId;
  final String userName;
  final double rating;
  final String? review;
  final DateTime createdAt;
  final List<String>? photos;

  HawkerReview({
    required this.id,
    required this.userId,
    required this.userName,
    required this.rating,
    this.review,
    required this.createdAt,
    this.photos,
  });

  factory HawkerReview.fromJson(Map<String, dynamic> json) {
    return HawkerReview(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user_name'],
      rating: json['rating'].toDouble(),
      review: json['review'],
      createdAt: DateTime.parse(json['created_at']),
      photos: json['photos'] != null ? List<String>.from(json['photos']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'user_name': userName,
      'rating': rating,
      'review': review,
      'created_at': createdAt.toIso8601String(),
      'photos': photos,
    };
  }
}