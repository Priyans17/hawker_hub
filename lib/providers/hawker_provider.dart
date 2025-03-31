import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:hawker_app/models/hawker_model.dart';
import 'package:hawker_app/models/product_model.dart';

class HawkerProvider with ChangeNotifier {
  List<HawkerModel> _hawkers = [];
  final Map<String, List<ProductModel>> _hawkerProducts = {};
  bool _isLoading = false;
  String? _error;

  List<HawkerModel> get hawkers => _hawkers;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Initialize with mock data
  HawkerProvider() {
    _loadMockData();
  }

  // Load mock data
  Future<void> _loadMockData() async {
    _isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
      _hawkers = HawkerModel.getMockHawkers();

      // Load products for each hawker
      for (final hawker in _hawkers) {
        _hawkerProducts[hawker.id] = ProductModel.getMockProducts(hawker.id);
      }
    } catch (e) {
      _error = 'Error loading hawkers: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get hawker by ID
  HawkerModel? getHawkerById(String id) {
    try {
      return _hawkers.firstWhere((hawker) => hawker.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get products for a hawker
  List<ProductModel> getProductsForHawker(String hawkerId) {
    return _hawkerProducts[hawkerId] ?? [];
  }

  // Get nearby hawkers based on location
  List<HawkerModel> getNearbyHawkers(double latitude, double longitude, double radiusInKm) {
    return _hawkers.where((hawker) {
      if (hawker.currentLatitude == null || hawker.currentLongitude == null) {
        return false;
      }

      final distance = _calculateDistance(
        latitude,
        longitude,
        hawker.currentLatitude!,
        hawker.currentLongitude!,
      );

      return distance <= radiusInKm;
    }).toList();
  }

  // Get online hawkers
  List<HawkerModel> getOnlineHawkers() {
    return _hawkers.where((hawker) => hawker.isOnline).toList();
  }

  // Search hawkers by name
  List<HawkerModel> searchHawkers(String query) {
    if (query.isEmpty) {
      return _hawkers;
    }

    final lowercaseQuery = query.toLowerCase();
    return _hawkers.where((hawker) {
      return hawker.name.toLowerCase().contains(lowercaseQuery) ||
          (hawker.address?.toLowerCase().contains(lowercaseQuery) ?? false);
    }).toList();
  }

  // Update hawker location (for hawker app)
  Future<bool> updateHawkerLocation(String hawkerId, double latitude, double longitude) async {
    _isLoading = true;
    notifyListeners();

    try {
      final hawkerIndex = _hawkers.indexWhere((hawker) => hawker.id == hawkerId);
      if (hawkerIndex == -1) {
        return false;
      }

      _hawkers[hawkerIndex] = _hawkers[hawkerIndex].copyWith(
        currentLatitude: latitude,
        currentLongitude: longitude,
        updatedAt: DateTime.now(),
      );

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error updating hawker location: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update hawker online status (for hawker app)
  Future<bool> updateHawkerOnlineStatus(String hawkerId, bool isOnline) async {
    _isLoading = true;
    notifyListeners();

    try {
      final hawkerIndex = _hawkers.indexWhere((hawker) => hawker.id == hawkerId);
      if (hawkerIndex == -1) {
        return false;
      }

      _hawkers[hawkerIndex] = _hawkers[hawkerIndex].copyWith(
        isOnline: isOnline,
        updatedAt: DateTime.now(),
      );

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error updating hawker online status: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update product availability (for hawker app)
  Future<bool> updateProductAvailability(String hawkerId, String productId, bool isAvailable) async {
    _isLoading = true;
    notifyListeners();

    try {
      final products = _hawkerProducts[hawkerId];
      if (products == null) {
        return false;
      }

      final productIndex = products.indexWhere((product) => product.id == productId);
      if (productIndex == -1) {
        return false;
      }

      products[productIndex] = products[productIndex].copyWith(
        isAvailable: isAvailable,
        updatedAt: DateTime.now(),
      );

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error updating product availability: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add product to hawker inventory (for hawker app)
  Future<bool> addProduct(String hawkerId, String name, String category, double price, String unit) async {
    _isLoading = true;
    notifyListeners();

    try {
      final products = _hawkerProducts[hawkerId];
      if (products == null) {
        return false;
      }

      final now = DateTime.now();
      final newProduct = ProductModel(
        id: 'p_${now.millisecondsSinceEpoch}',
        hawkerId: hawkerId,
        name: name,
        category: category,
        price: price,
        unit: unit,
        isAvailable: true,
        createdAt: now,
        updatedAt: now,
      );

      products.add(newProduct);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error adding product: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Remove product from hawker inventory (for hawker app)
  Future<bool> removeProduct(String hawkerId, String productId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final products = _hawkerProducts[hawkerId];
      if (products == null) {
        return false;
      }

      final productIndex = products.indexWhere((product) => product.id == productId);
      if (productIndex == -1) {
        return false;
      }

      products.removeAt(productIndex);
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error removing product: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Calculate distance between two coordinates (in kilometers)
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
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




