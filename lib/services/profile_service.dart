import 'api_client.dart';
import '../models/profile.dart';

class ProfileService {
  final ApiClient _apiClient = ApiClient();

  // Get user profile
  Future<Map<String, dynamic>> getProfile() async {
    try {
      print('=== FETCHING USER PROFILE ===');
      final response = await _apiClient.get('/api/me');

      print('Profile Response: ${response.data}');

      if (response.statusCode == 200) {
        final userData = response.data['user'];
        final profileData = response.data['profile'];

        return {
          'success': true,
          'user': User.fromJson(userData),
          'profile': profileData != null ? Profile.fromJson(profileData) : null,
        };
      }

      return {
        'success': false,
        'message': 'Gagal mengambil data profile',
      };
    } catch (e) {
      print('Error in getProfile: $e');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  // Update user profile
  Future<Map<String, dynamic>> updateProfile({
    required String nim,
    required String fullName,
    required String jurusan,
    required String phoneNumber,
  }) async {
    try {
      print('=== UPDATING PROFILE ===');
      
      final requestData = {
        'nim': nim,
        'full_name': fullName,
        'jurusan': jurusan,
        'phone_number': phoneNumber,
      };

      print('Request Data: $requestData');

      final response = await _apiClient.put('/api/profile', data: requestData);

      print('Update Profile Response: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'Profile berhasil diperbarui',
          'profile': Profile.fromJson(response.data['profile']),
        };
      }

      return {
        'success': false,
        'message': response.data['message'] ?? 'Gagal memperbarui profile',
      };
    } catch (e) {
      print('Error in updateProfile: $e');
      
      // Parse error message dari backend
      if (e.toString().contains('400')) {
        return {
          'success': false,
          'message': 'Semua field wajib diisi dengan benar',
        };
      }
      
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }
}
