import 'package:flutter/material.dart';
import '../models/report.dart';
import '../pages/detail_laporan_page.dart';
import '../pages/detail_report_selesai_page.dart';
import '../pages/detail_progress_page.dart';
import '../pages/detail_laporan_ditolak_page.dart';
import 'status_badge.dart';

// Report Card Component untuk menampilkan kartu laporan
class ReportCard extends StatelessWidget {
  final Report report;

  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to appropriate detail page based on status
        if (report.status == ReportStatus.selesai) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailReportSelesaiPage(report: report),
            ),
          );
        } else if (report.status == ReportStatus.ditolak) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailLaporanDitolakPage(report: report),
            ),
          );
        } else if (report.status == ReportStatus.dalamProses || 
                   report.status == ReportStatus.verifikasi || 
                   report.status == ReportStatus.prosesLanjutan) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailProgressPage(report: report),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailLaporanPage(report: report),
            ),
          );
        }
      },
      child: Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            offset: const Offset(0, 4),
            blurRadius: 12,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Row(
        children: [
          // Leading Icon
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFE6F2FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.insert_drive_file,
              color: Color(0xFF1683FF),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          // Handle tap on report code
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Kode laporan: ${report.id}')),
                          );
                        },
                        child: Text(
                          report.id,
                          style: const TextStyle(
                            color: Color(0xFF1683FF),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    StatusBadge(status: report.status),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      size: 14,
                      color: Color(0xFF6D6D6D),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      report.time,
                      style: const TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.calendar_month,
                      size: 14,
                      color: Color(0xFF6D6D6D),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _formatDate(report.date),
                      style: const TextStyle(
                        color: Color(0xFF6D6D6D),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
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
}