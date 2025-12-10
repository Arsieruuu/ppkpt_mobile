import 'package:flutter/material.dart';
import '../models/report.dart';
import '../widgets/report_card.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Data dummy
  final List<Report> allReports = [
    Report(
      id: 'LP-001234KV',
      title: 'Kekerasan Verbal',
      time: '17.45',
      date: DateTime(2025, 6, 24),
      status: ReportStatus.dalamProses,
    ),
    Report(
      id: 'LP-001234KV',
      title: 'Kekerasan Verbal',
      time: '20.35',
      date: DateTime(2025, 6, 24),
      status: ReportStatus.verifikasi,
    ),
    Report(
      id: 'LP-001234KV',
      title: 'Kekerasan Verbal',
      time: '09.40',
      date: DateTime(2025, 6, 25),
      status: ReportStatus.prosesLanjutan,
    ),
    Report(
      id: 'LP-078957KS',
      title: 'Kekerasan Seksual',
      time: '17.45',
      date: DateTime(2025, 6, 24),
      status: ReportStatus.selesai,
    ),
    Report(
      id: 'LP-123456KF',
      title: 'Kekerasan Fisik',
      time: '14.30',
      date: DateTime(2025, 6, 23),
      status: ReportStatus.ditolak,
    ),
  ];

  List<Report> get progressReports {
    return allReports.where((report) => 
      report.status == ReportStatus.dalamProses ||
      report.status == ReportStatus.verifikasi ||
      report.status == ReportStatus.prosesLanjutan
    ).toList();
  }

  List<Report> get completedReports {
    return allReports.where((report) => 
      report.status == ReportStatus.selesai ||
      report.status == ReportStatus.ditolak
    ).toList();
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
        child: Column(
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
                    Tab(text: 'Selesai & Ditolak'),
                  ],
                ),
              ),
            ),
            // Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildReportList(progressReports, true),
                  _buildReportList(completedReports, false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportList(List<Report> reports, bool isProgress) {
    if (isLoading) {
      return const LoadingWidget();
    }

    if (reports.isEmpty) {
      return EmptyWidget(isProgress: isProgress);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
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
          const Icon(
            Icons.folder_open,
            size: 64,
            color: Color(0xFF6D6D6D),
          ),
          const SizedBox(height: 16),
          Text(
            isProgress 
                ? 'Belum ada laporan dalam progress'
                : 'Belum ada laporan selesai atau ditolak',
            style: const TextStyle(
              color: Color(0xFF6D6D6D),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}