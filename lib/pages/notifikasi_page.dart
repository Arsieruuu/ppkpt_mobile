import 'package:flutter/material.dart';
import 'laporan_terkirim_page.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({super.key});

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedFilter = 'Semua'; // Filter state: Semua, Hari Ini, Minggu Ini, Bulan Ini

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.grey.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: const Color(0xFF1683FF),
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
                Tab(text: 'Semua'),
                Tab(text: 'Belum Dibaca'),
              ],
            ),
          ),
          // Filter button
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PopupMenuButton<String>(
                  icon: Image.asset(
                    'assets/icons/ic_filter.png',
                    width: 24,
                    height: 24,
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
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Semua',
                      child: Row(
                        children: [
                          Icon(
                            selectedFilter == 'Semua' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
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
                            selectedFilter == 'Hari Ini' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
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
                            selectedFilter == 'Minggu Ini' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
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
                            selectedFilter == 'Bulan Ini' ? Icons.radio_button_checked : Icons.radio_button_unchecked,
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
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSemuaTab(),
                _buildBelumDibacaTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSemuaTab() {
    return ListView(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 5, bottom: 16),
      children: [
        _buildNotificationCard(
          icon: Icons.assignment_outlined,
          iconColor: const Color(0xFF1683FF),
          title: 'Laporan Terkirim',
          description: 'Silahkan tunggu laporan anda di cek petugas',
          isRead: true,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LaporanTerkirimPage(
                  reportId: 'LP-078957KS',
                  time: '17:45',
                  date: 'Juni 24',
                  message: 'Laporan anda berhasil terkirim, dan sedang menunggu pengecekan oleh satgas. harap tunggu dan silahkan cek di menu pelaporan untuk informasi lengkap.',
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBelumDibacaTab() {
    return const Center(
      child: Text(
        'Tidak ada notifikasi yang belum dibaca',
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
    required bool isRead,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                      height: 1.3,
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
