import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/game_service.dart';
import '../../../core/services/audio_service.dart';
import '../../ui/widgets/animated_button.dart';
import '../../ui/widgets/progress_indicator_widget.dart';
import '../widgets/level_card_widget.dart';
import 'level_play_screen.dart';

class LevelSelectScreen extends StatefulWidget {
  const LevelSelectScreen({super.key});

  @override
  State<LevelSelectScreen> createState() => _LevelSelectScreenState();
}

class _LevelSelectScreenState extends State<LevelSelectScreen>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppConstants.primaryColor,
              AppConstants.secondaryColor,
              AppConstants.warningColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer2<GameService, AudioService>(
            builder: (context, gameService, audioService, child) {
              return Column(
                children: [
                  // Header
                  _buildHeader(context, audioService),
                  
                  // Level grid
                  Expanded(
                    child: _buildLevelGrid(gameService, audioService),
                  ),
                  
                  // Page indicator
                  _buildPageIndicator(),
                  
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, AudioService audioService) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          AnimatedButton(
            onPressed: () {
              audioService.playButtonClick();
              Navigator.pop(context);
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Choose Your Level',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ).animate().fadeIn(duration: 600.ms).slideX(begin: -0.3),
                const SizedBox(height: 4),
                Text(
                  'Select a digital literacy challenge',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withOpacity(0.8),
                  ),
                ).animate().fadeIn(delay: 200.ms, duration: 600.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelGrid(GameService gameService, AudioService audioService) {
    return PageView.builder(
      controller: _pageController,
      onPageChanged: (page) {
        setState(() {
          _currentPage = page;
        });
      },
      itemCount: (AppConstants.totalLevels / 6).ceil(),
      itemBuilder: (context, pageIndex) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: 6,
            itemBuilder: (context, index) {
              final levelNumber = pageIndex * 6 + index + 1;
              if (levelNumber > AppConstants.totalLevels) {
                return const SizedBox.shrink();
              }
              
              return LevelCardWidget(
                levelNumber: levelNumber,
                isUnlocked: gameService.isLevelUnlocked(levelNumber),
                isCompleted: gameService.isLevelCompleted(levelNumber),
                stars: gameService.getLevelStars(levelNumber),
                theme: AppConstants.levelThemes[levelNumber - 1],
                onTap: () {
                  if (gameService.isLevelUnlocked(levelNumber)) {
                    audioService.playButtonClick();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LevelPlayScreen(levelNumber: levelNumber),
                      ),
                    );
                  } else {
                    audioService.playWrongAnswer();
                    _showLockedLevelDialog(context);
                  }
                },
              ).animate(delay: (index * 100).ms).fadeIn().scale(begin: const Offset(0.8, 0.8));
            },
          ),
        );
      },
    );
  }

  Widget _buildPageIndicator() {
    final totalPages = (AppConstants.totalLevels / 6).ceil();
    if (totalPages <= 1) return const SizedBox.shrink();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalPages, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: _currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: _currentPage == index 
                ? Colors.white 
                : Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        ).animate().scale(duration: 300.ms);
      }),
    );
  }

  void _showLockedLevelDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(
              Icons.lock,
              color: AppConstants.accentColor,
              size: 24,
            ),
            const SizedBox(width: 8),
            const Text('Level Locked'),
          ],
        ),
        content: const Text(
          'Complete the previous level to unlock this one!',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                color: AppConstants.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}