import 'package:flutter/material.dart';
import '../models/report.dart';

class DetailReportSelesaiPage extends StatefulWidget {
  final Report report;

  const DetailReportSelesaiPage({super.key, required this.report});

  @override
  State<DetailReportSelesaiPage> createState() => _DetailReportSelesaiPageState();
}

class _DetailReportSelesaiPageState extends State<DetailReportSelesaiPage> {
  late PageController _pageController;
  int _currentPage = 0;
  
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) => setState(() => _currentPage = index),
          children: [
            _buildDetailPage(),
            _buildLogMoodPage(),
          ],
        ),
      ),
    );
  }
  Widget _buildDetailPage() {
    return Column(
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
        
        // Blue Header Badge
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1683FF),
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
        
        const SizedBox(height: 18),
        
        // Illustration (outside card)
        _buildIllustrationSection(),
        
        const SizedBox(height: 20),
        
        // Dot Indicator
        _buildDotIndicators(),
        
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildDotIndicators() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildDotIndicator(0),
        const SizedBox(width: 8),
        _buildDotIndicator(1),
      ],
    );
  }

  Widget _buildDotIndicator(int index) {
    return Container(
      width: _currentPage == index ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? const Color(0xFF1683FF) : const Color(0xFFD1D5DB),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildTimeline() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildTimelineItem(
            icon: 'ic_loading',
            title: 'Laporan anda berhasil terkirim dan sedang di periksa',
            time: '17:45',
            date: '24 Jun 20:35',
            isActive: true,
            color: const Color(0xFF1683FF),
          ),
          _buildTimelineConnector(),
          _buildTimelineItem(
            icon: 'ic_verif',
            title: 'Laporan anda telah terverifikasi oleh petugas',
            time: '24 Jun',
            date: '20:35',
            isActive: true,
            color: const Color(0xFFFFA500),
          ),
          _buildTimelineConnector(),
          _buildTimelineItem(
            icon: 'ic_progress',
            title: 'Laporan anda sedang ditindak lanjuti oleh petugas PPKPT',
            time: '25 Jun',
            date: '09:40',
            isActive: true,
            color: const Color(0xFF1683FF),
          ),
          _buildTimelineConnector(),
          _buildTimelineItem(
            icon: 'ic_done',
            title: 'Selesai',
            time: '25 Jun',
            date: '15:11',
            isActive: true,
            color: const Color(0xFF17C964),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String icon,
    required String title,
    required String time,
    required String date,
    required bool isActive,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? color : const Color(0xFFE5E7EB),
                  width: 2,
                ),
              ),
              child: Center(
                child: Image.asset(
                  'assets/icons/$icon.png',
                  width: 15,
                  height: 15,
                  color: isActive ? color : const Color(0xFFE5E7EB),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  color: isActive ? const Color(0xFF1A1A1A) : const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '$time\n$date',
                style: TextStyle(
                  fontSize: 10,
                  color: isActive ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineConnector() {
    return Container(
      margin: const EdgeInsets.only(left: 14, top: 5, bottom: 5),
      width: 2,
      height: 18,
      color: const Color(0xFF17C964),
    );
  }

  Widget _buildPsikologCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFF1683FF), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1683FF).withOpacity(0.08),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          // Header with icon and title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: const Color(0xFF1683FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.insert_drive_file,
                  color: Colors.white,
                  size: 16,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Kekerasan Seksual',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 14),
          
          // ID
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.report.id,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF1683FF),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          
          const SizedBox(height: 14),
          
          // Psychologist info
          Row(
            children: [
              // Profile image placeholder
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFE6F2FF),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(22),
                  child: Image.asset(
                    'assets/images/profile/profile.png',
                    width: 44,
                    height: 44,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.person,
                        color: Color(0xFF1683FF),
                        size: 26,
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
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'NIP. 8990026030',
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
    );
  }

  Widget _buildLogMoodPage() {
    return Column(
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
              const Expanded(
                child: Text(
                  'Log Mood',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A1A),
                  ),
                ),
              ),
              const SizedBox(width: 46),
            ],
          ),
        ),
        
        const SizedBox(height: 80),
        
        // Card with Emoji and Message
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                offset: const Offset(0, 4),
                blurRadius: 20,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              // Emoji Mood
              Container(
                width: 160,
                height: 160,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/illustrations/logmood_smile.png',
                  fit: BoxFit.contain,
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Message
              const Text(
                'Saya sangat lega setelah kasus ini selesai, terimakasih satgas ppkpt polinela',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF6B7280),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 40),
        
        // Illustration
        _buildIllustrationSection(),
        
        const SizedBox(height: 20),
        
        // Dot Indicator
        _buildDotIndicators(),
        
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildIllustrationSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        image: const DecorationImage(
          image: AssetImage('assets/images/illustrations/illustration_card.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1683FF).withOpacity(0.1),
              const Color(0xFF17C964).withOpacity(0.1),
            ],
          ),
        ),
      ),
    );
  }
}