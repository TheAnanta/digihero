import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'dart:math' as math;
import '../../../core/constants/app_constants.dart';
import '../../../core/services/game_service.dart';
import '../../../core/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/screens/login_screen.dart';
import 'age_input_screen.dart';
import '../../game/screens/game_home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _logoController;
  late AnimationController _particleController;
  bool _showTapToStart = false;

  @override
  void initState() {
    super.initState();

    _backgroundController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _logoController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    // Start the logo animation and show tap to start after delay
    _logoController.forward();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showTapToStart = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _logoController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  void _handleSplashTap() {
    final gameService = context.read<GameService>();
    final authService = context.read<AuthService>();

    // Check authentication first
    if (!authService.isAuthenticated) {
      // Navigate to login screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    } else if (gameService.hasSetAge) {
      // User is authenticated and has set age - go to game
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const GameHomeScreen()),
      );
    } else {
      // User is authenticated but hasn't set age - go to age input
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AgeInputScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _showTapToStart ? _handleSplashTap : null,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppConstants.primaryColor,
                AppConstants.secondaryColor,
                AppConstants.accentColor,
              ],
              stops: [0.0, 0.5, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Animated background elements
              _buildAnimatedBackground(),

              // Floating particles
              _buildFloatingParticles(),

              // Main content
              SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo and title
                      _buildLogo(),

                      const SizedBox(height: 40),

                      // Subtitle
                      _buildSubtitle(),

                      const SizedBox(height: 60),

                      // Tap to start indicator
                      if (_showTapToStart) _buildTapToStart(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _backgroundController,
      builder: (context, child) {
        return Stack(
          children: [
            // Rotating circles
            ...List.generate(6, (index) {
              final offset = _backgroundController.value * 2 * 3.14159;
              final radius = 100.0 + (index * 50);
              final x = MediaQuery.of(context).size.width / 2 +
                  radius * math.cos(offset + index * 1.047);
              final y = MediaQuery.of(context).size.height / 2 +
                  radius * math.sin(offset + index * 1.047);

              return Positioned(
                left: x - 30,
                top: y - 30,
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildFloatingParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return Stack(
          children: List.generate(20, (index) {
            final progress = (_particleController.value + index * 0.05) % 1.0;
            final screenHeight = MediaQuery.of(context).size.height;
            final screenWidth = MediaQuery.of(context).size.width;

            return Positioned(
              left: (index * 50) % screenWidth,
              top: screenHeight - (progress * screenHeight * 1.2),
              child: Opacity(
                opacity: (1.0 - progress) * 0.6,
                child: Container(
                  width: 4 + (index % 3) * 2,
                  height: 4 + (index % 3) * 2,
                  decoration: BoxDecoration(
                    color: [
                      Colors.white,
                      AppConstants.warningColor,
                      AppConstants.accentColor,
                    ][index % 3],
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _logoController,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + (_logoController.value * 0.5),
          child: Column(
            children: [
              // Shield icon representing digital protection
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.shield,
                  size: 60,
                  color: AppConstants.primaryColor,
                ),
              ).animate().scale(
                    delay: 500.ms,
                    duration: 1000.ms,
                    curve: Curves.elasticOut,
                  ),

              const SizedBox(height: 20),

              // App name
              Text(
                AppConstants.appName,
                style: const TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 2,
                ),
              )
                  .animate()
                  .fadeIn(
                    delay: 800.ms,
                    duration: 1000.ms,
                  )
                  .slideY(begin: 0.3),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return Column(
      children: [
        Text(
          AppLocalizations.of(context)?.splashTagline ??
              'Digital Literacy Adventure',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(
              delay: 1200.ms,
              duration: 800.ms,
            ),
        const SizedBox(height: 10),
        Text(
          'Learn • Play • Protect • Explore',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withOpacity(0.8),
            letterSpacing: 1.5,
          ),
          textAlign: TextAlign.center,
        ).animate().fadeIn(
              delay: 1500.ms,
              duration: 800.ms,
            ),
      ],
    );
  }

  Widget _buildTapToStart() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.touch_app,
                color: Colors.white,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)?.splashStartButton ??
                    'Tap to Start Adventure',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(
              duration: 800.ms,
            )
            .scale(
              delay: 200.ms,
              duration: 800.ms,
              curve: Curves.elasticOut,
            ),

        const SizedBox(height: 20),

        // Pulsing indicator
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        )
            .animate(onPlay: (controller) => controller.repeat())
            .scale(
              duration: 1000.ms,
              begin: const Offset(0.8, 0.8),
              end: const Offset(1.2, 1.2),
            )
            .then()
            .scale(
              duration: 1000.ms,
              begin: const Offset(1.2, 1.2),
              end: const Offset(0.8, 0.8),
            ),
      ],
    );
  }
}
