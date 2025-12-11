import 'package:flutter/material.dart';
import '../models/report.dart';
import '../services/laporan_service.dart';

class DetailProgressPage extends StatefulWidget {
  final Report report;

  const DetailProgressPage({super.key, required this.report});

  @override
  State<DetailProgressPage> createState() => _DetailProgressPageState();
}

class _DetailProgressPageState extends State<DetailProgressPage> {
  final LaporanService _laporanService = LaporanService();
  bool isLoading = true;
  List<Map<String, dynamic>> riwayatData = [];

  @override
  void initState() {
    super.initState();
    _loadRiwayat();
  }

  Future<void> _loadRiwayat() async {
    if (widget.report.databaseId == null) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      print('=== FETCHING RIWAYAT FOR ID: ${widget.report.databaseId} ===');
      final result = await _laporanService.getRiwayatLaporan(widget.report.databaseId!);
      print('Riwayat Result: $result');
      
      if (result['success'] == true && result['data'] != null) {
        setState(() {
          riwayatData = List<Map<String, dynamic>>.from(result['data']);
          isLoading = false;
        });
        print('Total riwayat: ${riwayatData.length}');
      } else {
        print('Failed to load riwayat');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading riwayat: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(child: _buildDetailPage()),
    );
  }

  Widget _buildDetailPage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/backgrounds/background2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.report.title,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.report.id,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1683FF),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 46),
              ],
            ),
          ),

          // Card wrapper
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(39),
                  border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      offset: const Offset(0, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Blue Header Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0068FF),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Riwayat Progress Laporan Anda',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Timeline based on status
                    _buildTimelineBasedOnStatus(),

                    const SizedBox(height: 16),

                    // Information Card
                    _buildInfoCard(),

                    const SizedBox(height: 2),

                    // Illustration
                    _buildIllustrationSection(),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTimelineBasedOnStatus() {
    // Jika masih loading, tampilkan skeleton
    if (isLoading) {
      return Column(
        children: [
          _buildTimelineItem(
            date: '...',
            time: '...',
            title: 'Memuat data riwayat...',
            isActive: true,
            isLast: true,
            customIcon: Icons.hourglass_empty,
          ),
        ],
      );
    }

    // Jika ada data dari API, tampilkan
    if (riwayatData.isNotEmpty) {
      return Column(
        children: riwayatData.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == riwayatData.length - 1;
          
          return _buildTimelineItem(
            date: _formatApiDate(item['created_at']),
            time: _formatApiTime(item['created_at']),
            title: item['aksi'] ?? 'Status tidak diketahui',
            isActive: isLast, // Item terakhir adalah yang aktif
            isLast: isLast,
            customIcon: _getIconForStatus(item['status_baru']),
          );
        }).toList(),
      );
    }

    // Fallback jika tidak ada data, gunakan logic lama
    switch (widget.report.status) {
      case ReportStatus.dalamProses:
        return Column(
          children: [
            _buildTimelineItem(
              date: _formatDate(widget.report.date),
              time: widget.report.time,
              title: 'Laporan anda berhasil terkirim dan sedang di periksa',
              isActive: true,
              isLast: true,
              customIcon: Icons.hourglass_empty,
            ),
          ],
        );
      case ReportStatus.verifikasi:
        return Column(
          children: [
            _buildTimelineItem(
              date: _formatDate(widget.report.date.subtract(const Duration(days: 1))),
              time: '10.00',
              title: 'Laporan anda berhasil terkirim dan sedang di periksa',
              isActive: false,
              isLast: false,
              customIcon: Icons.hourglass_empty,
            ),
            _buildTimelineItem(
              date: _formatDate(widget.report.date),
              time: widget.report.time,
              title: 'Laporan anda telah terverifikasi oleh petugas',
              isActive: true,
              isLast: true,
              customIcon: Icons.verified_outlined,
            ),
          ],
        );
      case ReportStatus.prosesLanjutan:
        return Column(
          children: [
            _buildTimelineItem(
              date: _formatDate(widget.report.date.subtract(const Duration(days: 1))),
              time: '17.45',
              title: 'Laporan anda berhasil terkirim dan sedang di periksa',
              isActive: false,
              isLast: false,
              customIcon: Icons.hourglass_empty,
            ),
            _buildTimelineItem(
              date: _formatDate(widget.report.date.subtract(const Duration(days: 1))),
              time: '20.35',
              title: 'Laporan anda telah terverifikasi oleh petugas',
              isActive: false,
              isLast: false,
              customIcon: Icons.verified_outlined,
            ),
            _buildTimelineItem(
              date: _formatDate(widget.report.date),
              time: widget.report.time,
              title: 'Laporan anda sedang ditindak lanjuti oleh petugas PPKPT',
              isActive: true,
              isLast: true,
              customIcon: Icons.sync,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildTimelineItem({
    required String date,
    required String time,
    required String title,
    required bool isActive,
    required bool isLast,
    IconData? customIcon,
  }) {
    IconData iconToShow;
    if (customIcon != null) {
      iconToShow = customIcon;
    } else if (isActive) {
      iconToShow = Icons.autorenew;
    } else {
      iconToShow = Icons.check;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline indicator
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF0068FF) : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF0068FF),
                  width: 2,
                ),
              ),
              child: Icon(
                iconToShow,
                color: isActive ? Colors.white : const Color(0xFF0068FF),
                size: 16,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: const Color(0xFF0068FF).withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 12),
        // Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '$date\n$time',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: isActive ? Colors.black87 : Colors.grey[700],
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard() {
    String statusText;
    String infoText;

    switch (widget.report.status) {
      case ReportStatus.dalamProses:
        statusText = 'Dalam Proses';
        infoText = 'Laporan Anda sedang dalam tahap pemeriksaan awal. Tim kami akan segera memverifikasi data yang Anda kirimkan.';
        break;
      case ReportStatus.verifikasi:
        statusText = 'Verifikasi';
        infoText = 'Laporan Anda telah diverifikasi dan dinyatakan valid. Saat ini sedang dalam proses penugasan ke tim terkait.';
        break;
      case ReportStatus.prosesLanjutan:
        statusText = 'Proses Lanjutan';
        infoText = 'Laporan Anda sedang ditindaklanjuti oleh tim PPKPT. Kami akan memberikan update secepatnya.';
        break;
      default:
        statusText = 'Status';
        infoText = 'Informasi status laporan.';
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFF0068FF).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0068FF),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            infoText,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6F2FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/profile/profile.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.person,
                          color: Color(0xFF0068FF),
                          size: 24,
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Rosse Adelle S.Psi',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Nip. 8990028030',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6D6D6D),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month]}';
  }

  String _formatApiDate(String? timestamp) {
    if (timestamp == null) return '';
    try {
      final dateTime = DateTime.parse(timestamp);
      final months = [
        '', 'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
        'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
      ];
      return '${dateTime.day} ${months[dateTime.month]}';
    } catch (e) {
      return '';
    }
  }

  String _formatApiTime(String? timestamp) {
    if (timestamp == null) return '00:00';
    try {
      final dateTime = DateTime.parse(timestamp);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return '00:00';
    }
  }

  IconData _getIconForStatus(String? status) {
    switch (status) {
      case 'Dalam Proses':
        return Icons.hourglass_empty;
      case 'Verifikasi':
        return Icons.verified_outlined;
      case 'Proses Lanjutan':
        return Icons.sync;
      case 'Selesai':
        return Icons.check_circle_outline;
      case 'Ditolak':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline;
    }
  }

  Widget _buildIllustrationSection() {
    return Container(
      height: 120,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: Image.asset(
          'assets/images/illustrations/illustration_card.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 120,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(
                Icons.image_not_supported,
                size: 40,
                color: Colors.grey[400],
              ),
            );
          },
        ),
      ),
    );
  }
}
