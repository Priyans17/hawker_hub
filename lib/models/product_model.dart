import 'dart:convert';
import 'package:flutter/material.dart';

class ProductModel {
  final String id;
  final String hawkerId;
  final String name;
  final String category; // 'fruit' or 'vegetable'
  final double price;
  final double? discountPrice;
  final String unit; // 'kg', 'g', 'piece', etc.
  final bool isAvailable;
  final String? image;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<String>? tags;
  final double? rating;
  final int reviewCount;
  final bool isFeatured;
  final bool isOrganic;
  final String? nutritionInfo;
  final Map<String, dynamic>? attributes;
  final int stockQuantity;
  final String? origin;
  final String? season;
  final int viewCount;

  ProductModel({
    required this.id,
    required this.hawkerId,
    required this.name,
    required this.category,
    required this.price,
    this.discountPrice,
    required this.unit,
    this.isAvailable = true,
    this.image,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    this.tags,
    this.rating,
    this.reviewCount = 0,
    this.isFeatured = false,
    this.isOrganic = false,
    this.nutritionInfo,
    this.attributes,
    this.stockQuantity = 0,
    this.origin,
    this.season,
    this.viewCount = 0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      hawkerId: json['hawker_id'],
      name: json['name'],
      category: json['category'],
      price: json['price'].toDouble(),
      discountPrice: json['discount_price']?.toDouble(),
      unit: json['unit'],
      isAvailable: json['is_available'] ?? true,
      image: json['image'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      tags: json['tags'] != null ? List<String>.from(json['tags']) : null,
      rating: json['rating']?.toDouble(),
      reviewCount: json['review_count'] ?? 0,
      isFeatured: json['is_featured'] ?? false,
      isOrganic: json['is_organic'] ?? false,
      nutritionInfo: json['nutrition_info'],
      attributes: json['attributes'],
      stockQuantity: json['stock_quantity'] ?? 0,
      origin: json['origin'],
      season: json['season'],
      viewCount: json['view_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hawker_id': hawkerId,
      'name': name,
      'category': category,
      'price': price,
      'discount_price': discountPrice,
      'unit': unit,
      'is_available': isAvailable,
      'image': image,
      'description': description,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'tags': tags,
      'rating': rating,
      'review_count': reviewCount,
      'is_featured': isFeatured,
      'is_organic': isOrganic,
      'nutrition_info': nutritionInfo,
      'attributes': attributes,
      'stock_quantity': stockQuantity,
      'origin': origin,
      'season': season,
      'view_count': viewCount,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  static ProductModel fromJsonString(String jsonString) {
    return ProductModel.fromJson(jsonDecode(jsonString));
  }

  ProductModel copyWith({
    String? id,
    String? hawkerId,
    String? name,
    String? category,
    double? price,
    double? discountPrice,
    String? unit,
    bool? isAvailable,
    String? image,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? tags,
    double? rating,
    int? reviewCount,
    bool? isFeatured,
    bool? isOrganic,
    String? nutritionInfo,
    Map<String, dynamic>? attributes,
    int? stockQuantity,
    String? origin,
    String? season,
    int? viewCount,
  }) {
    return ProductModel(
      id: id ?? this.id,
      hawkerId: hawkerId ?? this.hawkerId,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      discountPrice: discountPrice ?? this.discountPrice,
      unit: unit ?? this.unit,
      isAvailable: isAvailable ?? this.isAvailable,
      image: image ?? this.image,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      tags: tags ?? this.tags,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isOrganic: isOrganic ?? this.isOrganic,
      nutritionInfo: nutritionInfo ?? this.nutritionInfo,
      attributes: attributes ?? this.attributes,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      origin: origin ?? this.origin,
      season: season ?? this.season,
      viewCount: viewCount ?? this.viewCount,
    );
  }

  // Get discount percentage
  int? getDiscountPercentage() {
    if (discountPrice == null || price <= 0) return null;
    return ((price - discountPrice!) / price * 100).round();
  }

  // Get category icon
  IconData getCategoryIcon() {
    switch (category.toLowerCase()) {
      case 'fruit':
        return Icons.apple;
      case 'vegetable':
        return Icons.eco;
      default:
        return Icons.shopping_basket;
    }
  }

  // Get category color
  Color getCategoryColor() {
    switch (category.toLowerCase()) {
      case 'fruit':
        return Colors.orange;
      case 'vegetable':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  // Check if product is on sale
  bool get isOnSale => discountPrice != null && discountPrice! < price;

  // Get formatted price
  String getFormattedPrice() {
    return '₹${price.toStringAsFixed(2)}';
  }

  // Get formatted discount price
  String? getFormattedDiscountPrice() {
    if (discountPrice == null) return null;
    return '₹${discountPrice!.toStringAsFixed(2)}';
  }

  // Mock data for testing
  static List<ProductModel> getMockProducts(String hawkerId) {
    final now = DateTime.now();
    final fruitImages = [
      'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6',
      'https://images.unsplash.com/photo-1603833665858-e61d17a86224',
      'https://images.unsplash.com/photo-1528825871115-3581a5387919',
      'https://images.unsplash.com/photo-1550258987-190a2d41a8ba',
    ];
    
    final vegImages = [
      'https://images.unsplash.com/photo-1518977676601-b53f82aba655',
      'https://images.unsplash.com/photo-1566842600175-97dca3c5ad8d',
      'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37',
      'https://images.unsplash.com/photo-1597362925123-77861d3fbac7',
    ];
    
    return [
      ProductModel(
        id: '1',
        hawkerId: hawkerId,
        name: 'Apple',
        category: 'fruit',
        price: 150.0,
        discountPrice: 130.0,
        unit: 'kg',
        isAvailable: true,
        image: fruitImages[0],
        description: 'Fresh red apples from Himachal Pradesh. Rich in antioxidants and dietary fiber.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['seasonal', 'fresh', 'popular'],
        rating: 4.5,
        reviewCount: 28,
        isFeatured: true,
        isOrganic: true,
        nutritionInfo: 'Calories: 52 per 100g, Fiber: 2.4g, Vitamin C: 8% of RDI',
        origin: 'Himachal Pradesh',
        season: 'Winter',
        stockQuantity: 50,
      ),
      ProductModel(
        id: '2',
        hawkerId: hawkerId,
        name: 'Banana',
        category: 'fruit',
        price: 60.0,
        discountPrice: null,
        unit: 'dozen',
        isAvailable: true,
        image: fruitImages[1],
        description: 'Sweet and ripe bananas. Great source of potassium and natural energy.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['energy', 'fresh', 'daily'],
        rating: 4.2,
        reviewCount: 15,
        isFeatured: false,
        isOrganic: false,
        nutritionInfo: 'Calories: 89 per 100g, Potassium: 358mg, Vitamin B6: 20% of RDI',
        origin: 'Karnataka',
        season: 'All Year',
        stockQuantity: 120,
      ),
      ProductModel(
        id: '3',
        hawkerId: hawkerId,
        name: 'Orange',
        category: 'fruit',
        price: 120.0,
        discountPrice: 100.0,
        unit: 'kg',
        isAvailable: true,
        image: fruitImages[2],
        description: 'Juicy oranges from Nagpur. High in vitamin C and refreshing taste.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['citrus', 'vitamin-c', 'immunity'],
        rating: 4.7,
        reviewCount: 32,
        isFeatured: true,
        isOrganic: true,
        nutritionInfo: 'Calories: 43 per 100g, Vitamin C: 89% of RDI, Fiber: 2.4g',
        origin: 'Nagpur, Maharashtra',
        season: 'Winter',
        stockQuantity: 75,
      ),
      ProductModel(
        id: '4',
        hawkerId: hawkerId,
        name: 'Potato',
        category: 'vegetable',
        price: 40.0,
        discountPrice: null,
        unit: 'kg',
        isAvailable: true,
        image: vegImages[0],
        description: 'Fresh potatoes. Versatile vegetable for various dishes.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['staple', 'versatile'],
        rating: 4.0,
        reviewCount: 45,
        isFeatured: false,
        isOrganic: false,
        nutritionInfo: 'Calories: 77 per 100g, Carbs: 17g, Vitamin C: 17% of RDI',
        origin: 'Uttar Pradesh',
        season: 'All Year',
        stockQuantity: 200,
      ),
      ProductModel(
        id: '5',
        hawkerId: hawkerId,
        name: 'Onion',
        category: 'vegetable',
        price: 50.0,
        discountPrice: 45.0,
        unit: 'kg',
        isAvailable: true,
        image: vegImages[1],
        description: 'Red onions. Essential ingredient for Indian cooking.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['essential', 'cooking'],
        rating: 4.3,
        reviewCount: 38,
        isFeatured: false,
        isOrganic: true,
        nutritionInfo: 'Calories: 40 per 100g, Vitamin C: 7.4mg, Fiber: 1.7g',
        origin: 'Maharashtra',
        season: 'All Year',
        stockQuantity: 150,
      ),
      ProductModel(
        id: '6',
        hawkerId: hawkerId,
        name: 'Tomato',
        category: 'vegetable',
        price: 60.0,
        discountPrice: null,
        unit: 'kg',
        isAvailable: true,
        image: vegImages[2],
        description: 'Fresh red tomatoes. Perfect for salads and curries.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['salad', 'cooking', 'fresh'],
        rating: 4.1,
        reviewCount: 22,
        isFeatured: false,
        isOrganic: false,
        nutritionInfo: 'Calories: 18 per 100g, Vitamin C: 21% of RDI, Potassium: 237mg',
        origin: 'Karnataka',
        season: 'All Year',
        stockQuantity: 100,
      ),
      ProductModel(
        id: '7',
        hawkerId: hawkerId,
        name: 'Mango',
        category: 'fruit',
        price: 200.0,
        discountPrice: 180.0,
        unit: 'kg',
        isAvailable: true,
        image: fruitImages[3],
        description: 'Sweet Alphonso mangoes. The king of fruits, perfect for summer.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['seasonal', 'premium', 'summer'],
        rating: 4.9,
        reviewCount: 56,
        isFeatured: true,
        isOrganic: true,
        nutritionInfo: 'Calories: 60 per 100g, Vitamin A: 25% of RDI, Vitamin C: 67% of RDI',
        origin: 'Ratnagiri, Maharashtra',
        season: 'Summer',
        stockQuantity: 40,
      ),
      ProductModel(
        id: '8',
        hawkerId: hawkerId,
        name: 'Cucumber',
        category: 'vegetable',
        price: 40.0,
        discountPrice: null,
        unit: 'kg',
        isAvailable: true,
        image: vegImages[3],
        description: 'Fresh green cucumbers. Hydrating and perfect for salads.',
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now,
        tags: ['hydrating', 'salad', 'summer'],
        rating: 4.0,
        reviewCount: 18,
        isFeatured: false,
        isOrganic: true,
        nutritionInfo: 'Calories: 15 per 100g, Water: 95%, Vitamin K: 16% of RDI',
        origin: 'Punjab',
        season: 'Summer',
        stockQuantity: 80,
      ),
    ];
  }
}