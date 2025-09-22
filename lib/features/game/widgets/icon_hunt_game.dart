import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class IconHuntGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const IconHuntGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<IconHuntGame> createState() => _IconHuntGameState();
}

class _IconHuntGameState extends State<IconHuntGame>
    with TickerProviderStateMixin {
  late AnimationController _timerController;
  late AnimationController _pulseController;
  late AnimationController _sparkleController;
  
  String targetIcon = '';
  List<String> desktopIcons = [];
  int timeLimit = 30;
  int timeRemaining = 30;
  bool gameActive = true;
  bool showSuccess = false;
  
  final Map<String, IconData> iconMap = {
    'folder': Icons.folder,
    'recycle_bin': Icons.delete,
    'computer': Icons.computer,
    'documents': Icons.description,
    'pictures': Icons.image,
    'calculator': Icons.calculate,
    'settings': Icons.settings,
    'browser': Icons.web,
    'music': Icons.music_note,
    'video': Icons.video_library,
    'email': Icons.email,
    'calendar': Icons.calendar_today,
  };

  @override
  void initState() {
    super.initState();
    
    _timerController = AnimationController(
      duration: Duration(seconds: timeLimit),
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();

    _initializeGame();
    _startTimer();
  }

  void _initializeGame() {
    targetIcon = widget.gameData['targetIcon'] ?? 'folder';
    desktopIcons = List<String>.from(widget.gameData['desktopIcons'] ?? []);
    timeLimit = widget.gameData['timeLimit'] ?? 30;
    timeRemaining = timeLimit;
    
    // Ensure target icon is in the desktop icons
    if (!desktopIcons.contains(targetIcon)) {
      desktopIcons.add(targetIcon);
    }
    
    // Shuffle icons for random placement
    desktopIcons.shuffle();
  }

  void _startTimer() {
    _timerController.forward();
    
    // Update timer every second
    _timerController.addListener(() {
      if (gameActive) {
        setState(() {
          timeRemaining = (timeLimit * (1 - _timerController.value)).round();
        });
        
        if (timeRemaining <= 0) {
          _gameTimeout();
        }
      }
    });
  }

  void _gameTimeout() {
    setState(() {
      gameActive = false;
    });
    
    Future.delayed(const Duration(milliseconds: 1000), () {
      widget.onComplete(false, 0);
    });
  }

  void _onIconTapped(String tappedIcon) {
    if (!gameActive) return;
    
    if (tappedIcon == targetIcon) {
      _onCorrectIconFound();
    } else {
      _onWrongIconTapped();
    }
  }

  void _onCorrectIconFound() {
    setState(() {
      gameActive = false;
      showSuccess = true;
    });
    
    final pointsEarned = math.max(50, (timeRemaining * 2)).toInt();
    
    Future.delayed(const Duration(milliseconds: 1500), () {
      widget.onComplete(true, pointsEarned);
    });
  }

  void _onWrongIconTapped() {
    // Add a slight shake animation or visual feedback for wrong choice
    // For now, just continue the game
  }

  Widget _buildDesktopIcon(String iconName, int index) {
    final isTarget = iconName == targetIcon;
    final iconData = iconMap[iconName] ?? Icons.help;
    
    return Positioned(
      left: (index % 4) * 80.0 + 40,
      top: (index ~/ 4) * 100.0 + 40,
      child: GestureDetector(
        onTap: () => _onIconTapped(iconName),
        child: Container(
          width: 64,
          height: 80,
          child: Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(
                  iconData,
                  size: 32,
                  color: _getIconColor(iconName),
                ),
              ).animate(target: isTarget && gameActive ? 1 : 0)
               .shimmer(duration: 1000.ms, color: Colors.yellow.withOpacity(0.5)),
              
              const SizedBox(height: 4),
              
              Text(
                _getIconLabel(iconName),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 2,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ).animate().scale(
        delay: Duration(milliseconds: index * 100),
        duration: 300.ms,
        begin: const Offset(0.8, 0.8),
        end: const Offset(1.0, 1.0),
      ),
    );
  }

  Color _getIconColor(String iconName) {
    switch (iconName) {
      case 'folder':
        return Colors.orange[600]!;
      case 'recycle_bin':
        return Colors.grey[700]!;
      case 'computer':
        return Colors.blue[700]!;
      case 'documents':
        return Colors.blue[600]!;
      case 'pictures':
        return Colors.green[600]!;
      case 'calculator':
        return Colors.purple[600]!;
      case 'settings':
        return Colors.grey[600]!;
      case 'browser':
        return Colors.red[600]!;
      case 'music':
        return Colors.pink[600]!;
      case 'video':
        return Colors.indigo[600]!;
      case 'email':
        return Colors.teal[600]!;
      case 'calendar':
        return Colors.orange[700]!;
      default:
        return Colors.grey[600]!;
    }
  }

  String _getIconLabel(String iconName) {
    switch (iconName) {
      case 'folder':
        return 'Folder';
      case 'recycle_bin':
        return 'Recycle Bin';
      case 'computer':
        return 'Computer';
      case 'documents':
        return 'Documents';
      case 'pictures':
        return 'Pictures';
      case 'calculator':
        return 'Calculator';
      case 'settings':
        return 'Settings';
      case 'browser':
        return 'Browser';
      case 'music':
        return 'Music';
      case 'video':
        return 'Videos';
      case 'email':
        return 'Email';
      case 'calendar':
        return 'Calendar';
      default:
        return iconName.replaceAll('_', ' ');
    }
  }

  Widget _buildTimerBar() {
    final progress = timeRemaining / timeLimit;
    Color timerColor;
    
    if (progress > 0.5) {
      timerColor = Colors.green;
    } else if (progress > 0.25) {
      timerColor = Colors.orange;
    } else {
      timerColor = Colors.red;
    }
    
    return Container(
      width: double.infinity,
      height: 8,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: double.infinity,
        decoration: BoxDecoration(
          color: timerColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: FractionallySizedBox(
          widthFactor: progress,
          child: Container(
            decoration: BoxDecoration(
              color: timerColor,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessOverlay() {
    if (!showSuccess) return const SizedBox.shrink();
    
    return Positioned.fill(
      child: Container(
        color: Colors.green.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 100,
                color: Colors.yellow[300],
              ).animate().scale(
                duration: 500.ms,
                begin: const Offset(0.5, 0.5),
                end: const Offset(1.2, 1.2),
              ).then()
               .scale(
                 duration: 300.ms,
                 begin: const Offset(1.2, 1.2),
                 end: const Offset(1.0, 1.0),
               ),
              
              const SizedBox(height: 20),
              
              const Text(
                'Found it!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'You found the ${_getIconLabel(targetIcon)} in ${timeLimit - timeRemaining} seconds!',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildTimeoutOverlay() {
    if (gameActive || showSuccess) return const SizedBox.shrink();
    
    return Positioned.fill(
      child: Container(
        color: Colors.red.withOpacity(0.9),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.timer_off,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Time\'s Up!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Don\'t worry, keep practicing!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1E3A8A), // Dark blue
            Color(0xFF3B82F6), // Lighter blue
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Background pattern
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: const DecorationImage(
                  image: AssetImage('assets/images/desktop_bg.png'),
                  fit: BoxFit.cover,
                  opacity: 0.3,
                ),
              ),
            ),
          ),
          
          // Header with target and timer
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        iconMap[targetIcon] ?? Icons.help,
                        size: 32,
                        color: _getIconColor(targetIcon),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Find the ${_getIconLabel(targetIcon)}!',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: timeRemaining > 10 ? Colors.green : Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Text(
                          '${timeRemaining}s',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildTimerBar(),
                ],
              ),
            ),
          ),

          // Desktop icons
          Positioned(
            top: 140,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Container(
                height: 440,
                child: Stack(
                  children: desktopIcons
                      .asMap()
                      .entries
                      .map((entry) => _buildDesktopIcon(entry.value, entry.key))
                      .toList(),
                ),
              ),
            ),
          ),

          // Success overlay
          _buildSuccessOverlay(),
          
          // Timeout overlay
          _buildTimeoutOverlay(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timerController.dispose();
    _pulseController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }
}