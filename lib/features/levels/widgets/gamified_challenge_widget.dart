import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../core/constants/app_constants.dart';
import '../../../core/models/game_models.dart';
import '../../ui/widgets/animated_button.dart';

class GameifiedChallengeWidget extends StatefulWidget {
  final GameChallenge challenge;
  final Function(String) onAnswerSelected;
  final String? selectedAnswer;

  const GameifiedChallengeWidget({
    super.key,
    required this.challenge,
    required this.onAnswerSelected,
    this.selectedAnswer,
  });

  @override
  State<GameifiedChallengeWidget> createState() =>
      _GameifiedChallengeWidgetState();
}

class _GameifiedChallengeWidgetState extends State<GameifiedChallengeWidget>
    with TickerProviderStateMixin {
  late AnimationController _platformController;
  late AnimationController _characterController;
  late AnimationController _floatingController;

  @override
  void initState() {
    super.initState();
    
    _platformController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    _characterController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
    
    _floatingController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();

    // Start platform animation
    _platformController.forward();
  }

  @override
  void dispose() {
    _platformController.dispose();
    _characterController.dispose();
    _floatingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Stack(
        children: [
          // Animated background
          _buildAnimatedBackground(),
          
          // Floating elements
          _buildFloatingElements(),
          
          // Question display area
          _buildQuestionArea(),
          
          // 3D Platform with answer options
          _buildAnswerPlatforms(),
          
          // Character
          _buildCharacter(),
        ],
      ),
    );
  }

  Widget _buildAnimatedBackground() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppConstants.primaryColor.withOpacity(0.1),
                AppConstants.secondaryColor.withOpacity(0.2),
                AppConstants.accentColor.withOpacity(0.1),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Animated waves in background
              ...List.generate(3, (index) {
                final offset = _floatingController.value * 2 * math.pi;
                return Positioned(
                  left: -50 + (index * 100),
                  top: 50 + math.sin(offset + index) * 20,
                  child: Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingElements() {
    return AnimatedBuilder(
      animation: _floatingController,
      builder: (context, child) {
        return Stack(
          children: List.generate(8, (index) {
            final progress = (_floatingController.value + index * 0.125) % 1.0;
            final screenWidth = MediaQuery.of(context).size.width;
            final x = (index * (screenWidth / 8)) + 
                    math.sin(progress * 2 * math.pi) * 30;
            final y = 100 + progress * 50;
            
            return Positioned(
              left: x,
              top: y,
              child: Opacity(
                opacity: 0.6,
                child: Icon(
                  [
                    Icons.star,
                    Icons.security,
                    Icons.wifi,
                    Icons.computer,
                    Icons.phone_android,
                    Icons.lock,
                    Icons.cloud,
                    Icons.flash_on,
                  ][index],
                  color: [
                    AppConstants.warningColor,
                    AppConstants.primaryColor,
                    AppConstants.secondaryColor,
                    AppConstants.accentColor,
                  ][index % 4],
                  size: 20 + (index % 3) * 5,
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildQuestionArea() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.help_outline,
                  color: AppConstants.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Question ${widget.challenge.id}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.challenge.question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppConstants.textPrimaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ).animate().slideY(
        begin: -0.5,
        duration: 1000.ms,
        curve: Curves.elasticOut,
      ).fadeIn(),
    );
  }

  Widget _buildAnswerPlatforms() {
    return Positioned(
      bottom: 60,
      left: 0,
      right: 0,
      height: 200,
      child: AnimatedBuilder(
        animation: _platformController,
        builder: (context, child) {
          return Stack(
            children: [
              // Central platform
              _buildCentralPlatform(),
              
              // Answer option platforms
              ...List.generate(widget.challenge.options.length, (index) {
                return _buildAnswerPlatform(index);
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCentralPlatform() {
    return Center(
      child: Transform.scale(
        scale: 0.7 + (_platformController.value * 0.3),
        child: Container(
          width: 80,
          height: 40,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppConstants.accentColor,
                AppConstants.accentColor.withOpacity(0.7),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppConstants.accentColor.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnswerPlatform(int index) {
    final angle = (index * 2 * math.pi) / widget.challenge.options.length;
    final radius = 120.0;
    final centerX = MediaQuery.of(context).size.width / 2;
    final centerY = 100.0;
    
    final x = centerX + radius * math.cos(angle - math.pi / 2) - 60;
    final y = centerY + radius * math.sin(angle - math.pi / 2) - 30;
    
    final isSelected = widget.selectedAnswer == widget.challenge.options[index];
    final animationDelay = index * 200;

    return Positioned(
      left: x,
      top: y,
      child: AnimatedButton(
        onPressed: () => widget.onAnswerSelected(widget.challenge.options[index]),
        child: Transform.scale(
          scale: _platformController.value,
          child: Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isSelected 
                  ? [
                      AppConstants.secondaryColor,
                      AppConstants.secondaryColor.withOpacity(0.7),
                    ]
                  : [
                      Colors.white,
                      Colors.grey.shade200,
                    ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected 
                  ? AppConstants.secondaryColor 
                  : AppConstants.primaryColor.withOpacity(0.3),
                width: isSelected ? 3 : 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected 
                    ? AppConstants.secondaryColor.withOpacity(0.4)
                    : Colors.black.withOpacity(0.1),
                  blurRadius: isSelected ? 15 : 8,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Option letter
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isSelected 
                      ? Colors.white 
                      : AppConstants.primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D
                      style: TextStyle(
                        color: isSelected 
                          ? AppConstants.secondaryColor 
                          : Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                // Option text (truncated)
                Flexible(
                  child: Text(
                    widget.challenge.options[index].length > 15
                        ? '${widget.challenge.options[index].substring(0, 15)}...'
                        : widget.challenge.options[index],
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                        ? Colors.white 
                        : AppConstants.textPrimaryColor,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ).animate().scale(
        delay: Duration(milliseconds: animationDelay),
        duration: 800.ms,
        curve: Curves.elasticOut,
      ).fadeIn(
        delay: Duration(milliseconds: animationDelay),
      ),
    );
  }

  Widget _buildCharacter() {
    return Positioned(
      bottom: 140,
      left: MediaQuery.of(context).size.width / 2 - 30,
      child: AnimatedBuilder(
        animation: _characterController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, math.sin(_characterController.value * 2 * math.pi) * 8),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppConstants.primaryColor.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(
                Icons.android,
                color: Colors.white,
                size: 30,
              ),
            ),
          );
        },
      ).animate().scale(
        delay: 1000.ms,
        duration: 800.ms,
        curve: Curves.elasticOut,
      ),
    );
  }
}