class ApiConfig {
  // Base URL untuk API Express (Production Server)
  // Server: http://31.97.109.108:3000
  static String get baseUrl {
    // Use production server for all platforms
    return 'http://31.97.109.108:3000';

    // Comment: Previous localhost configuration
    // if (Platform.isAndroid) {
    //   return 'http://10.0.2.2:3000';
    // }
    // return 'http://localhost:3000';
  }

  // Timeout settings
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);
}
