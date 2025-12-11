import 'api_client.dart';

class MahasiswaService {
  final ApiClient _apiClient = ApiClient();

  // Get current user's mahasiswa profile
  Future<Map<String, dynamic>> getMyProfile() async {
    try {
      final response = await _apiClient.get('/api/mahasiswa/me');
      return response.data;
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal mengambil data profile: $e',
      };
    }
  }

  // Update current user's mahasiswa profile
  Future<Map<String, dynamic>> updateMyProfile({
    required String nim,
    required String fullName,
    required String jurusan,
    required String phoneNumber,
  }) async {
    try {
      final response = await _apiClient.put('/api/mahasiswa/me', data: {
        'nim': nim,
        'full_name': fullName,
        'jurusan': jurusan,
        'phone_number': phoneNumber,
      });
      return response.data;
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal memperbarui profile: $e',
      };
    }
  }
}
