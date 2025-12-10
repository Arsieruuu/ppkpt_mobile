import 'dart:io';

class ApiConfig {
  // Base URL untuk API Express
  // Android Emulator: gunakan 10.0.2.2 untuk mengakses localhost PC
  // iOS Simulator: gunakan localhost
  static String get baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:3000';
    }
    return 'http://localhost:3000';
  }

  // Timeout settings
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration sendTimeout = Duration(seconds: 20);
}
