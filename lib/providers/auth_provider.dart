import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hawker_app/models/user_model.dart';
import 'package:hawker_app/utils/constants.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = false;
  String? _token;
  String? _userType;
  bool _isLoggedIn = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  String? get token => _token;
  String? get userType => _userType;
  bool get isLoggedIn => _isLoggedIn;
  bool get isUser => _userType == Constants.userType;
  bool get isHawker => _userType == Constants.hawkerType;
  bool get isAdmin => _userType == Constants.adminType;

  // Initialize auth state from shared preferences
  Future<void> initAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(Constants.tokenKey);
      final userId = prefs.getString(Constants.userIdKey);
      final userType = prefs.getString(Constants.userTypeKey);
      final isLoggedIn = prefs.getBool(Constants.isLoggedInKey) ?? false;

      if (token != null && userId != null && userType != null && isLoggedIn) {
        _token = token;
        _userType = userType;
        _isLoggedIn = isLoggedIn;

        // In a real app, fetch user data from API
        // For now, use mock data
        if (userType == Constants.userType) {
          _user = UserModel.mockUser();
        } else if (userType == Constants.hawkerType) {
          _user = UserModel.mockHawker();
        } else if (userType == Constants.adminType) {
          _user = UserModel.mockAdmin();
        }
      }
    } catch (e) {
      debugPrint('Error initializing auth: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login user
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, make API call to login
      // For now, simulate login with mock data
      await Future.delayed(const Duration(seconds: 2));

      if (email == 'user@example.com' && password == 'password') {
        _user = UserModel.mockUser();
        _token = 'mock_token_user';
        _userType = Constants.userType;
        _isLoggedIn = true;
      } else if (email == 'hawker@example.com' && password == 'password') {
        _user = UserModel.mockHawker();
        _token = 'mock_token_hawker';
        _userType = Constants.hawkerType;
        _isLoggedIn = true;
      } else if (email == 'admin@example.com' && password == 'password') {
        _user = UserModel.mockAdmin();
        _token = 'mock_token_admin';
        _userType = Constants.adminType;
        _isLoggedIn = true;
      } else {
        return false;
      }

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.tokenKey, _token!);
      await prefs.setString(Constants.userIdKey, _user!.id);
      await prefs.setString(Constants.userTypeKey, _userType!);
      await prefs.setBool(Constants.isLoggedInKey, _isLoggedIn);

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error logging in: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Signup user
  Future<bool> signup(String name, String email, String phone, String password, String userType) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, make API call to signup
      // For now, simulate signup with mock data
      await Future.delayed(const Duration(seconds: 2));

      // Create a new user
      final now = DateTime.now();
      _user = UserModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: email,
        phone: phone,
        userType: userType,
        createdAt: now,
        updatedAt: now,
      );
      _token = 'mock_token_${userType}_${now.millisecondsSinceEpoch}';
      _userType = userType;
      _isLoggedIn = true;

      // Save to shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.tokenKey, _token!);
      await prefs.setString(Constants.userIdKey, _user!.id);
      await prefs.setString(Constants.userTypeKey, _userType!);
      await prefs.setBool(Constants.isLoggedInKey, _isLoggedIn);

      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error signing up: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Verify OTP
  Future<bool> verifyOtp(String otp) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, make API call to verify OTP
      // For now, simulate OTP verification
      await Future.delayed(const Duration(seconds: 2));

      // For demo purposes, any 6-digit OTP is valid
      final isValid = otp.length == 6 && int.tryParse(otp) != null;
      return isValid;
    } catch (e) {
      debugPrint('Error verifying OTP: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Clear user data
      _user = null;
      _token = null;
      _userType = null;
      _isLoggedIn = false;

      // Clear shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(Constants.tokenKey);
      await prefs.remove(Constants.userIdKey);
      await prefs.remove(Constants.userTypeKey);
      await prefs.setBool(Constants.isLoggedInKey, false);
    } catch (e) {
      debugPrint('Error logging out: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user profile
  Future<bool> updateProfile(String name, String phone, String? address) async {
    _isLoading = true;
    notifyListeners();

    try {
      // In a real app, make API call to update profile
      // For now, simulate profile update
      await Future.delayed(const Duration(seconds: 2));

      if (_user != null) {
        _user = _user!.copyWith(
          name: name,
          phone: phone,
          address: address,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error updating profile: $e');
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update user location
  Future<bool> updateLocation(double latitude, double longitude, String address) async {
    try {
      if (_user != null) {
        _user = _user!.copyWith(
          latitude: latitude,
          longitude: longitude,
          address: address,
          updatedAt: DateTime.now(),
        );
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error updating location: $e');
      return false;
    }
  }
}

