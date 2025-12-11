import 'api_client.dart';

class LaporanService {
  final ApiClient _apiClient = ApiClient();

  // Check apakah user punya laporan aktif
  Future<Map<String, dynamic>> checkActiveLaporan() async {
    try {
      print('=== CHECKING ACTIVE LAPORAN ===');
      final response = await _apiClient.get('/api/laporan/check-active');

      print('Check Active Response: ${response.data}');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'has_active': response.data['has_active'] ?? false,
          'can_create': response.data['can_create'] ?? true,
          'laporan_aktif': response.data['laporan_aktif'],
          'message': response.data['message'] ?? '',
        };
      }

      return {
        'success': false,
        'message': 'Gagal mengecek status laporan',
      };
    } catch (e) {
      print('Error in checkActiveLaporan: $e');
      return {
        'success': false,
        'message': e.toString(),
      };
    }
  }

  // Submit laporan baru
  Future<Map<String, dynamic>> submitLaporan({
    required String nama,
    required String nomorTelepon,
    required String domisili,
    required String tanggal,
    required String jenisKekerasan,
    required String ceritaPeristiwa,
    String? pelampiran_bukti, // Optional, untuk nanti pakai Google Cloud
    String? disabilitas,
    String? statusPelapor,
    String? alasan,
    String? alasanLainnya,
    String? pendampingan,
  }) async {
    try {
      final requestData = {
        'nama': nama,
        'nomor_telepon': nomorTelepon,
        'domisili': domisili,
        'tanggal': tanggal,
        'jenis_kekerasan': jenisKekerasan,
        'cerita_peristiwa': ceritaPeristiwa,
        'pelampiran_bukti': pelampiran_bukti,
        'disabilitas': disabilitas,
        'status_pelapor': statusPelapor,
        'alasan': alasan,
        'alasan_lainnya': alasanLainnya,
        'pendampingan': pendampingan,
      };

      print('=== REQUEST DATA KE API ===');
      print(requestData);
      print('===========================');

      final response = await _apiClient.post('/api/laporan', data: requestData);

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'Laporan berhasil dibuat',
          'laporan_id': response.data['laporan_id'],
        };
      }

      return {'success': false, 'message': 'Gagal membuat laporan'};
    } catch (e) {
      print('Error in submitLaporan: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Ambil laporan milik user yang login
  Future<Map<String, dynamic>> getMyLaporan() async {
    try {
      final response = await _apiClient.get('/api/laporan/me');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'Berhasil mengambil data',
          'data': response.data['data'] ?? [],
        };
      }

      return {'success': false, 'message': 'Gagal mengambil data laporan'};
    } catch (e) {
      print('Error in getMyLaporan: $e');
      return {'success': false, 'message': e.toString()};
    }
  }

  // Ambil detail riwayat laporan berdasarkan ID
  Future<Map<String, dynamic>> getRiwayatLaporan(int laporanId) async {
    try {
      final response = await _apiClient.get('/api/riwayat-laporan/$laporanId');

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': response.data['message'] ?? 'Berhasil mengambil riwayat',
          'data': response.data['data'] ?? [],
        };
      }

      return {'success': false, 'message': 'Gagal mengambil riwayat laporan'};
    } catch (e) {
      print('Error in getRiwayatLaporan: $e');
      return {'success': false, 'message': e.toString()};
    }
  }
}
