import 'package:flutter/material.dart';
import 'dart:async';
import 'getstart.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _playToPauseController;
  late AnimationController _textController;

  late Animation<double> _morphAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  late Animation<double> _leftTextOpacity;
  late Animation<double> _rightTextOpacity;
  late Animation<double> _leftTextSlide;
  late Animation<double> _rightTextSlide;

  @override
  void initState() {
    super.initState();

    // Animation for play to pause transformation
    _playToPauseController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _morphAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _playToPauseController,
      curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 0.0, end: 1.2), weight: 40),
      TweenSequenceItem(tween: Tween<double>(begin: 1.2, end: 1.0), weight: 60),
    ]).animate(CurvedAnimation(
      parent: _playToPauseController,
      curve: Interval(0.0, 0.6, curve: Curves.easeInOut),
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _playToPauseController,
      curve: Interval(0.0, 0.3, curve: Curves.easeIn),
    ));

    // Text animation controller
    _textController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    // Text animations
    _leftTextOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Interval(0.0, 0.5, curve: Curves.easeInOut),
    ));

    _rightTextOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Interval(0.5, 1.0, curve: Curves.easeInOut),
    ));

    _leftTextSlide = Tween<double>(
      begin: -20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Interval(0.0, 0.5, curve: Curves.easeOutCubic),
    ));

    _rightTextSlide = Tween<double>(
      begin: 20.0,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Interval(0.5, 1.0, curve: Curves.easeOutCubic),
    ));

    // Start animations in sequence
    _playToPauseController.forward().then((_) {
      _textController.forward();
    });

    // Navigate to GetStartedScreen after animations complete
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => GetStartedScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            return FadeTransition(opacity: fadeIn, child: child);
          },
          transitionDuration: Duration(milliseconds: 800),
        ),
      );
    });
  }

  @override
  void dispose() {
    _playToPauseController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo and text container
            SizedBox(
              width: 260,
              height: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Center pause icon
                  AnimatedBuilder(
                    animation: _playToPauseController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _fadeAnimation.value,
                        child: Transform.scale(
                          scale: _scaleAnimation.value,
                          child: CustomPaint(
                            size: Size(60, 60),
                            painter: PlayPausePainter(
                              progress: _morphAnimation.value,
                              color: Color(0xFFD13F8D), // Pink/magenta color
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // "PA" text (left side)
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Positioned(
                        right: 165,
                        child: Opacity(
                          opacity: _leftTextOpacity.value,
                          child: Transform.translate(
                            offset: Offset(_leftTextSlide.value, 0),
                            child: Text(
                              "PA",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // "SE" text (right side)
                  AnimatedBuilder(
                    animation: _textController,
                    builder: (context, child) {
                      return Positioned(
                        left: 165,
                        child: Opacity(
                          opacity: _rightTextOpacity.value,
                          child: Transform.translate(
                            offset: Offset(_rightTextSlide.value, 0),
                            child: Text(
                              "SE",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 44,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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

// Custom painter for the play/pause button morph
class PlayPausePainter extends CustomPainter {
  final double progress;
  final Color color;

  PlayPausePainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    if (progress < 0.5) {
      // Draw play button morphing to square
      final morphProgress = progress * 2;

      final path = Path();

      // Left point
      path.moveTo(centerX - 25, centerY - 25 + (50 * morphProgress / 2));

      // Top point morphing to top-right corner
      path.lineTo(
          centerX - 25 + (50 * morphProgress),
          centerY - 25
      );

      // Right point
      path.lineTo(centerX + 25, centerY);

      // Bottom point morphing to bottom-right corner
      path.lineTo(
          centerX - 25 + (50 * morphProgress),
          centerY + 25
      );

      // Close to left point
      path.lineTo(centerX - 25, centerY - 25 + (50 * morphProgress / 2));

      path.close();
      canvas.drawPath(path, paint);
    } else {
      // Draw square morphing to pause button
      final morphProgress = (progress - 0.5) * 2;

      // Left rectangle
      canvas.drawRect(
          Rect.fromLTRB(
              centerX - 25,
              centerY - 25,
              centerX - 25 + 15 + (5 * (1 - morphProgress)),
              centerY + 25
          ),
          paint
      );

      // Right rectangle
      canvas.drawRect(
          Rect.fromLTRB(
              centerX + 10 - (5 * (1 - morphProgress)),
              centerY - 25,
              centerX + 25,
              centerY + 25
          ),
          paint
      );
    }
  }

  @override
  bool shouldRepaint(PlayPausePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.color != color;
}