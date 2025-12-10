import 'package:flutter/material.dart';
import 'dart:async';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _textController;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize animation controllers
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Logo animations
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _logoScaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    // Text animations
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
      ),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textController,
            curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
          ),
        );

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    // Start logo animation
    _logoController.forward();

    // Wait a bit then start text animation
    await Future.delayed(const Duration(milliseconds: 800));
    _textController.forward();

    // Navigate to onboarding page after splash duration
    await Future.delayed(const Duration(milliseconds: 3500));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Main content area
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Spacer to push content up slightly
                    const Spacer(flex: 2),

                    // Logo with animation
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _logoScaleAnimation.value,
                          child: FadeTransition(
                            opacity: _logoFadeAnimation,
                            child: Container(
                              width: 140,
                              height: 140,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.08),
                                    blurRadius: 25,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Image.asset(
                                  'assets/icons/Polinela.png',
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 40),

                    // E-LAPOR text with animation
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _textSlideAnimation,
                          child: FadeTransition(
                            opacity: _textFadeAnimation,
                            child: const Text(
                              'E-LAPOR',
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Poppins',
                                color: Color(0xFF2E2E2E),
                                letterSpacing: -1,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    // Subtitle with animation
                    AnimatedBuilder(
                      animation: _textController,
                      builder: (context, child) {
                        return SlideTransition(
                          position: _textSlideAnimation,
                          child: FadeTransition(
                            opacity: _textFadeAnimation,
                            child: const Text(
                              'Ruang Aman untuk Bersuara',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Poppins',
                                color: Color(0xFF7A7A7A),
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    // Spacer to push copyright to bottom
                    const Spacer(flex: 3),
                  ],
                ),
              ),
            ),

            // Copyright section
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: AnimatedBuilder(
                animation: _textController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _textFadeAnimation,
                    child: Column(
                      children: [
                        // Loading indicator
                        Container(
                          width: 40,
                          height: 3,
                          decoration: BoxDecoration(
                            color: const Color(0xFF0068FF),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // TRPL Logo
                        Image.asset(
                          'assets/icons/trpl.png',
                          height: 40,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox.shrink();
                          },
                        ),
                        const SizedBox(height: 12),

                        // Copyright text
                        const Text(
                          '© 2025 TRPL POLINELA',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                            color: Color(0xFF0068FF),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
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
}
