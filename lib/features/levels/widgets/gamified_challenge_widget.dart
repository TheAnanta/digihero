import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import '../../../core/constants/app_constants.dart';
import '../../../core/models/game_models.dart';
import '../../ui/widgets/animated_button.dart';
import '../../game/widgets/device_builder_game.dart';
import '../../game/widgets/power_up_sequence_game.dart';
import '../../game/widgets/icon_hunt_game.dart';
import '../../game/widgets/cursor_maestro_game.dart';
import '../../game/widgets/app_sorter_game.dart';

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
    // Check if this challenge uses an interactive game
    if (_isInteractiveGame()) {
      return _buildInteractiveGame();
    }
    
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

  bool _isInteractiveGame() {
    return [
      ChallengeType.deviceBuilder,
      ChallengeType.sequencing,
      ChallengeType.iconHunt,
      ChallengeType.cursorMaestro,
      ChallengeType.appSorter,
    ].contains(widget.challenge.type);
  }

  Widget _buildInteractiveGame() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8, // Taller for interactive games
      child: Column(
        children: [
          // Question header
          Container(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                widget.challenge.question,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textPrimaryColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          
          // Interactive game widget
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildGameWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameWidget() {
    // Merge challenge options into game data for games that need them
    final gameData = Map<String, dynamic>.from(widget.challenge.interactiveData ?? {});
    
    switch (widget.challenge.type) {
      case ChallengeType.deviceBuilder:
        return DeviceBuilderGame(
          gameData: gameData,
          onComplete: (isCorrect, points) {
            if (isCorrect) {
              widget.onAnswerSelected(widget.challenge.options[0]);
            }
          },
        );
        
      case ChallengeType.sequencing:
        // Pass options as steps for sequencing game
        gameData['steps'] = widget.challenge.options;
        return PowerUpSequenceGame(
          gameData: gameData,
          onComplete: (isCorrect, points) {
            if (isCorrect) {
              widget.onAnswerSelected(widget.challenge.options[0]);
            }
          },
        );
        
      case ChallengeType.iconHunt:
        return IconHuntGame(
          gameData: gameData,
          onComplete: (isCorrect, points) {
            if (isCorrect) {
              widget.onAnswerSelected(widget.challenge.options[0]);
            }
          },
        );
        
      case ChallengeType.cursorMaestro:
        return CursorMaestroGame(
          gameData: gameData,
          onComplete: (isCorrect, points) {
            if (isCorrect) {
              widget.onAnswerSelected(widget.challenge.options[0]);
            }
          },
        );
        
      case ChallengeType.appSorter:
        return AppSorterGame(
          gameData: gameData,
          onComplete: (isCorrect, points) {
            if (isCorrect) {
              widget.onAnswerSelected(widget.challenge.options[0]);
            }
          },
        );
        
      default:
        return Container(
          child: const Center(
            child: Text(
              'Interactive game not implemented',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ),
        );
    }
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
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Platform shadow
            Container(
              width: 90,
              height: 50,
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            // Main central platform (red like reference)
            Container(
              width: 90,
              height: 50,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFF6B6B),
                    Color(0xFFFF5252),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.6),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFFF6B6B).withOpacity(0.4),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnswerPlatform(int index) {
    final angle = (index * 2 * math.pi) / widget.challenge.options.length;
    final radius = 120.0;
    final centerX = MediaQuery.of(context).size.width / 2;
    final centerY = 100.0;
    
    final x = centerX + radius * math.cos(angle - math.pi / 2) - 70;
    final y = centerY + radius * math.sin(angle - math.pi / 2) - 35;
    
    final isSelected = widget.selectedAnswer == widget.challenge.options[index];
    final animationDelay = index * 200;

    return Positioned(
      left: x,
      top: y,
      child: AnimatedButton(
        onPressed: () => widget.onAnswerSelected(widget.challenge.options[index]),
        child: Transform.scale(
          scale: _platformController.value,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Platform shadow/depth effect
              Container(
                width: 140,
                height: 70,
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              // Main platform
              Container(
                width: 140,
                height: 70,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isSelected 
                      ? [
                          AppConstants.secondaryColor,
                          AppConstants.secondaryColor.withOpacity(0.7),
                        ]
                      : [
                          const Color(0xFFFF6B6B), // Red platform color like reference
                          const Color(0xFFFF5252),
                        ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected 
                      ? AppConstants.secondaryColor 
                      : Colors.white.withOpacity(0.6),
                    width: isSelected ? 3 : 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: isSelected 
                        ? AppConstants.secondaryColor.withOpacity(0.4)
                        : const Color(0xFFFF6B6B).withOpacity(0.3),
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
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + index), // A, B, C, D
                          style: TextStyle(
                            color: isSelected 
                              ? AppConstants.secondaryColor 
                              : const Color(0xFFFF6B6B),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    // Option text (truncated)
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          widget.challenge.options[index].length > 18
                              ? '${widget.challenge.options[index].substring(0, 18)}...'
                              : widget.challenge.options[index],
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
      bottom: 150,
      left: MediaQuery.of(context).size.width / 2 - 35,
      child: AnimatedBuilder(
        animation: _characterController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, math.sin(_characterController.value * 2 * math.pi) * 8),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Character shadow
                Container(
                  width: 75,
                  height: 75,
                  margin: const EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                ),
                // Character body
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF42A5F5), // Light blue
                        Color(0xFF1E88E5), // Darker blue
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF42A5F5).withOpacity(0.4),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Character face/icon
                      Icon(
                        Icons.android,
                        color: Colors.white,
                        size: 35,
                      ),
                      // Character eyes/details
                      Positioned(
                        top: 15,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: 6,
                              height: 6,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
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
        },
      ).animate().scale(
        delay: 1000.ms,
        duration: 800.ms,
        curve: Curves.elasticOut,
      ),
    );
  }
}