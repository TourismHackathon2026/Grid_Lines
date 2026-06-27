class AppConstants {
  AppConstants._();

  static const String appName = 'Hackathon App';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.example.com';
  static const Duration connectTimeout = Duration(seconds: 15);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Pagination
  static const int pageSize = 20;

  // Local Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userIdKey = 'user_id';
  static const String onboardingCompleteKey = 'onboarding_complete';
}