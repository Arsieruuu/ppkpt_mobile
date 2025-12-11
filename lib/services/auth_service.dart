import 'api_client.dart';

class AuthService {
  final ApiClient _apiClient = ApiClient();

  // Login dengan identity_number dan password
  Future<Map<String, dynamic>> login(
    String identityNumber,
    String password,
  ) async {
    try {
      final response = await _apiClient.post(
        '/api/auth/login',
        data: {'identity_number': identityNumber, 'password': password},
      );

      print('Response status: ${response.statusCode}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        // Pastikan data adalah Map
        final data = response.data is Map<String, dynamic>
            ? response.data
            : <String, dynamic>{};

        // Simpan token jika ada
        if (data['token'] != null) {
          await ApiClient.setToken(data['token'].toString());
        }

        // Sesuaikan dengan response API Anda:
        // API mengirim: { message, token, user }
        return {
          'success': true,
          'message': data['message']?.toString() ?? 'Login berhasil',
          'token': data['token']?.toString() ?? '',
          'data': data['user'] ?? data['data'] ?? {}, // Support both formats
        };
      }

      return {'success': false, 'message': 'Login gagal'};
    } catch (e) {
      print('Error in login: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Logout
  Future<void> logout() async {
    await ApiClient.clearToken();
  }

  // Cek apakah user sudah login
  Future<bool> isLoggedIn() async {
    final token = await ApiClient.getToken();
    return token != null && token.isNotEmpty;
  }
}
