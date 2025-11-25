import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    
    _pageController = PageController();

    // Initialize animation controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Setup animations
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    // Start animations
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _fadeController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _slideController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _skipOnboarding() {
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _nextPage() {
    if (_currentPage < 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed('/main');
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/backgrounds/background_page.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, right: 24.0),
                  child: GestureDetector(
                    onTap: _skipOnboarding,
                    child: AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: const Text(
                            'Skip',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Poppins',
                              color: Color(0xFFFFBB00),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // PageView content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  children: [
                    // Page 1
                    _buildPage1(),
                    // Page 2
                    _buildPage2(),
                  ],
                ),
              ),

              // Bottom navigation section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Page indicator
                            Row(
                              children: [
                                Container(
                                  width: _currentPage == 0 ? 40 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentPage == 0
                                        ? const Color(0xFF0068FF)
                                        : const Color(0xFFD0D0D0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: _currentPage == 1 ? 40 : 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: _currentPage == 1
                                        ? const Color(0xFF0068FF)
                                        : const Color(0xFFD0D0D0),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                              ],
                            ),

                            // Next button
                            GestureDetector(
                              onTap: _nextPage,
                              child: Container(
                                width: 56,
                                height: 56,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0068FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
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
      ),
    );
  }

  Widget _buildPage1() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double imageHeight = screenHeight * 0.45; // 45% of available height
        
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Illustration - Flexible height
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: imageHeight.clamp(250.0, 400.0), // Min 250, Max 400
                  child: AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Image.asset(
                          'assets/images/illustrations/onboarding1.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.05), // 5% of screen height

                // Welcome text with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AnimatedBuilder(
                    animation: _slideController,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // "Hai! Selamat Datang di"
                              Text(
                                'Hai ! Selamat Datang di',
                                style: TextStyle(
                                  fontSize: screenHeight < 700 ? 16 : 20,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFFA2A2A2),
                                ),
                              ),

                              SizedBox(height: screenHeight < 700 ? 6 : 8),

                              // "E-LAPOR PPKPT POLINELA" with different colors
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'E-LAPOR ',
                                      style: TextStyle(
                                        fontSize: screenHeight < 700 ? 24 : 32,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF0068FF),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'PPKPT\n',
                                      style: TextStyle(
                                        fontSize: screenHeight < 700 ? 24 : 32,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFFFFBB00),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'POLINELA',
                                      style: TextStyle(
                                        fontSize: screenHeight < 700 ? 24 : 32,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: 'Poppins',
                                        color: const Color(0xFF0068FF),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: screenHeight < 700 ? 12 : 16),

                              // Description text
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt',
                                style: TextStyle(
                                  fontSize: screenHeight < 700 ? 14 : 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFFA2A2A2),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.1), // 10% bottom spacing
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage2() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenHeight = constraints.maxHeight;
        double imageHeight = screenHeight * 0.45; // 45% of available height
        
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Illustration - Flexible height
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: imageHeight.clamp(250.0, 400.0), // Min 250, Max 400
                  child: AnimatedBuilder(
                    animation: _fadeAnimation,
                    builder: (context, child) {
                      return FadeTransition(
                        opacity: _fadeAnimation,
                        child: Image.asset(
                          'assets/images/illustrations/onboarding2.png',
                          fit: BoxFit.contain,
                          width: double.infinity,
                        ),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.05), // 5% of screen height

                // Welcome text with padding
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: AnimatedBuilder(
                    animation: _slideController,
                    builder: (context, child) {
                      return SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // "Ruang Aman Anda untuk Bersuara" with different colors
                              RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Ruang Aman Anda untuk\n',
                              style: TextStyle(
                                fontSize: screenHeight < 700 ? 24 : 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                color: const Color(0xFF0068FF),
                                height: 1.2,
                              ),
                            ),
                            TextSpan(
                              text: 'Bersuara',
                              style: TextStyle(
                                fontSize: screenHeight < 700 ? 24 : 32,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins',
                                color: const Color(0xFFFFBB00),
                              ),
                            ),
                          ],
                        ),
                      ),

                              SizedBox(height: screenHeight < 700 ? 12 : 16),

                              // Description text
                              Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud',
                                style: TextStyle(
                                  fontSize: screenHeight < 700 ? 14 : 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Poppins',
                                  color: const Color(0xFFA2A2A2),
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                
                SizedBox(height: screenHeight * 0.1), // 10% bottom spacing
              ],
            ),
          ),
        );
      },
    );
  }
}
