import 'package:flutter/material.dart';
import 'dart:math';
import 'login.dart';

// Import your home page or main dashboard
// import 'home_screen.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  _GetStartedScreenState createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // Onboarding slide data
  final List<Map<String, dynamic>> _slides = [
    {
      'title': 'Track Your Screen Time',
      'description': 'Monitor how much time you spend on different apps and get insights into your digital habits.',
      'image': 'assests/manage.png', // Replace with your actual image
      // 'color': Color(0xFF6C63FF),
      'color': Color(0xFF930B55),
    },
    {
      'title': 'Set Smart Limits',
      'description': 'Create personalized time limits for apps that matter to you and stay productive throughout your day.',
      'image': 'assests/focus.png', // Replace with your actual image
      // 'color': Color(0xFF42A5F5),
      'color': Color(0xFF930B55),
    },
    {
      'title': 'Timely Alerts',
      'description': 'Receive friendly notifications when you\'re approaching your set time limits and take control of your digital wellbeing.',
      'image': 'assests/alert.png', // Replace with your actual image
      // 'color': Color(0xFF4CAF50),
      'color': Color(0xFF930B55),
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  _slides[_currentPage]['color'].withOpacity(0.8),
                  _slides[_currentPage]['color'].withOpacity(0.4),
                ],
              ),
            ),
          ),

          // Decorative background elements
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),

          Positioned(
            bottom: -80,
            right: -80,
            child: Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(150),
              ),
            ),
          ),

          // Main content
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemCount: _slides.length,
                    itemBuilder: (context, index) {
                      return _buildOnboardingPage(_slides[index]);
                    },
                  ),
                ),

                // Page indicator
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                          (index) => _buildDotIndicator(index),
                    ),
                  ),
                ),

                // Get started button and skip option
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip button
                      _currentPage < _slides.length - 1
                          ? TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            _slides.length - 1,
                            duration: Duration(milliseconds: 600),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                          : SizedBox(width: 80),

                      // Next or Get Started button
                      AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        width: _currentPage == _slides.length - 1 ? 200 : 150,
                        height: 56,
                        child:
                        ElevatedButton(
                          onPressed: () {
                            if (_currentPage < _slides.length - 1) {
                              _pageController.nextPage(
                                duration: Duration(milliseconds: 600),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              // Navigate to your main app screen
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  // Replace with your main screen
                                  builder: (context) => LoginScreen(),
                                    ),

                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: _slides[_currentPage]['color'],
                            elevation: 6,
                            shadowColor: Colors.black.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: Text(
                            _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build a single onboarding page
  Widget _buildOnboardingPage(Map<String, dynamic> slideData) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image with Hero animation
          SizedBox(
            height: 300,
            child: Hero(
              tag: slideData['title'],
              child: TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 1),
                duration: Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 0.8 + (0.2 * value),
                    child: Transform.rotate(
                      angle: (1 - value) * pi / 50,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(30),
                  child: Image.asset(
                    slideData['image'],
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback for missing images
                      return Icon(
                        Icons.image_not_supported_outlined,
                        size: 80,
                        color: slideData['color'],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 30),

          // Title
          Text(
            slideData['title'],
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              shadows: [
                Shadow(
                  color: Colors.black26,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 16),

          // Description
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              slideData['description'],
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Build page indicator dots
  Widget _buildDotIndicator(int index) {
    bool isActive = index == _currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(6),
        boxShadow: isActive
            ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ]
            : null,
      ),
    );
  }
}