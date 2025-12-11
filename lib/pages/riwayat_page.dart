import 'package:flutter/material.dart';
import '../models/report.dart';
import '../widgets/report_card.dart';
import '../services/laporan_service.dart';
import '../services/auth_service.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage>
    with SingleTickerProviderStateMixin {
  final LaporanService _laporanService = LaporanService();
  final AuthService _authService = AuthService();
  late TabController _tabController;
  bool isLoading = false;
  bool isCheckingLogin = true;
  bool isLoggedIn = false;
  String selectedFilter = 'Semua';
  List<Report> allReports = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _checkLoginAndLoadData();
  }

  Future<void> _checkLoginAndLoadData() async {
    setState(() {
      isCheckingLogin = true;
    });

    // Check login status
    final loggedIn = await _authService.isLoggedIn();

    setState(() {
      isLoggedIn = loggedIn;
      isCheckingLogin = false;
    });

    // Load data only if logged in
    if (loggedIn) {
      _loadLaporan();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadLaporan() async {
    setState(() {
      isLoading = true;
    });

    try {
      print('=== FETCHING LAPORAN ===');
      final result = await _laporanService.getMyLaporan();
      print('API Result: $result');

      if (result['success'] == true && result['data'] != null) {
        final List<dynamic> data = result['data'];
        print('Total laporan: ${data.length}');

        setState(() {
          allReports = data.map((item) {
            print('=== MAPPING ITEM ===');
            print('Kode Laporan: ${item['kode_laporan']}');
            print('Jam: ${item['jam']}');
            print('Tanggal: ${item['tanggal']}');
            print('Jenis: ${item['jenis_kekerasan']}');
            print('Status: ${item['status_baru']}');
            print('==================');

            // API sudah menyediakan jam dan tanggal yang terformat
            String reportTime = item['jam'] ?? '00:00';

            // Parse tanggal dari format "12 Des" ke DateTime
            DateTime reportDate = _parseTanggalIndonesia(item['tanggal']);

            // Gunakan id dari database untuk fetch detail nanti
            return Report(
              id: item['kode_laporan']?.toString() ?? 'LP-${item['id']}',
              title: item['jenis_kekerasan'] ?? 'Laporan',
              time: reportTime,
              date: reportDate,
              status: _mapStatus(item['status_baru']),
              databaseId: item['id'], // Simpan database ID untuk fetch detail
            );
          }).toList();
          isLoading = false;
        });
        print('Mapped reports: ${allReports.length}');
      } else {
        print('API failed or no data');
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading laporan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  DateTime _parseTanggalIndonesia(String? tanggalStr) {
    if (tanggalStr == null) return DateTime.now();

    try {
      // Format dari API: "12 Des"
      final parts = tanggalStr.split(' ');
      if (parts.length != 2) return DateTime.now();

      final day = int.parse(parts[0]);
      final monthMap = {
        'Jan': 1,
        'Feb': 2,
        'Mar': 3,
        'Apr': 4,
        'Mei': 5,
        'Jun': 6,
        'Jul': 7,
        'Agu': 8,
        'Sep': 9,
        'Okt': 10,
        'Nov': 11,
        'Des': 12,
      };

      final month = monthMap[parts[1]] ?? DateTime.now().month;
      final year = DateTime.now().year;

      return DateTime(year, month, day);
    } catch (e) {
      print('Error parsing tanggal: $e');
      return DateTime.now();
    }
  }

  ReportStatus _mapStatus(String? status) {
    switch (status) {
      case 'Dalam Proses':
        return ReportStatus.dalamProses;
      case 'Verifikasi':
        return ReportStatus.verifikasi;
      case 'Proses Lanjutan':
        return ReportStatus.prosesLanjutan;
      case 'Selesai':
        return ReportStatus.selesai;
      case 'Ditolak':
        return ReportStatus.ditolak;
      default:
        return ReportStatus.dalamProses;
    }
  }

  List<Report> _filterByDate(List<Report> reports) {
    final now = DateTime.now();

    switch (selectedFilter) {
      case 'Hari Ini':
        return reports
            .where(
              (report) =>
                  report.date.year == now.year &&
                  report.date.month == now.month &&
                  report.date.day == now.day,
            )
            .toList();

      case 'Minggu Ini':
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return reports
            .where(
              (report) => report.date.isAfter(
                startOfWeek.subtract(const Duration(days: 1)),
              ),
            )
            .toList();

      case 'Bulan Ini':
        return reports
            .where(
              (report) =>
                  report.date.year == now.year &&
                  report.date.month == now.month,
            )
            .toList();

      default: // Semua
        return reports;
    }
  }

  List<Report> get progressReports {
    // Tidak pakai filter untuk progress (user hanya bisa punya 1 laporan aktif)
    return allReports
        .where(
          (report) =>
              report.status == ReportStatus.dalamProses ||
              report.status == ReportStatus.verifikasi ||
              report.status == ReportStatus.prosesLanjutan,
        )
        .toList();
  }

  List<Report> get completedReports {
    // Pakai filter untuk completed (bisa banyak laporan selesai/ditolak)
    final filtered = allReports
        .where(
          (report) =>
              report.status == ReportStatus.selesai ||
              report.status == ReportStatus.ditolak,
        )
        .toList();
    return _filterByDate(filtered);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Riwayat',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: isCheckingLogin
            ? const Center(
                child: CircularProgressIndicator(color: Color(0xFF0068FF)),
              )
            : Column(
                children: [
                  // Tab Navigation
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F5F5),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TabBar(
                        controller: _tabController,
                        indicator: BoxDecoration(
                          color: const Color(0xFF0068FF),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        labelColor: Colors.white,
                        unselectedLabelColor: Colors.grey,
                        labelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(text: 'Progress'),
                          Tab(text: 'Selesai'),
                        ],
                      ),
                    ),
                  ),
                  // Filter button - hanya muncul di tab Selesai (index 1)
                  AnimatedBuilder(
                    animation: _tabController,
                    builder: (context, child) {
                      // Hanya tampilkan filter jika tab Selesai aktif
                      if (_tabController.index == 1) {
                        return Container(
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 8,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              PopupMenuButton<String>(
                                icon: Image.asset(
                                  'assets/icons/ic_filter.png',
                                  width: 24,
                                  height: 24,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.filter_list,
                                      color: Color(0xFF0068FF),
                                    );
                                  },
                                ),
                                offset: const Offset(0, 40),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                onSelected: (String value) {
                                  setState(() {
                                    selectedFilter = value;
                                  });
                                },
                                itemBuilder: (BuildContext context) =>
                                    <PopupMenuEntry<String>>[
                                      PopupMenuItem<String>(
                                        value: 'Semua',
                                        child: Row(
                                          children: [
                                            Icon(
                                              selectedFilter == 'Semua'
                                                  ? Icons.radio_button_checked
                                                  : Icons
                                                        .radio_button_unchecked,
                                              color: const Color(0xFF0068FF),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            const Text('Semua'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Hari Ini',
                                        child: Row(
                                          children: [
                                            Icon(
                                              selectedFilter == 'Hari Ini'
                                                  ? Icons.radio_button_checked
                                                  : Icons
                                                        .radio_button_unchecked,
                                              color: const Color(0xFF0068FF),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            const Text('Hari Ini'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Minggu Ini',
                                        child: Row(
                                          children: [
                                            Icon(
                                              selectedFilter == 'Minggu Ini'
                                                  ? Icons.radio_button_checked
                                                  : Icons
                                                        .radio_button_unchecked,
                                              color: const Color(0xFF0068FF),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            const Text('Minggu Ini'),
                                          ],
                                        ),
                                      ),
                                      PopupMenuItem<String>(
                                        value: 'Bulan Ini',
                                        child: Row(
                                          children: [
                                            Icon(
                                              selectedFilter == 'Bulan Ini'
                                                  ? Icons.radio_button_checked
                                                  : Icons
                                                        .radio_button_unchecked,
                                              color: const Color(0xFF0068FF),
                                              size: 20,
                                            ),
                                            const SizedBox(width: 12),
                                            const Text('Bulan Ini'),
                                          ],
                                        ),
                                      ),
                                    ],
                              ),
                            ],
                          ),
                        );
                      }
                      // Kembalikan empty container jika tab Progress
                      return const SizedBox.shrink();
                    },
                  ),
                  // Content
                  Expanded(
                    child: isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF0068FF),
                            ),
                          )
                        : TabBarView(
                            controller: _tabController,
                            children: [
                              RefreshIndicator(
                                onRefresh: _loadLaporan,
                                color: const Color(0xFF0068FF),
                                child: _buildReportList(progressReports, true),
                              ),
                              RefreshIndicator(
                                onRefresh: _loadLaporan,
                                color: const Color(0xFF0068FF),
                                child: _buildReportList(
                                  completedReports,
                                  false,
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

  Widget _buildReportList(List<Report> reports, bool isProgress) {
    if (reports.isEmpty) {
      return EmptyWidget(isProgress: isProgress);
    }

    return ListView.builder(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 16),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        final report = reports[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ReportCard(report: report),
        );
      },
    );
  }
}

// Loading Widget (Skeleton)
class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      height: 14,
                      width: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0E0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Empty Widget
class EmptyWidget extends StatelessWidget {
  final bool isProgress;

  const EmptyWidget({super.key, required this.isProgress});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.folder_open, size: 64, color: Color(0xFF6D6D6D)),
          const SizedBox(height: 16),
          Text(
            isProgress
                ? 'Belum ada laporan dalam progress'
                : 'Belum ada laporan selesai atau ditolak',
            style: const TextStyle(color: Color(0xFF6D6D6D), fontSize: 16),
          ),
        ],
      ),
    );
  }
}
