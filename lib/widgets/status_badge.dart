import 'package:flutter/material.dart';
import '../models/report.dart';

// Status Badge Component untuk menampilkan status laporan
class StatusBadge extends StatelessWidget {
  final ReportStatus status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isCompleted = status == ReportStatus.selesai;
    final color = isCompleted ? const Color(0xFF17C964) : const Color(0xFFFF4D4F);
    final bgColor = color.withOpacity(0.15);
    final text = isCompleted ? 'Selesai' : 'Ditolak';
    final iconPath = isCompleted ? 'assets/icons/ic_done.png' : 'assets/icons/ic_deny.png';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath,
            width: 12,
            height: 12,
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