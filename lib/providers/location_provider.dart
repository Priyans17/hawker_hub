import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hawker_app/utils/constants.dart';

class LocationProvider with ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String? _address;
  bool _isLoading = false;
  String? _error;
  bool _locationPermissionGranted = false;

  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get address => _address;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get hasLocation => _latitude != null && _longitude != null;
  bool get locationPermissionGranted => _locationPermissionGranted;

  // Initialize with default location (Delhi, India)
  LocationProvider() {
    _latitude = Constants.defaultLatitude;
    _longitude = Constants.defaultLongitude;
  }

  // Request location permission
  Future<bool> requestLocationPermission() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _error = 'Location services are disabled. Please enable location services.';
        _locationPermissionGranted = false;
        notifyListeners();
        return false;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _error = 'Location permission denied. Please grant location permission.';
          _locationPermissionGranted = false;
          notifyListeners();
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _error = 'Location permission permanently denied. Please enable location permission from app settings.';
        _locationPermissionGranted = false;
        notifyListeners();
        return false;
      }

      _locationPermissionGranted = true;
      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error requesting location permission: $e';
      _locationPermissionGranted = false;
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get current location
  Future<bool> getCurrentLocation() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final permissionGranted = await requestLocationPermission();
      if (!permissionGranted) {
        return false;
      }

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _latitude = position.latitude;
      _longitude = position.longitude;

      // Get address from coordinates
      await getAddressFromCoordinates(_latitude!, _longitude!);

      notifyListeners();
      return true;
    } catch (e) {
      _error = 'Error getting current location: $e';
      notifyListeners();
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Get address from coordinates
  Future<void> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      final placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        _address = '${place.name}, ${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
      } else {
        _address = 'Unknown location';
      }
      notifyListeners();
    } catch (e) {
      _error = 'Error getting address: $e';
      _address = 'Unknown location';
      notifyListeners();
    }
  }

  // Set location manually
  Future<void> setLocation(double latitude, double longitude) async {
    _latitude = latitude;
    _longitude = longitude;
    await getAddressFromCoordinates(latitude, longitude);
    notifyListeners();
  }

  // Set address manually
  void setAddress(String address) {
    _address = address;
    notifyListeners();
  }

  // Calculate distance between current location and given coordinates (in kilometers)
  double calculateDistance(double targetLatitude, double targetLongitude) {
    if (_latitude == null || _longitude == null) {
      return -1; // Invalid distance
    }

    return Geolocator.distanceBetween(
      _latitude!,
      _longitude!,
      targetLatitude,
      targetLongitude,
    ) / 1000; // Convert meters to kilometers
  }
}

