import 'package:flutter/material.dart';
import '../models/report.dart';

class DetailLaporanPage extends StatelessWidget {
  final Report report;

  const DetailLaporanPage({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    final isDitolak = report.status == ReportStatus.ditolak;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Image.asset(
            'assets/icons/back.png',
            width: 39,
            height: 39,
            fit: BoxFit.contain,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            Text(
              isDitolak ? 'Kekerasan Fisik' : report.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                color: Colors.black87,
              ),
            ),
            Text(
              report.id,
              style: const TextStyle(
                color: Color(0xFF6D6D6D),
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Status Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
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
              child: Column(
                children: [
                  // Icon
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4D4F).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/ic_deny.png',
                        width: 32,
                        height: 32,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Status Text
                  const Text(
                    'Laporan Anda Ditolak !',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Description
                  const Text(
                    'Maaf, Laporan Yang Anda Lampirkan Kami Tolak Dan Tidak Dapat Di Verifikasi',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6D6D6D),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Reason Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Alasan :',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Jenis Pelanggaran Yang Anda Laporkan Tidak Sesuai Dengan Ketentuan Dan Cakupan PPKPT',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6D6D6D),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
