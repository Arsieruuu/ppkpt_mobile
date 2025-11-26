import 'package:flutter/material.dart';
import '../models/report.dart';
import '../widgets/segmented_control.dart';
import '../widgets/report_card.dart';

class RiwayatPage extends StatefulWidget {
  const RiwayatPage({super.key});

  @override
  State<RiwayatPage> createState() => _RiwayatPageState();
}

class _RiwayatPageState extends State<RiwayatPage> {
  int selectedTab = 0; // 0: Selesai, 1: Ditolak
  bool isLoading = false;

  // Data dummy
  final List<Report> reports = [
    Report(
      id: 'LP-078957KS',
      title: 'Kekerasan Seksual',
      time: '17.45',
      date: DateTime(2025, 6, 24),
      status: ReportStatus.selesai,
    ),
    Report(
      id: 'LP-123456AB',
      title: 'Kekerasan Fisik',
      time: '14.30',
      date: DateTime(2025, 6, 23),
      status: ReportStatus.ditolak,
    ),
  ];

  List<Report> get filteredReports {
    final status = selectedTab == 0 ? ReportStatus.selesai : ReportStatus.ditolak;
    return reports.where((report) => report.status == status).toList();
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
          // Segmented Control
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SegmentedControl(
              selectedIndex: selectedTab,
              onChanged: (index) {
                setState(() {
                  selectedTab = index;
                });
              },
            ),
          ),
          // Content
          Expanded(
            child: isLoading
                ? const LoadingWidget()
                : filteredReports.isEmpty
                    ? EmptyWidget(isSelesai: selectedTab == 0)
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredReports.length,
                        itemBuilder: (context, index) {
                          final report = filteredReports[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ReportCard(report: report),
                          );
                        },
                      ),
          ),
        ],
        ),
      ),
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
  final bool isSelesai;

  const EmptyWidget({super.key, required this.isSelesai});

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
            isSelesai 
                ? 'Belum ada laporan selesai'
                : 'Belum ada laporan ditolak',
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