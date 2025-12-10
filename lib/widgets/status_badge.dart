import 'package:flutter/material.dart';
import '../models/report.dart';

// Status Badge Component untuk menampilkan status laporan
class StatusBadge extends StatelessWidget {
  final ReportStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    Color bgColor;
    String text;
    IconData icon;

    switch (status) {
      case ReportStatus.dalamProses:
        color = const Color(0xFF9E9E9E);
        bgColor = color.withOpacity(0.15);
        text = 'Dalam Proses';
        icon = Icons.hourglass_empty;
        break;
      case ReportStatus.verifikasi:
        color = const Color(0xFFFFA500);
        bgColor = color.withOpacity(0.15);
        text = 'Verifikasi';
        icon = Icons.verified_outlined;
        break;
      case ReportStatus.prosesLanjutan:
        color = const Color(0xFF2196F3);
        bgColor = color.withOpacity(0.15);
        text = 'Proses Lanjutan';
        icon = Icons.autorenew;
        break;
      case ReportStatus.selesai:
        color = const Color(0xFF17C964);
        bgColor = color.withOpacity(0.15);
        text = 'Selesai';
        icon = Icons.check_circle_outline;
        break;
      case ReportStatus.ditolak:
        color = const Color(0xFFFF4D4F);
        bgColor = color.withOpacity(0.15);
        text = 'Ditolak';
        icon = Icons.cancel_outlined;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}