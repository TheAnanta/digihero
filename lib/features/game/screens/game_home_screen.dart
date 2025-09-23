import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/game_service.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/progress_service.dart';
import '../../../core/services/language_service.dart';
import '../../../core/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/widgets/language_selection.dart';
import '../../levels/screens/level_select_screen.dart';
import '../../onboarding/screens/splash_screen.dart';
import '../../ui/widgets/animated_button.dart';
import '../../ui/widgets/progress_indicator_widget.dart';
import '../../characters/widgets/character_widget.dart';

class GameHomeScreen extends StatefulWidget {
  const GameHomeScreen({super.key});

  @override
  State<GameHomeScreen> createState() => _GameHomeScreenState();
}

class _GameHomeScreenState extends State<GameHomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _backgroundController;
  late AnimationController _characterController;

  @override
  void initState() {
    super.initState();
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _characterController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    // Start background music
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AudioService>().playBackgroundMusic('main_theme.mp3');
    });
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _characterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppConstants.primaryColor,
              AppConstants.secondaryColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Consumer4<GameService, AudioService, ProgressService, AuthService>(
            builder:
                (context, gameService, audioService, progressService, authService, child) {
              return Stack(
                children: [
                  // Animated background elements
                  _buildAnimatedBackground(),

                  // Main content
                  Column(
                    children: [
                      // Header with title and progress
                      _buildHeader(progressService, authService),

                      const SizedBox(height: 20),

                      // Main character
                      Expanded(
                        flex: 3,
                        child: _buildMainCharacter(),
                      ),

                      // Game stats
                      _buildGameStats(gameService, progressService),

                      const SizedBox(height: 30),

                      // Main action buttons
                      _buildActionButtons(context, gameService, audioService),

                      const SizedBox(height: 20),
                    ],
                  ),

                  // Settings button
                  Positioned(
                    top: 16,
                    right: 16,
                    child: _buildSettingsButton(context, audioService),
                  ),
                ],
              );
            },
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
            // Floating elements
            ...List.generate(6, (index) {
              final offset = _backgroundController.value * 2 * 3.14159;
              final x = 50.0 +
                  (index * 60.0) +
                  (30 *
                      (index % 2 == 0 ? 1 : -1) *
                      (0.5 + 0.5 * (index / 6.0)) *
                      (index % 2 == 0 ? 1 : -1) *
                      (offset + index * 0.5));
              final y = 100.0 +
                  (index * 80.0) +
                  (20 *
                      (index % 2 == 0 ? 1 : -1) *
                      (0.5 + 0.5 * (index / 6.0)) *
                      (offset + index * 0.3));

              return Positioned(
                left: x % MediaQuery.of(context).size.width,
                top: y % MediaQuery.of(context).size.height,
                child: Container(
                  width: 20 + (index % 3) * 10,
                  height: 20 + (index % 3) * 10,
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

  Widget _buildHeader(ProgressService progressService, AuthService authService) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // Welcome user message
          if (authService.isAuthenticated)
            Text(
              'Welcome back, ${authService.userName}!',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white.withOpacity(0.95),
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
            ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
          
          if (authService.isAuthenticated) const SizedBox(height: 8),
          
          Text(
            AppConstants.appName,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 36,
                ),
          ).animate().fadeIn(duration: 800.ms).slideY(begin: -0.3),
          const SizedBox(height: 10),
          Text(
            AppLocalizations.of(context)?.appTagline ??
                'Digital Literacy Adventure',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
          ).animate().fadeIn(delay: 400.ms, duration: 800.ms),
          const SizedBox(height: 15),
          ProgressIndicatorWidget(
            progress: progressService.getOverallProgress(),
            label: AppLocalizations.of(context)?.overallProgress ??
                'Overall Progress',
          ).animate().fadeIn(delay: 600.ms, duration: 800.ms),
        ],
      ),
    );
  }

  Widget _buildMainCharacter() {
    return AnimatedBuilder(
      animation: _characterController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 10 * _characterController.value),
          child: CharacterWidget(
            characterId: 'digiBuddy',
            size: 200,
            showSpeechBubble: true,
            speechText: AppLocalizations.of(context)?.readyForAdventure ??
                'Ready for another digital adventure?',
          ),
        );
      },
    );
  }

  Widget _buildGameStats(
      GameService gameService, ProgressService progressService) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            icon: Icons.star,
            label: AppLocalizations.of(context)?.score ?? 'Score',
            value: gameService.totalScore.toString(),
            color: AppConstants.warningColor,
          ),
          _buildStatItem(
            icon: Icons.monetization_on,
            label: AppLocalizations.of(context)?.coins ?? 'Coins',
            value: gameService.coins.toString(),
            color: AppConstants.secondaryColor,
          ),
          _buildStatItem(
            icon: Icons.favorite,
            label: AppLocalizations.of(context)?.lives ?? 'Lives',
            value: gameService.lives.toString(),
            color: AppConstants.accentColor,
          ),
          _buildStatItem(
            icon: Icons.emoji_events,
            label: AppLocalizations.of(context)?.achievements ?? 'Achievements',
            value: progressService.achievements.length.toString(),
            color: AppConstants.primaryColor,
          ),
        ],
      ),
    ).animate().fadeIn(delay: 800.ms, duration: 800.ms).slideY(begin: 0.3);
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppConstants.textPrimaryColor,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppConstants.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context, GameService gameService,
      AudioService audioService) {
    return Column(
      children: [
        AnimatedButton(
          onPressed: () {
            audioService.playButtonClick();
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const LevelSelectScreen()),
            );
          },
          child: Container(
            width: 200,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppConstants.secondaryColor,
                  AppConstants.primaryColor
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Center(
              child: Text(
                AppLocalizations.of(context)?.startAdventure ??
                    'START ADVENTURE',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 1000.ms, duration: 800.ms)
            .scale(begin: const Offset(0.8, 0.8)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedButton(
              onPressed: () {
                audioService.playButtonClick();
                _showProgressDialog(context);
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border:
                      Border.all(color: AppConstants.primaryColor, width: 2),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)?.progress ?? 'PROGRESS',
                    style: const TextStyle(
                      color: AppConstants.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            AnimatedButton(
              onPressed: () {
                audioService.playButtonClick();
                _showAchievementsDialog(context);
              },
              child: Container(
                width: 120,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  border:
                      Border.all(color: AppConstants.warningColor, width: 2),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)?.achievements ??
                        'ACHIEVEMENTS',
                    style: const TextStyle(
                      color: AppConstants.warningColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ).animate().fadeIn(delay: 1200.ms, duration: 800.ms),
      ],
    );
  }

  Widget _buildSettingsButton(BuildContext context, AudioService audioService) {
    return AnimatedButton(
      onPressed: () {
        audioService.playButtonClick();
        _showSettingsDialog(context);
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: const Icon(
          Icons.settings,
          color: Colors.white,
          size: 24,
        ),
      ),
    ).animate().fadeIn(delay: 1400.ms, duration: 800.ms);
  }

  void _showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text(AppLocalizations.of(context)?.yourProgress ?? 'Your Progress'),
        content: Consumer<ProgressService>(
          builder: (context, progressService, child) {
            final summary = progressService.getProgressSummary();
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    '${AppLocalizations.of(context)?.player ?? 'Player'}: ${summary['playerName'] ?? AppLocalizations.of(context)?.anonymous ?? 'Anonymous'}'),
                const SizedBox(height: 8),
                Text(
                    '${AppLocalizations.of(context)?.levelsCompleted ?? 'Levels Completed'}: ${summary['completedLevels']}/${AppConstants.totalLevels}'),
                const SizedBox(height: 8),
                Text(
                    '${AppLocalizations.of(context)?.totalPlayTime ?? 'Total Play Time'}: ${_formatDuration(summary['totalPlayTime'])}'),
                const SizedBox(height: 8),
                Text(
                    '${AppLocalizations.of(context)?.currentStreak ?? 'Current Streak'}: ${summary['currentStreak']} ${AppLocalizations.of(context)?.days ?? 'days'}'),
                const SizedBox(height: 8),
                Text(
                    '${AppLocalizations.of(context)?.achievements ?? 'Achievements'}: ${summary['totalAchievements']}'),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)?.close ?? 'Close'),
          ),
        ],
      ),
    );
  }

  void _showAchievementsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Achievements'),
        content: Consumer<ProgressService>(
          builder: (context, progressService, child) {
            if (progressService.achievements.isEmpty) {
              return const Text(
                  'No achievements yet. Keep playing to unlock them!');
            }

            return SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: progressService.achievements.length,
                itemBuilder: (context, index) {
                  final achievement = progressService.achievements[index];
                  return ListTile(
                    leading: const Icon(Icons.emoji_events,
                        color: AppConstants.warningColor),
                    title: Text(achievement.title),
                    subtitle: Text(achievement.description),
                  );
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(localizations?.settings ?? 'Settings'),
        content: Consumer3<AudioService, LanguageService, AuthService>(
          builder: (context, audioService, languageService, authService, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // User info
                if (authService.isAuthenticated) ...[
                  ListTile(
                    leading: Icon(Icons.person, color: AppConstants.primaryColor),
                    title: Text('Logged in as'),
                    subtitle: Text(authService.userName),
                  ),
                  const Divider(),
                ],

                // Language selection
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(localizations?.language ?? 'Language'),
                  subtitle: Text(
                      '${languageService.currentLanguageFlag} ${languageService.currentLanguageName}'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.pop(context); // Close settings first
                    LanguageSelectionDialog.show(context);
                  },
                ),
                const Divider(),

                // Audio settings
                SwitchListTile(
                  title: Text(localizations?.music ?? 'Music'),
                  value: audioService.musicEnabled,
                  onChanged: (value) => audioService.toggleMusic(),
                ),
                SwitchListTile(
                  title: Text(localizations?.soundEffects ?? 'Sound Effects'),
                  value: audioService.sfxEnabled,
                  onChanged: (value) => audioService.toggleSfx(),
                ),
                ListTile(
                  title: Text(localizations?.musicVolume ?? 'Music Volume'),
                  subtitle: Slider(
                    value: audioService.musicVolume,
                    onChanged: (value) => audioService.setMusicVolume(value),
                  ),
                ),
                ListTile(
                  title: Text(localizations?.sfxVolume ?? 'SFX Volume'),
                  subtitle: Slider(
                    value: audioService.sfxVolume,
                    onChanged: (value) => audioService.setSfxVolume(value),
                  ),
                ),
                
                // Logout option
                if (authService.isAuthenticated) ...[
                  const Divider(),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.red),
                    title: Text('Logout', style: TextStyle(color: Colors.red)),
                    onTap: () {
                      Navigator.pop(context); // Close settings
                      _showLogoutConfirmation(context, authService);
                    },
                  ),
                ],
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(localizations?.close ?? 'Close'),
          ),
        ],
      ),
    );
  }

  String _formatDuration(int seconds) {
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  void _showLogoutConfirmation(BuildContext context, AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              authService.logout();
              Navigator.pop(context); // Close dialog
              // Navigate back to splash screen which will redirect to login
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SplashScreen()),
                (route) => false,
              );
            },
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
