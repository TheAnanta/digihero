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
      // Unit 1: My First Step into the Digital World
      case 'Meet Your Digital Device':
        return 'Learn about different devices and their parts';
      case 'Understanding Your Screen':
        return 'Discover icons, menus and basic navigation';
      case 'Working with Apps':
        return 'Learn to open and use applications safely';
      case 'Why Digital Skills Matter':
        return 'Understand how technology helps your future';
      
      // Unit 2: Using Digital Tools for School and Learning  
      case 'Mastering Our Learning App':
        return 'Navigate and use educational apps effectively';
      case 'Writing and Typing':
        return 'Practice typing in your language and English';
      case 'Creating Presentations':
        return 'Make simple presentations with text and images';
      case 'Organizing Digital Work':
        return 'Learn to save and organize your files';
      
      // Unit 3: Exploring the Internet Safely
      case 'What is the Internet':
        return 'Understand the internet and how to connect';
      case 'Searching for Information':
        return 'Learn to search effectively and safely';
      case 'Staying Safe Online':
        return 'Protect yourself and your personal information';
      case 'Being a Good Digital Citizen':
        return 'Be kind and respectful online';
      
      // Unit 4: Communication and Collaboration
      case 'Introduction to Email':
        return 'Learn to compose and send emails safely';
      case 'Messaging Apps Safety':
        return 'Use messaging apps responsibly for school';
      case 'Understanding Progress':
        return 'Track your learning journey and improvement';
      case 'Working Together Online':
        return 'Collaborate on digital projects with others';
      
      // Unit 5: Digital Skills for Life
      case 'Exploring Hobbies Online':
        return 'Find reliable information about your interests';
      case 'Digital Payments Safety':
        return 'Understand and stay safe with digital money';
      case 'Career Opportunities':
        return 'Discover careers and educational opportunities';
      case 'Digital Portfolio Project':
        return 'Create a showcase of your digital skills';
      
      default:
        return 'Digital literacy challenge';
    }
  }
}