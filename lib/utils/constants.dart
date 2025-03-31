
class Constants {
  // App info
  static const String appName = 'Hawker App';
  static const String appVersion = '1.0.0';
  
  // API endpoints (to be implemented later with actual backend)
  static const String baseUrl = 'https://api.example.com';
  static const String loginEndpoint = '/auth/login';
  static const String signupEndpoint = '/auth/signup';
  static const String verifyOtpEndpoint = '/auth/verify-otp';
  static const String hawkersEndpoint = '/hawkers';
  static const String ordersEndpoint = '/orders';
  static const String productsEndpoint = '/products';
  static const String userProfileEndpoint = '/users/profile';
  static const String hawkerProfileEndpoint = '/hawkers/profile';
  
  
  // Shared preferences keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String userTypeKey = 'user_type';
  static const String themeKey = 'app_theme';
  static const String isLoggedInKey = 'is_logged_in';
  
  // User types
  static const String userType = 'user';
  static const String hawkerType = 'hawker';
  static const String adminType = 'admin';
  
  // Order status
  static const String orderPlaced = 'Order Placed';
  static const String orderAccepted = 'Order Accepted';
  static const String orderPacked = 'Order Packed';
  static const String orderDispatched = 'Order Dispatched';
  static const String orderDelivered = 'Order Delivered';
  static const String orderCompleted = 'Order Completed';
  static const String orderCancelled = 'Order Cancelled';
  
  // Payment methods
  static const String codPayment = 'Cash on Delivery';
  static const String upiPayment = 'UPI';
  static const String cardPayment = 'Card';
  
  // Map settings
  static const double defaultZoom = 15.0;
  static const double defaultLatitude = 28.6139;  // Default to Delhi, India
  static const double defaultLongitude = 77.2090;
  
  // Animation durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 500);
  static const Duration longAnimationDuration = Duration(milliseconds: 800);
  
  // Validation patterns
  static final RegExp emailPattern = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final RegExp phonePattern = RegExp(r'^[0-9]{10}$');
  static final RegExp passwordPattern = RegExp(r'^.{6,}$');
  static final RegExp otpPattern = RegExp(r'^[0-9]{6}$');
  
  // Error messages
  static const String networkErrorMessage = 'Network error. Please check your internet connection.';
  static const String unknownErrorMessage = 'An unknown error occurred. Please try again.';
  static const String invalidCredentialsMessage = 'Invalid credentials. Please try again.';
  static const String invalidOtpMessage = 'Invalid OTP. Please try again.';
  static const String invalidEmailMessage = 'Please enter a valid email address.';
  static const String invalidPhoneMessage = 'Please enter a valid 10-digit phone number.';
  static const String invalidPasswordMessage = 'Password must be at least 6 characters long.';
  static const String passwordMismatchMessage = 'Passwords do not match.';
  static const String emptyFieldMessage = 'This field cannot be empty.';
  
  // Success messages
  static const String signupSuccessMessage = 'Signup successful. Please verify your account.';
  static const String otpVerificationSuccessMessage = 'OTP verification successful.';
  static const String loginSuccessMessage = 'Login successful.';
  static const String orderPlacedSuccessMessage = 'Order placed successfully.';
  static const String orderCompletedSuccessMessage = 'Order completed successfully.';
  static const String returnRequestSuccessMessage = 'Return request submitted successfully.';
  
  // Fruits and vegetables list for inventory
  static const List<String> fruitsAndVegetables = [
    // Fruits
    'Apple', 'Banana', 'Orange', 'Mango', 'Grapes', 'Watermelon', 'Papaya', 'Pineapple',
    'Pomegranate', 'Guava', 'Strawberry', 'Kiwi', 'Pear', 'Plum', 'Litchi', 'Custard Apple',
    'Sapota', 'Jamun', 'Jackfruit', 'Coconut', 'Dragon Fruit', 'Fig', 'Apricot', 'Cherry',
    'Peach', 'Mulberry', 'Raspberry', 'Blackberry', 'Blueberry',
    
    // Vegetables
    'Potato', 'Onion', 'Tomato', 'Carrot', 'Cabbage', 'Cauliflower', 'Broccoli', 'Spinach',
    'Cucumber', 'Capsicum', 'Eggplant', 'Okra', 'Peas', 'Beans', 'Bitter Gourd', 'Bottle Gourd',
    'Ridge Gourd', 'Snake Gourd', 'Pumpkin', 'Radish', 'Beetroot', 'Sweet Potato', 'Turnip',
    'Garlic', 'Ginger', 'Green Chilli', 'Coriander', 'Mint', 'Curry Leaves', 'Fenugreek',
    'Mustard Greens', 'Lettuce', 'Celery', 'Asparagus', 'Zucchini', 'Artichoke', 'Leek',
    'Spring Onion', 'Mushroom', 'Corn', 'Sweet Corn', 'Baby Corn', 'Drumstick', 'Yam',
    'Colocasia', 'Plantain', 'Raw Banana', 'Cluster Beans', 'Broad Beans', 'French Beans',
    'Lima Beans', 'Cowpeas', 'Green Peas', 'Chickpeas', 'Sprouts',
  ];

  static var errorColor;

  static var successColor;
}

