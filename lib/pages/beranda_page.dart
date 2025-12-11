import 'package:flutter/material.dart';
import 'notifikasi_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import '../services/profile_service.dart';
import '../services/auth_service.dart';
import '../services/laporan_service.dart';
import '../models/profile.dart';

class BerandaPage extends StatefulWidget {
  final Function(int)? onNavigateToTab;

  const BerandaPage({super.key, this.onNavigateToTab});

  @override
  State<BerandaPage> createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage> {
  final ProfileService _profileService = ProfileService();
  final AuthService _authService = AuthService();
  final LaporanService _laporanService = LaporanService();
  Profile? _profile;
  bool _isLoading = true;
  bool _isLoggedIn = false;
  bool _hasReports = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final loggedIn = await _authService.isLoggedIn();
      setState(() {
        _isLoggedIn = loggedIn;
      });

      if (loggedIn) {
        // Load profile
        final response = await _profileService.getProfile();

        // Check if user has reports
        try {
          final laporanResponse = await _laporanService.getMyLaporan();
          print('=== DEBUG BERANDA ===');
          print('Laporan Response: $laporanResponse');

          // PERBAIKAN: data ada di key 'data', bukan 'laporan'
          final reports = laporanResponse['data'] as List? ?? [];
          print('User logged in: $loggedIn');
          print('Reports count: ${reports.length}');
          print('Has reports: ${reports.isNotEmpty}');

          setState(() {
            _profile = response['profile'];
            _hasReports = reports.isNotEmpty;
            _isLoading = false;
          });
        } catch (e) {
          print('Error fetching reports: $e');
          setState(() {
            _profile = response['profile'];
            _hasReports = false;
            _isLoading = false;
          });
        }
      } else {
        // Guest user - reset all data
        setState(() {
          _profile = null;
          _hasReports = false;
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      setState(() {
        _profile = null;
        _hasReports = false;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Header with SafeArea
            SafeArea(bottom: false, child: _buildHeader(context)),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Progress Card or Empty State
                    if (_isLoading)
                      _buildLoadingCard()
                    else if (_isLoggedIn && _hasReports)
                      _buildReportProgressCard()
                    else
                      _buildEmptyState(),

                    const SizedBox(height: 16),

                    // Combined Edukasi & Berita Card - Full height to bottom
                    Container(
                      width: double.infinity,
                      constraints: BoxConstraints(
                        minHeight:
                            MediaQuery.of(context).size.height *
                            0.6, // Minimum height
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 100,
                        ), // Space for navbar
                        child: Column(
                          children: [
                            const SizedBox(height: 32),

                            // Edukasi Section
                            _buildEdukasiSection(),

                            const SizedBox(height: 32),

                            // Berita Section
                            _buildBeritaSection(),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfilePage()),
              );
            },
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade200,
              child: const Icon(Icons.person, size: 28, color: Colors.grey),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Selamat Datang !',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                Text(
                  _isLoading
                      ? 'Loading...'
                      : _isLoggedIn && _profile?.fullName != null
                      ? _profile!.fullName!
                      : 'Guest',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1683FF),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotifikasiPage()),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Loading state
  Widget _buildLoadingCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  // Empty state - text and button directly on background (not in card)
  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 35, right: 40, top: 10, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                height: 1.2,
              ),
              children: [
                TextSpan(
                  text: 'E-LAPOR ',
                  style: TextStyle(color: Color(0xFF1683FF)),
                ),
                TextSpan(
                  text: 'PPKPT\nPOLINELA',
                  style: TextStyle(color: Color(0xFFFFB800)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Subtitle - dekatkan spacing
          RichText(
            text: const TextSpan(
              style: TextStyle(fontSize: 14, height: 1.3),
              children: [
                TextSpan(
                  text: 'Keberanian Anda ',
                  style: TextStyle(color: Color(0xFF1683FF)),
                ),
                TextSpan(
                  text: 'Membuka ',
                  style: TextStyle(
                    color: Color(0xFFFFB800),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: 'Jalan Perlindungan',
                  style: TextStyle(color: Color(0xFF1683FF)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Button
          ElevatedButton(
            onPressed: () {
              // Check login status before navigate
              if (_isLoggedIn) {
                // Mahasiswa logged in -> navigate to Lapor tab via callback
                if (widget.onNavigateToTab != null) {
                  widget.onNavigateToTab!(1); // Navigate to index 1 (Lapor)
                }
              } else {
                // Guest user -> show login dialog
                _showLoginDialog();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB800),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 3,
            ),
            child: const Text(
              'Buat Laporan',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  // Show login dialog for guest users
  void _showLoginDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Sad emoji
                const Text('😔', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                // Message
                const Text(
                  'Yah kamu belum login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kamu harus login terlebih dahulu untuk mengakses fitur pelaporan',
                  style: TextStyle(fontSize: 14, color: Color(0xFF666666)),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context); // Close dialog
                      // Navigate to login page
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                      // If login successful, reload data
                      if (result == true && mounted) {
                        _loadUserData(); // Refresh data after login
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0068FF),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Yuk login terlebih dahulu',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Cancel button
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Nanti saja',
                    style: TextStyle(
                      color: Color(0xFF666666),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Card when user has active reports
  Widget _buildReportProgressCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('assets/images/illustrations/ui_card.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Progres Laporan Kamu',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1683FF),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Selalu Pantau Update Apapun Itu',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kamu bisa melihat tingkatan progress laporan di menu pelaporan',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.orange, width: 3),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '1/4',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  Text(
                    'Tahapan',
                    style: TextStyle(fontSize: 8, color: Colors.orange),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEdukasiSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Edukasi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                width: 280,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: const DecorationImage(
                    image: AssetImage(
                      'assets/images/illustrations/img_edu.png',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1683FF),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          'EDUKASI',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Pencegahan Kekerasan Seksual Pada Jenjang Perguruan Tinggi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Kekerasan Seksual adalah setiap perbuatan merendahkan, menghina, menyerang, dan/atau...',
                        style: TextStyle(color: Colors.white70, fontSize: 12),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBeritaSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Berita',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: const Text(
                                'Berita',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Icon(
                              Icons.access_time,
                              size: 14,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '29 Agustus 2025',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Sosialisasi Satgas PPKPT Polinela di Acara Teknologi Rekayasa Perangkat Lunak',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/illustrations/img_news.png',
                      width: 80,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 80,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.image,
                            color: Colors.grey,
                            size: 30,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
