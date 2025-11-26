import 'package:flutter/material.dart';

class PelaporanPage extends StatelessWidget {
  const PelaporanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Pelaporan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 40,
              top: 195,
              child: Container(
                width: 351,
                height: 216.6,
                child: Image.asset(
                  'assets/images/illustrations/Report.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // Text "Ayo, Buat Laporan Mu!" - centered
            Positioned(
              left: 0,
              right: 0,
              top: 480,
              child: Center(
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                    children: [
                      TextSpan(
                        text: 'Ayo, Buat ',
                        style: TextStyle(color: Color(0xFF2196F3)),
                      ),
                      TextSpan(
                        text: 'Laporan ',
                        style: TextStyle(color: Color(0xFFFF9800)),
                      ),
                      TextSpan(
                        text: 'Mu!',
                        style: TextStyle(color: Color(0xFF2196F3)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Subtitle text - centered
            Positioned(
              left: 0,
              right: 0,
              top: 520,
              child: Center(
                child: Text(
                  'Laporkan Pelanggaran dengan cepat dan aman',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF666666),
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            // Draggable Bottom Sheet dengan tombol di dalam card putih
            Positioned(
              left: 0,
              right: 0,
              top: 580,
              bottom: 0,
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.4,
                maxChildSize: 1.0,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, -5),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: SingleChildScrollView(
                      controller: scrollController,
                      physics: const ClampingScrollPhysics(),
                      child: Column(
                        children: [
                          // Custom Button "Buat Laporan" tepat di ujung atas card
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                            child: GestureDetector(
                              onTap: () {
                                // Action untuk buat laporan
                                _showLaporanDialog(context);
                              },
                              child: Image.asset(
                                'assets/images/elements/buatlaporan.png',
                                width: 180,
                                height: 45,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          // Extra content untuk enable scroll/drag
                          Container(
                            height: 500,
                            width: double.infinity,
                            color: Colors.transparent,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }



  void _showLaporanDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Buat Laporan',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: const Text(
            'Fitur untuk membuat laporan akan segera tersedia.',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'OK',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF2196F3),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
