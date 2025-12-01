import 'package:flutter/material.dart';
import '../models/report.dart';

class DetailReportSelesaiPage extends StatefulWidget {
  final Report report;

  const DetailReportSelesaiPage({super.key, required this.report});

  @override
  State<DetailReportSelesaiPage> createState() =>
      _DetailReportSelesaiPageState();
}

class _DetailReportSelesaiPageState extends State<DetailReportSelesaiPage> {
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
                    padding: const EdgeInsets.all(8),
                    child: Image.asset(
                      'assets/icons/back.png',
                      width: 22,
                      height: 22,
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

          // Card wrapper from blue badge to illustration
          Container(
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

                // Timeline
                _buildTimeline(),

                const SizedBox(height: 16),

                // Psikolog Card
                _buildPsikologCard(),

                const SizedBox(height: 2),

                // Illustration
                _buildIllustrationSection(),
              ],
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          date: '24 Juni',
          time: '17:45',
          title: 'Laporan anda berhasil terkirim dan sedang di periksa',
          icon: 'ic_loading',
          isLast: false,
        ),
        _buildTimelineItem(
          date: '24 Juni',
          time: '20:35',
          title: 'Laporan anda telah terverifikasi oleh petugas',
          icon: 'ic_verif',
          isLast: false,
        ),
        _buildTimelineItem(
          date: '25 Juni',
          time: '09:40',
          title: 'Laporan anda sedang ditindak lanjuti oleh petugas PPKPT',
          icon: 'ic_progress',
          isLast: false,
        ),
        _buildTimelineItem(
          date: '26 Juni',
          time: '13:11',
          title: 'Selesai',
          icon: 'ic_done',
          isLast: true,
        ),
      ],
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String time,
    required String title,
    required String icon,
    required bool isLast,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left side - Date and Time
        SizedBox(
          width: 45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(fontSize: 12, color: Color(0xFF6B7280)),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 12),

        // Timeline line and icon
        Column(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1683FF), width: 2),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/$icon.png',
                  width: 16,
                  height: 16,
                ),
              ),
            ),
            if (!isLast)
              Container(width: 2, height: 40, color: const Color(0xFFE5E7EB)),
          ],
        ),

        const SizedBox(width: 12),

        // Content
        Expanded(
          child: Container(
            padding: EdgeInsets.only(bottom: isLast ? 0 : 24),
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF374151),
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPsikologCard() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1683FF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Icon(
                    Icons.description,
                    size: 14,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Kekerasan Seksual',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              widget.report.id,
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF1683FF),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(height: 1, color: Color(0xFFE5E7EB)),
            const SizedBox(height: 16),
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: const AssetImage(
                    'assets/images/profile/profile.png',
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
                          color: Color(0xFF1A1A1A),
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Nip. 8990028030',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
        ),
      ),
    );
  }
}
