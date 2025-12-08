import 'package:flutter/material.dart';

class DetailKekerasanSeksualPage extends StatelessWidget {
  const DetailKekerasanSeksualPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/backgrounds/background_page.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Column(
              children: [
                // Custom AppBar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      GestureDetector(
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
                            color: Colors.black87,
                            size: 20,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Kekerasan Seksual',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(width: 48), // To balance the back button
                    ],
                  ),
                ),

                // Scrollable Content
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9), // Added opacity
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Play button icon
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 30,
                                color: Colors.grey.shade600,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Timeline steps
                            _buildTimelineStep(
                              'Dalam Proses Peninjauan Oleh Satgas',
                              true,
                              false,
                            ),
                            const SizedBox(height: 30),
                            _buildTimelineStep('Verifikasi', false, false),
                            const SizedBox(height: 30),
                            _buildTimelineStep('Tindak Lanjut', false, false),
                            const SizedBox(height: 30),
                            _buildTimelineStep('Selesai', false, true),

                            const SizedBox(height: 40),

                            // Laporan Anda Card - Using asset with content overlay (Bigger size)
                            Stack(
                              children: [
                                // Background card asset - Made bigger but proportional
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 4),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(18),
                                    child: Transform.scale(
                                      scale: 1.1, // Scale up by 10%
                                      child: Image.asset(
                                        'assets/images/elements/laporanandacard.png',
                                        width: double.infinity,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ),
                                  ),
                                ),
                                // Content overlay - Properly positioned for scaled card
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.all(22.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 32), // Space for "Laporan Anda" text in image
                                        
                                        // Report Card - Balanced size
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(14),
                                          margin: const EdgeInsets.symmetric(horizontal: 8),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(11),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.1),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  color: Colors.blue.shade50,
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                child: Icon(
                                                  Icons.description,
                                                  color: Colors.blue.shade600,
                                                  size: 20,
                                                ),
                                              ),
                                              const SizedBox(width: 11),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    const Text(
                                                      'Kekerasan Seksual',
                                                      style: TextStyle(
                                                        fontSize: 13,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.black87,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 2),
                                                    const Text(
                                                      'LP-078957KS',
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        fontWeight: FontWeight.w400,
                                                        fontFamily: 'Poppins',
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          Icons.access_time,
                                                          size: 11,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                        const SizedBox(width: 3),
                                                        const Text(
                                                          '17.45',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: 'Poppins',
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Icon(
                                                          Icons.calendar_today,
                                                          size: 11,
                                                          color: Colors.grey.shade600,
                                                        ),
                                                        const SizedBox(width: 3),
                                                        const Text(
                                                          'Juni 24',
                                                          style: TextStyle(
                                                            fontSize: 10,
                                                            fontFamily: 'Poppins',
                                                            color: Colors.grey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 16),
                                        
                                        // Detail Button - White color
                                        Center(
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 22,
                                              vertical: 7,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black.withOpacity(0.1),
                                                  blurRadius: 5,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              'Detail',
                                              style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'Poppins',
                                                color: Colors.blue.shade600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineStep(String title, bool isActive, bool isLast) {
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
            color: isActive ? Colors.black87 : Colors.grey.shade500,
          ),
          textAlign: TextAlign.center,
        ),

        if (!isLast) ...[
          const SizedBox(height: 15),
          // Dots
          Column(
            children: List.generate(
              3,
              (index) => Container(
                width: 4,
                height: 4,
                margin: const EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
