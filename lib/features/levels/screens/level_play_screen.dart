import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:async';
import '../../../core/constants/app_constants.dart';
import '../../../core/services/game_service.dart';
import '../../../core/services/audio_service.dart';
import '../../../core/services/progress_service.dart';
import '../../../core/models/game_models.dart';
import '../../ui/widgets/animated_button.dart';
import '../../ui/widgets/progress_indicator_widget.dart';
import '../../characters/widgets/character_widget.dart';
import '../data/level_data.dart';
import '../widgets/gamified_challenge_widget.dart';

class LevelPlayScreen extends StatefulWidget {
  final int levelNumber;

  const LevelPlayScreen({
    super.key,
    required this.levelNumber,
  });

  @override
  State<LevelPlayScreen> createState() => _LevelPlayScreenState();
}

class _LevelPlayScreenState extends State<LevelPlayScreen>
    with TickerProviderStateMixin {
  late GameLevel _level;
  late AnimationController _timerController;
  late AnimationController _scoreController;
  late Timer _gameTimer;

  int _currentChallengeIndex = 0;
  int _score = 0;
  int _timeRemaining = 0;
  int _lives = 3;
  bool _isGameActive = false;
  bool _isPaused = false;
  bool _showHint = false;
  String? _selectedAnswer;
  List<String> _dragItems = [];
  List<String> _dropTargets = [];
  Map<String, String> _deviceBuilderAnswers = {};

  @override
  void initState() {
    super.initState();
    _level = LevelData.getLevelData(widget.levelNumber);

    // Initialize with default values, will be updated in didChangeDependencies
    _timeRemaining = _level.timeLimit;
    _lives = 3;

    _timerController = AnimationController(
      duration: Duration(seconds: _level.timeLimit),
      vsync: this,
    );

    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _initializeLevel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Now we can safely access the GameService
    final gameService = context.read<GameService>();
    _timeRemaining =
        gameService.getDifficultyAdjustedTimeLimit(_level.timeLimit);
    _lives = gameService.getDifficultyAdjustedLives();
  }

  void _initializeLevel() {
    // Initialize drag and drop items if needed
    final currentChallenge = _level.challenges[_currentChallengeIndex];
    if (currentChallenge.type == ChallengeType.dragAndDrop) {
      _dragItems = List.from(currentChallenge.options);
      _dragItems.shuffle();
      _dropTargets = List.filled(currentChallenge.options.length, '');
    }

    _startGame();
  }

  void _startGame() {
    setState(() {
      _isGameActive = true;
    });

    _timerController.forward();
    _startTimer();

    context.read<AudioService>().playBackgroundMusic('level_theme.mp3');
  }

  void _startTimer() {
    _gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused && _isGameActive) {
        setState(() {
          _timeRemaining--;
        });

        if (_timeRemaining <= 0) {
          _endGame(false);
        }
      }
    });
  }

  void _pauseGame() {
    setState(() {
      _isPaused = true;
    });
    _timerController.stop();
    context.read<AudioService>().pauseBackgroundMusic();
  }

  void _resumeGame() {
    setState(() {
      _isPaused = false;
    });
    _timerController.forward();
    context.read<AudioService>().resumeBackgroundMusic();
  }

  void _endGame(bool completed) {
    setState(() {
      _isGameActive = false;
    });

    _gameTimer.cancel();
    _timerController.stop();

    if (completed) {
      _showLevelCompleteDialog();
    } else {
      _showGameOverDialog();
    }
  }

  @override
  void dispose() {
    _timerController.dispose();
    _scoreController.dispose();
    _gameTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: _getBackgroundColors(),
          ),
        ),
        child: SafeArea(
          child: Consumer3<GameService, AudioService, ProgressService>(
            builder:
                (context, gameService, audioService, progressService, child) {
              return Stack(
                children: [
                  // Background elements
                  _buildBackgroundElements(),

                  // Main game content
                  Column(
                    children: [
                      // Game header
                      _buildGameHeader(audioService),

                      // Character and speech
                      _buildCharacterSection(),

                      // Challenge content
                      Expanded(
                        child: _buildChallengeContent(),
                      ),

                      // Game controls
                      _buildGameControls(audioService),
                    ],
                  ),

                  // Pause overlay
                  if (_isPaused) _buildPauseOverlay(audioService),

                  // Hint overlay
                  if (_showHint) _buildHintOverlay(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBackgroundElements() {
    return Positioned.fill(
      child: Stack(
        children: [
          // Animated particles
          ...List.generate(8, (index) {
            return Positioned(
              left: (index * 50.0) % MediaQuery.of(context).size.width,
              top: (index * 80.0) % MediaQuery.of(context).size.height,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              )
                  .animate(onPlay: (controller) => controller.repeat())
                  .scale(duration: 2000.ms, begin: const Offset(0.5, 0.5))
                  .fade(duration: 2000.ms),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildGameHeader(AudioService audioService) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Back button
          AnimatedButton(
            onPressed: () {
              audioService.playButtonClick();
              _pauseGame();
              _showExitDialog();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),

          const SizedBox(width: 16),

          // Level info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Level ${widget.levelNumber}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  _level.theme,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Game stats
          _buildGameStats(),
        ],
      ),
    );
  }

  Widget _buildGameStats() {
    return Row(
      children: [
        // Timer
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: _timeRemaining <= 30
                ? AppConstants.accentColor
                : Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.timer,
                color: Colors.white,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '$_timeRemaining',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // Score
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                color: AppConstants.warningColor,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                '$_score',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(width: 8),

        // Lives
        Row(
          children: List.generate(3, (index) {
            return Icon(
              index < _lives ? Icons.favorite : Icons.favorite_border,
              color: AppConstants.accentColor,
              size: 20,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCharacterSection() {
    final currentChallenge = _level.challenges[_currentChallengeIndex];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CharacterWidget(
        characterId: 'digiBuddy',
        size: 120,
        showSpeechBubble: true,
        speechText: currentChallenge.question,
      ),
    );
  }

  Widget _buildChallengeContent() {
    final currentChallenge = _level.challenges[_currentChallengeIndex];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Progress indicator
          ProgressIndicatorWidget(
            progress: (_currentChallengeIndex + 1) / _level.challenges.length,
            label:
                'Progress: ${_currentChallengeIndex + 1}/${_level.challenges.length}',
          ),

          const SizedBox(height: 30),

          // Challenge content based on type
          Expanded(
            child: _buildChallengeByType(currentChallenge),
          ),
        ],
      ),
    );
  }

  Widget _buildChallengeByType(GameChallenge challenge) {
    switch (challenge.type) {
      case ChallengeType.multipleChoice:
        return _buildMultipleChoiceChallenge(challenge);
      case ChallengeType.trueFalse:
        return _buildTrueFalseChallenge(challenge);
      case ChallengeType.dragAndDrop:
        return _buildDragAndDropChallenge(challenge);
      case ChallengeType.sequencing:
        return _buildSequencingChallenge(challenge);
      case ChallengeType.interactive:
        return _buildInteractiveChallenge(challenge);
      case ChallengeType.scenario:
        return _buildScenarioChallenge(challenge);
      case ChallengeType.deviceBuilder:
        return _buildDeviceBuilderChallenge(challenge);
      default:
        return _buildMultipleChoiceChallenge(challenge);
    }
  }

  Widget _buildMultipleChoiceChallenge(GameChallenge challenge) {
    return GameifiedChallengeWidget(
      challenge: challenge,
      selectedAnswer: _selectedAnswer,
      onAnswerSelected: (answer) => _selectAnswer(answer, challenge),
    );
  }

  Widget _buildTrueFalseChallenge(GameChallenge challenge) {
    return Column(
      children: [
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: AnimatedButton(
                onPressed: () => _selectAnswer('True', challenge),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _selectedAnswer == 'True'
                        ? AppConstants.secondaryColor.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedAnswer == 'True'
                          ? AppConstants.secondaryColor
                          : Colors.white.withOpacity(0.3),
                      width: 3,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check, color: Colors.white, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'TRUE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: AnimatedButton(
                onPressed: () => _selectAnswer('False', challenge),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: _selectedAnswer == 'False'
                        ? AppConstants.accentColor.withOpacity(0.3)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: _selectedAnswer == 'False'
                          ? AppConstants.accentColor
                          : Colors.white.withOpacity(0.3),
                      width: 3,
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.close, color: Colors.white, size: 32),
                      SizedBox(height: 8),
                      Text(
                        'FALSE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
      ],
    );
  }

  Widget _buildDragAndDropChallenge(GameChallenge challenge) {
    return Column(
      children: [
        // Drop targets
        Expanded(
          flex: 2,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: _dropTargets.length,
            itemBuilder: (context, index) {
              return DragTarget<String>(
                onAccept: (data) {
                  setState(() {
                    _dropTargets[index] = data;
                    _dragItems.remove(data);
                  });
                },
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    decoration: BoxDecoration(
                      color: _dropTargets[index].isEmpty
                          ? Colors.white.withOpacity(0.1)
                          : AppConstants.secondaryColor.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _dropTargets[index].isEmpty
                            ? 'Drop here'
                            : _dropTargets[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        const SizedBox(height: 20),

        // Draggable items
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _dragItems.map((item) {
                return Draggable<String>(
                  data: item,
                  feedback: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        item,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    margin: const EdgeInsets.only(right: 8),
                    width: 80,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSequencingChallenge(GameChallenge challenge) {
    return _buildDragAndDropChallenge(challenge); // Similar implementation
  }

  Widget _buildInteractiveChallenge(GameChallenge challenge) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Center(
              child: Text(
                'Interactive\nChallenge\nPlaceholder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 20),
          AnimatedButton(
            onPressed: () => _selectAnswer('Completed', challenge),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Text(
                'Complete Task',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioChallenge(GameChallenge challenge) {
    return _buildMultipleChoiceChallenge(
        challenge); // Similar to multiple choice
  }

  Widget _buildDeviceBuilderChallenge(GameChallenge challenge) {
    final interactiveData = challenge.interactiveData ?? {};
    final deviceType = interactiveData['deviceType'] ?? 'computer';
    final parts =
        List<String>.from(interactiveData['parts'] ?? challenge.options);
    final instructions = interactiveData['instructions'] ??
        'Drag each label to the correct part';

    return Column(
      children: [
        // Instructions
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Text(
                challenge.question,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                instructions,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Device illustration with drop zones
        Expanded(
          flex: 3,
          child: _buildDeviceIllustration(deviceType, parts),
        ),

        const SizedBox(height: 20),

        // Draggable labels
        Expanded(
          flex: 1,
          child: _buildDraggableLabels(parts),
        ),

        // Check answer button
        const SizedBox(height: 20),
        if (_deviceBuilderAnswers.length == parts.length)
          AnimatedButton(
            onPressed: () => _checkDeviceBuilderAnswer(challenge),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: AppConstants.primaryColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Text(
                'Check Answer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDeviceIllustration(String deviceType, List<String> parts) {
    // Larger computer illustration with better drop zones
    return Container(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          // Computer base illustration - made larger
          Center(
            child: Container(
              width: 350,
              height: 280,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: Colors.white.withOpacity(0.4), width: 3),
              ),
              child: CustomPaint(
                painter: ComputerPainter(),
                size: const Size(350, 280),
              ),
            ),
          ),

          // Drop zones positioned over device parts - larger targets
          ..._buildDropZones(parts),
        ],
      ),
    );
  }

  List<Widget> _buildDropZones(List<String> parts) {
    // Predefined positions for computer parts with better spacing
    final Map<String, Offset> positions = {
      'Monitor': const Offset(0.35, 0.08),
      'CPU': const Offset(0.05, 0.45),
      'Keyboard': const Offset(0.35, 0.82),
      'Mouse': const Offset(0.75, 0.75),
    };

    return parts.map((part) {
      final position = positions[part] ?? const Offset(0.5, 0.5);
      return Positioned(
        left: MediaQuery.of(context).size.width * position.dx - 70,
        top: 60 + (280 * position.dy) - 35,
        child: DragTarget<String>(
          onWillAccept: (data) => data == part,
          onAccept: (data) {
            setState(() {
              _deviceBuilderAnswers[part] = data;
            });
            context.read<AudioService>().playButtonClick();
          },
          builder: (context, candidateData, rejectedData) {
            final hasAnswer = _deviceBuilderAnswers.containsKey(part);
            final isHovered = candidateData.isNotEmpty;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 140,
              height: 70,
              decoration: BoxDecoration(
                color: hasAnswer
                    ? AppConstants.secondaryColor.withOpacity(0.9)
                    : isHovered
                        ? AppConstants.primaryColor.withOpacity(0.6)
                        : Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isHovered
                      ? AppConstants.primaryColor
                      : hasAnswer
                          ? AppConstants.secondaryColor
                          : Colors.white.withOpacity(0.6),
                  width: isHovered ? 4 : 3,
                ),
                boxShadow: [
                  if (isHovered || hasAnswer)
                    BoxShadow(
                      color: (isHovered
                              ? AppConstants.primaryColor
                              : AppConstants.secondaryColor)
                          .withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                ],
              ),
              child: Center(
                child: Text(
                  hasAnswer
                      ? _deviceBuilderAnswers[part]!
                      : 'Drop\n$part\nhere',
                  style: TextStyle(
                    color: hasAnswer
                        ? Colors.white
                        : Colors.white.withOpacity(0.8),
                    fontSize: hasAnswer ? 16 : 14,
                    fontWeight: hasAnswer ? FontWeight.w700 : FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          },
        ),
      );
    }).toList();
  }

  Widget _buildDraggableLabels(List<String> parts) {
    final availableLabels = parts
        .where((part) => !_deviceBuilderAnswers.containsValue(part))
        .toList();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: availableLabels.map((label) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Draggable<String>(
                data: label,
                feedback: Material(
                  color: Colors.transparent,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Text(
                      label,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                childWhenDragging: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.6), width: 2),
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppConstants.secondaryColor,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        color: Colors.white.withOpacity(0.3), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _checkDeviceBuilderAnswer(GameChallenge challenge) {
    final parts = List<String>.from(
        challenge.interactiveData?['parts'] ?? challenge.options);
    final allCorrect =
        parts.every((part) => _deviceBuilderAnswers[part] == part);

    if (allCorrect) {
      _selectAnswer('correct', challenge);
    } else {
      // Show feedback and allow retry
      setState(() {
        _deviceBuilderAnswers.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Not quite right! Try again.'),
          backgroundColor: Colors.red.withOpacity(0.8),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildGameControls(AudioService audioService) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Hint button
          if (!_showHint)
            AnimatedButton(
              onPressed: () {
                audioService.playButtonClick();
                setState(() {
                  _showHint = true;
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: const Icon(Icons.lightbulb, color: Colors.white),
              ),
            ),

          const Spacer(),

          // Submit/Next button
          if (_selectedAnswer != null || _dragItems.isEmpty)
            AnimatedButton(
              onPressed: () => _submitAnswer(),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: AppConstants.secondaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  _currentChallengeIndex < _level.challenges.length - 1
                      ? 'NEXT'
                      : 'FINISH',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPauseOverlay(AudioService audioService) {
    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Game Paused',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              AnimatedButton(
                onPressed: () {
                  audioService.playButtonClick();
                  _resumeGame();
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'RESUME',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHintOverlay() {
    final currentChallenge = _level.challenges[_currentChallengeIndex];

    return Container(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  const Icon(Icons.lightbulb, color: AppConstants.warningColor),
                  const SizedBox(width: 8),
                  const Text(
                    'Hint',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showHint = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                currentChallenge.explanation,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectAnswer(String answer, GameChallenge challenge) {
    setState(() {
      _selectedAnswer = answer;
    });
  }

  void _submitAnswer() {
    final currentChallenge = _level.challenges[_currentChallengeIndex];
    final isCorrect = _checkAnswer(currentChallenge);

    if (isCorrect) {
      context.read<AudioService>().playCorrectAnswer();
      final gameService = context.read<GameService>();
      final adjustedPoints =
          gameService.getDifficultyAdjustedPoints(currentChallenge.points);
      _score += adjustedPoints;
      _scoreController.forward();

      // Move to next challenge or complete level
      if (_currentChallengeIndex < _level.challenges.length - 1) {
        setState(() {
          _currentChallengeIndex++;
          _selectedAnswer = null;
          _showHint = false;

          // Reset drag and drop items for next challenge
          _dragItems.clear();
          _dropTargets.clear();

          // Reset device builder answers for next challenge
          _deviceBuilderAnswers.clear();
        });
        _initializeChallenge();
      } else {
        // Level completed - all challenges answered correctly
        _endGame(true);
      }
    } else {
      context.read<AudioService>().playWrongAnswer();
      _lives--;

      if (_lives <= 0) {
        _endGame(false);
      } else {
        // Show wrong answer feedback
        _showWrongAnswerDialog(currentChallenge);
      }
    }
  }

  bool _checkAnswer(GameChallenge challenge) {
    switch (challenge.type) {
      case ChallengeType.multipleChoice:
      case ChallengeType.scenario:
        return _selectedAnswer ==
            challenge.options[challenge.correctAnswerIndex];
      case ChallengeType.trueFalse:
        final correctAnswer =
            challenge.correctAnswerIndex == 0 ? 'True' : 'False';
        return _selectedAnswer == correctAnswer;
      case ChallengeType.dragAndDrop:
        // Check if all items are placed correctly
        if (_dragItems.isNotEmpty) return false; // Not all items placed

        // For drag and drop, we need to check if items are in correct order
        for (int i = 0; i < _dropTargets.length; i++) {
          if (_dropTargets[i] != challenge.options[i]) {
            return false;
          }
        }
        return true;
      case ChallengeType.sequencing:
        // For sequencing, check if the order matches expected sequence
        if (_dragItems.isNotEmpty) return false; // Not all items placed

        // Check if sequence is correct
        for (int i = 0; i < _dropTargets.length; i++) {
          if (_dropTargets[i] != challenge.options[i]) {
            return false;
          }
        }
        return true;
      case ChallengeType.interactive:
        return _selectedAnswer == 'Completed';
      default:
        // For all other challenge types, check if answer matches
        return _selectedAnswer == 'Completed';
    }
  }

  void _initializeChallenge() {
    final currentChallenge = _level.challenges[_currentChallengeIndex];
    if (currentChallenge.type == ChallengeType.dragAndDrop) {
      _dragItems = List.from(currentChallenge.options);
      _dragItems.shuffle();
      _dropTargets = List.filled(currentChallenge.options.length, '');
    }
  }

  void _showWrongAnswerDialog(GameChallenge challenge) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.close, color: AppConstants.accentColor),
            SizedBox(width: 8),
            Text('Wrong Answer'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('That\'s not correct. Try again!'),
            const SizedBox(height: 16),
            Text(
              'Hint: ${challenge.explanation}',
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: AppConstants.textSecondaryColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _selectedAnswer = null;
              });
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showLevelCompleteDialog() {
    final stars = _calculateStars();
    final timeBonus = _timeRemaining * 5;
    final totalScore = _score + timeBonus;

    // Update game service
    context.read<GameService>().completeLevel(
          widget.levelNumber,
          totalScore,
          stars,
          _level.timeLimit - _timeRemaining,
        );

    context.read<ProgressService>().recordLevelPlayed();
    context.read<AudioService>().playLevelComplete();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Level Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StarsWidget(
              totalStars: AppConstants.starsPerLevel,
              filledStars: stars,
              size: 32,
            ),
            const SizedBox(height: 16),
            Text('Score: $totalScore'),
            Text('Time Bonus: $timeBonus'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  void _showGameOverDialog() {
    context.read<AudioService>().playGameOver();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Game Over'),
        content: const Text('Don\'t give up! Try again to master this level.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Back to Level Select'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _restartLevel();
            },
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit Level?'),
        content: const Text('Your progress will be lost.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _resumeGame();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  void _restartLevel() {
    final gameService = context.read<GameService>();
    setState(() {
      _currentChallengeIndex = 0;
      _score = 0;
      _timeRemaining =
          gameService.getDifficultyAdjustedTimeLimit(_level.timeLimit);
      _lives = gameService.getDifficultyAdjustedLives();
      _selectedAnswer = null;
      _showHint = false;
    });
    _initializeLevel();
  }

  int _calculateStars() {
    final timePercentage = _timeRemaining / _level.timeLimit;
    final scorePercentage = _score / _level.targetScore;

    if (timePercentage >= 0.7 && scorePercentage >= 0.9) {
      return 3;
    } else if (timePercentage >= 0.5 && scorePercentage >= 0.7) {
      return 2;
    } else {
      return 1;
    }
  }

  List<Color> _getBackgroundColors() {
    switch (widget.levelNumber % 4) {
      case 1:
        return [AppConstants.primaryColor, AppConstants.secondaryColor];
      case 2:
        return [AppConstants.secondaryColor, AppConstants.warningColor];
      case 3:
        return [AppConstants.warningColor, AppConstants.accentColor];
      default:
        return [AppConstants.accentColor, AppConstants.primaryColor];
    }
  }
}

// Custom painter for drawing a simple computer illustration
class ComputerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.white.withOpacity(0.9);

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white.withOpacity(0.15);

    // Draw monitor (screen) - larger and more prominent
    final monitorRect = Rect.fromLTWH(size.width * 0.25, size.height * 0.05,
        size.width * 0.5, size.height * 0.45);
    canvas.drawRRect(
        RRect.fromRectAndRadius(monitorRect, const Radius.circular(8)),
        fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(monitorRect, const Radius.circular(8)), paint);

    // Draw monitor stand - more detailed
    final standRect = Rect.fromLTWH(size.width * 0.43, size.height * 0.5,
        size.width * 0.14, size.height * 0.08);
    canvas.drawRRect(
        RRect.fromRectAndRadius(standRect, const Radius.circular(4)),
        fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(standRect, const Radius.circular(4)), paint);

    // Monitor base
    final baseRect = Rect.fromLTWH(size.width * 0.38, size.height * 0.58,
        size.width * 0.24, size.height * 0.04);
    canvas.drawRRect(
        RRect.fromRectAndRadius(baseRect, const Radius.circular(8)), fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(baseRect, const Radius.circular(8)), paint);

    // Draw CPU unit - larger and more detailed
    final cpuRect = Rect.fromLTWH(size.width * 0.02, size.height * 0.35,
        size.width * 0.18, size.height * 0.45);
    canvas.drawRRect(
        RRect.fromRectAndRadius(cpuRect, const Radius.circular(6)), fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(cpuRect, const Radius.circular(6)), paint);

    // CPU details (power button, ports)
    final powerButton = Rect.fromLTWH(size.width * 0.06, size.height * 0.38,
        size.width * 0.03, size.width * 0.03);
    canvas.drawCircle(powerButton.center, powerButton.width / 2, paint);

    // Draw keyboard - larger and more detailed
    final keyboardRect = Rect.fromLTWH(size.width * 0.28, size.height * 0.78,
        size.width * 0.44, size.height * 0.12);
    canvas.drawRRect(
        RRect.fromRectAndRadius(keyboardRect, const Radius.circular(6)),
        fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(keyboardRect, const Radius.circular(6)), paint);

    // Keyboard keys (simple representation)
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 8; j++) {
        final keyRect = Rect.fromLTWH(
          keyboardRect.left + 8 + (j * (keyboardRect.width - 16) / 8),
          keyboardRect.top + 4 + (i * (keyboardRect.height - 8) / 3),
          (keyboardRect.width - 16) / 8 - 2,
          (keyboardRect.height - 8) / 3 - 2,
        );
        canvas.drawRRect(
            RRect.fromRectAndRadius(keyRect, const Radius.circular(2)),
            Paint()
              ..color = Colors.white.withOpacity(0.3)
              ..style = PaintingStyle.fill);
      }
    }

    // Draw mouse - larger and more detailed
    final mouseRect = Rect.fromLTWH(size.width * 0.76, size.height * 0.68,
        size.width * 0.12, size.height * 0.18);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            mouseRect, Radius.circular(mouseRect.width / 3)),
        fillPaint);
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            mouseRect, Radius.circular(mouseRect.width / 3)),
        paint);

    // Mouse scroll wheel
    final scrollWheel = Rect.fromLTWH(
      mouseRect.center.dx - 2,
      mouseRect.top + mouseRect.height * 0.2,
      4,
      mouseRect.height * 0.3,
    );
    canvas.drawRRect(
        RRect.fromRectAndRadius(scrollWheel, const Radius.circular(2)), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
