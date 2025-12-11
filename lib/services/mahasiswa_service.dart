import 'api_client.dart';

class MahasiswaService {
  final ApiClient _apiClient = ApiClient();

  // Get current user's mahasiswa profile
  Future<Map<String, dynamic>> getMyProfile() async {
    try {
      print('=== FETCHING MAHASISWA PROFILE ===');
      print('Endpoint: /api/me');
      
      final response = await _apiClient.get('/api/me');
      
      print('Response Status Code: ${response.statusCode}');
      print('Response Headers: ${response.headers}');
      print('Response Data: ${response.data}');
      print('Response Data Type: ${response.data.runtimeType}');
      print('Is Map: ${response.data is Map<String, dynamic>}');
      
      // Check if response.data is already a Map
      if (response.data is Map<String, dynamic>) {
        print('✓ Response is valid Map format');
        print('Response keys: ${response.data.keys.toList()}');
        return response.data;
      }
      
      // If response.data is not a Map, wrap it
      print('✗ Response is NOT a Map, wrapping...');
      return {
        'success': false,
        'message': 'Invalid response format',
        'raw_data': response.data,
      };
    } catch (e, stackTrace) {
      print('✗ ERROR in getMyProfile: $e');
      print('Error Type: ${e.runtimeType}');
      print('Stack trace: $stackTrace');
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
      print('=== UPDATING MAHASISWA PROFILE ===');
      print('Endpoint: /api/me');
      print('NIM: $nim');
      print('Full Name: $fullName');
      print('Jurusan: $jurusan');
      print('Phone: $phoneNumber');
      
      final response = await _apiClient.put('/api/me', data: {
        'nim': nim,
        'full_name': fullName,
        'jurusan': jurusan,
        'phone_number': phoneNumber,
      });
      
      print('Update Response Status: ${response.statusCode}');
      print('Update Response Data: ${response.data}');
      
      // Check if response.data is already a Map
      if (response.data is Map<String, dynamic>) {
        return response.data;
      }
      
      // If response.data is not a Map, wrap it
      return {
        'success': false,
        'message': 'Invalid response format',
        'raw_data': response.data,
      };
    } catch (e, stackTrace) {
      print('Error in updateMyProfile: $e');
      print('Stack trace: $stackTrace');
      return {
        'success': false,
        'message': 'Gagal memperbarui profile: $e',
      };
    }
  }
}
