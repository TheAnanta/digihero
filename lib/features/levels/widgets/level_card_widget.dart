import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../ui/widgets/animated_button.dart';
import '../../ui/widgets/progress_indicator_widget.dart';

class LevelCardWidget extends StatelessWidget {
  final int levelNumber;
  final bool isUnlocked;
  final bool isCompleted;
  final int stars;
  final String theme;
  final VoidCallback onTap;

  const LevelCardWidget({
    super.key,
    required this.levelNumber,
    required this.isUnlocked,
    required this.isCompleted,
    required this.stars,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedButton(
      onPressed: isUnlocked ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          gradient: _getCardGradient(),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: _getCardGradient().colors.first.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
          border: isCompleted 
              ? Border.all(color: AppConstants.secondaryColor, width: 3)
              : null,
        ),
        child: Stack(
          children: [
            // Background pattern
            _buildBackgroundPattern(),
            
            // Main content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Level number and lock status
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            levelNumber.toString(),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isUnlocked 
                                  ? AppConstants.textPrimaryColor 
                                  : AppConstants.textSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                      if (!isUnlocked)
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.lock,
                            color: Colors.white.withOpacity(0.7),
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // Theme/title
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          theme,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _getLevelDescription(),
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.white.withOpacity(0.9),
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 2,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Stars and progress
                  if (isUnlocked)
                    _buildProgressSection(),
                ],
              ),
            ),
            
            // Completion overlay
            if (isCompleted)
              _buildCompletionOverlay(),
            
            // Lock overlay
            if (!isUnlocked)
              _buildLockOverlay(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundPattern() {
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Geometric patterns
            Positioned(
              top: -20,
              right: -20,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -10,
              left: -10,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressSection() {
    return Column(
      children: [
        // Stars
        if (isCompleted)
          StarsWidget(
            totalStars: AppConstants.starsPerLevel,
            filledStars: stars,
            size: 18,
          ),
        
        const SizedBox(height: 8),
        
        // Play indicator
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isCompleted ? Icons.replay : Icons.play_arrow,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                isCompleted ? 'Replay' : 'Play',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCompletionOverlay() {
    return Positioned(
      top: 8,
      right: 8,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppConstants.secondaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.check,
          color: Colors.white,
          size: 16,
        ),
      ).animate().scale(delay: 300.ms).then().shake(),
    );
  }

  Widget _buildLockOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Center(
          child: Icon(
            Icons.lock,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }

  LinearGradient _getCardGradient() {
    if (!isUnlocked) {
      return LinearGradient(
        colors: [
          Colors.grey.withOpacity(0.6),
          Colors.grey.withOpacity(0.4),
        ],
      );
    }
    
    // Different gradient based on level theme
    switch (levelNumber % 4) {
      case 1:
        return const LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
        );
      case 2:
        return const LinearGradient(
          colors: [AppConstants.secondaryColor, AppConstants.warningColor],
        );
      case 3:
        return const LinearGradient(
          colors: [AppConstants.warningColor, AppConstants.accentColor],
        );
      default:
        return const LinearGradient(
          colors: [AppConstants.accentColor, AppConstants.primaryColor],
        );
    }
  }

  String _getLevelDescription() {
    switch (theme) {
      case 'Smart Passwords':
        return 'Learn to create strong passwords';
      case 'Phishing Awareness':
        return 'Spot and avoid phishing attempts';
      case 'Privacy Settings':
        return 'Master your privacy controls';
      case 'Cyberbullying':
        return 'Handle online harassment';
      case 'Safe Downloads':
        return 'Download files safely';
      case 'Social Media Safety':
        return 'Stay safe on social platforms';
      case 'Digital Footprint':
        return 'Manage your online presence';
      case 'Secure Networks':
        return 'Connect to safe networks';
      case 'Information Literacy':
        return 'Verify online information';
      case 'Digital Citizenship':
        return 'Be a responsible digital citizen';
      default:
        return 'Digital literacy challenge';
    }
  }
}