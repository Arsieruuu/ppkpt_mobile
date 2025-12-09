import 'package:flutter/material.dart';
import '../main.dart';

class LaporanSuccessPage extends StatelessWidget {
  const LaporanSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Success Icon with decoration
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Decorative leaf - bottom left
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Image.asset(
                          'assets/images/elements/leaf_yellow.png',
                          width: 80,
                          height: 80,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(width: 80, height: 80);
                          },
                        ),
                      ),
                      // Decorative leaf - top right
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Image.asset(
                          'assets/images/elements/leaf_purple.png',
                          width: 80,
                          height: 80,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(width: 80, height: 80);
                          },
                        ),
                      ),
                      // Success Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2196F3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF2196F3).withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Title
                  const Text(
                    'Lapoan Berhasil Terkirim !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      color: Color(0xFF2196F3),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Subtitle
                  const Text(
                    'Laporan anda sudah terkirim, harap\nmenunggu status laporan terbaru',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Color(0xFF6D6D6D),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Menu Pelaporan Button
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        // Navigate to Main page with Riwayat tab selected
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const MainNavigationPage(
                              initialIndex: 2, // Index 2 = Riwayat
                            ),
                          ),
                          (route) => false,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Menu Pelaporan',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
