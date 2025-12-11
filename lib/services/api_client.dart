import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_config.dart';

class ApiClient {
  late final Dio _dio;
  static String? _token;

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        sendTimeout: ApiConfig.sendTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Interceptor untuk menambahkan token
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print('=== REQUEST INTERCEPTOR ===');
          print('Method: ${options.method}');
          print('URL: ${options.uri}');
          print('Token in memory: ${_token != null ? "YES" : "NO"}');
          
          if (_token != null) {
            options.headers['Authorization'] = 'Bearer $_token';
            print('✓ Authorization header added');
          } else {
            print('✗ No token available');
          }
          
          print('Headers: ${options.headers}');
          return handler.next(options);
        },
        onError: (error, handler) {
          print('=== ERROR INTERCEPTOR ===');
          print('Status: ${error.response?.statusCode}');
          print('Message: ${error.message}');
          
          // Handle error global
          if (error.response?.statusCode == 401) {
            print('✗ 401 Unauthorized - Clearing token');
            // Token expired, clear token
            clearToken();
          }
          return handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;

  // Set token untuk authenticated requests
  static Future<void> setToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Get token dari storage
  static Future<String?> getToken() async {
    if (_token != null) return _token;
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    return _token;
  }

  // Clear token (logout)
  static Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  // Helper method untuk GET
  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      print('=== API CLIENT GET REQUEST ===');
      print('URL: ${ApiConfig.baseUrl}$path');
      print('Token exists: ${_token != null}');
      if (_token != null) {
        print('Token preview: ${_token!.substring(0, _token!.length > 20 ? 20 : _token!.length)}...');
      }
      print('Query Params: $queryParameters');
      
      final response = await _dio.get(path, queryParameters: queryParameters);
      
      print('✓ GET Success - Status: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('✗ GET Failed - Type: ${e.type}, Message: ${e.message}');
      print('Response Status: ${e.response?.statusCode}');
      print('Response Data: ${e.response?.data}');
      throw _handleError(e);
    }
  }

  // Helper method untuk POST
  Future<Response> post(String path, {dynamic data}) async {
    try {
      return await _dio.post(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Helper method untuk POST multipart (upload file)
  Future<Response> postMultipart(String path, FormData formData) async {
    try {
      return await _dio.post(
        path,
        data: formData,
        options: Options(contentType: 'multipart/form-data'),
      );
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Helper method untuk PUT
  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Helper method untuk DELETE
  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Handle error dan convert ke pesan yang user-friendly
  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Koneksi timeout. Periksa koneksi internet Anda.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        
        // Safely extract message from response data
        String? message;
        final responseData = error.response?.data;
        if (responseData is Map<String, dynamic>) {
          message = responseData['message'] as String?;
        } else if (responseData is String) {
          message = responseData;
        }
        
        if (statusCode == 400) {
          return message ?? 'Data tidak valid.';
        } else if (statusCode == 401) {
          return 'Sesi Anda telah berakhir. Silakan login kembali.';
        } else if (statusCode == 404) {
          return 'Data tidak ditemukan.';
        } else if (statusCode == 500) {
          return 'Terjadi kesalahan pada server.';
        }
        return message ?? 'Terjadi kesalahan. Coba lagi nanti.';
      case DioExceptionType.cancel:
        return 'Permintaan dibatalkan.';
      case DioExceptionType.connectionError:
        return 'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.';
      default:
        return 'Terjadi kesalahan tidak terduga.';
    }
  }
}
