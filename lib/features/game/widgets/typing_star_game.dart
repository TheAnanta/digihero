import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'dart:async';

class TypingStarGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const TypingStarGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<TypingStarGame> createState() => _TypingStarGameState();
}

class _TypingStarGameState extends State<TypingStarGame>
    with TickerProviderStateMixin {
  late AnimationController _rainController;
  late AnimationController _celebrationController;
  
  List<FallingWord> fallingWords = [];
  List<String> wordBank = [];
  String currentInput = '';
  int score = 0;
  int lives = 3;
  int wordsTyped = 0;
  int totalWords = 0;
  bool gameActive = true;
  bool isComplete = false;
  
  Timer? gameTimer;
  TextEditingController inputController = TextEditingController();
  FocusNode inputFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    
    _rainController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
    
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _initializeGame();
    _startGame();
  }

  void _initializeGame() {
    wordBank = List<String>.from(widget.gameData['content'] ?? ['CAT', 'DOG', 'SUN']);
    totalWords = wordBank.length * 2; // Each word appears twice
    
    // Request focus for typing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inputFocus.requestFocus();
    });
  }

  void _startGame() {
    gameTimer = Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (!gameActive) {
        timer.cancel();
        return;
      }
      
      _spawnWord();
    });
    
    // Start animation
    _rainController.forward();
  }

  void _spawnWord() {
    if (wordBank.isEmpty || fallingWords.length >= 5) return;
    
    final word = wordBank[math.Random().nextInt(wordBank.length)];
    final x = math.Random().nextDouble() * 300 + 50; // Random x position
    
    setState(() {
      fallingWords.add(FallingWord(
        text: word,
        x: x,
        y: -50,
        speed: 1.0 + math.Random().nextDouble(),
        id: DateTime.now().millisecondsSinceEpoch,
      ));
    });
  }

  void _updateWords() {
    setState(() {
      fallingWords = fallingWords.map((word) {
        return FallingWord(
          text: word.text,
          x: word.x,
          y: word.y + word.speed,
          speed: word.speed,
          id: word.id,
        );
      }).toList();
      
      // Remove words that fell off screen
      final droppedWords = fallingWords.where((word) => word.y > 500).toList();
      fallingWords.removeWhere((word) => word.y > 500);
      
      // Lose life for dropped words
      for (final dropped in droppedWords) {
        lives--;
        if (lives <= 0) {
          _gameOver();
        }
      }
    });
  }

  void _onInputChanged(String value) {
    setState(() {
      currentInput = value.toUpperCase();
    });
    
    // Check if input matches any falling word
    for (final word in fallingWords) {
      if (word.text.toUpperCase() == currentInput) {
        _wordCaught(word);
        break;
      }
    }
  }

  void _wordCaught(FallingWord word) {
    setState(() {
      fallingWords.removeWhere((w) => w.id == word.id);
      inputController.clear();
      currentInput = '';
      wordsTyped++;
      score += 10 + (word.speed * 5).round(); // Bonus for faster words
    });
    
    // Check if game is complete
    if (wordsTyped >= totalWords) {
      _gameComplete();
    }
  }

  void _gameOver() {
    setState(() {
      gameActive = false;
    });
    
    gameTimer?.cancel();
    
    Future.delayed(const Duration(milliseconds: 1000), () {
      widget.onComplete(false, score);
    });
  }

  void _gameComplete() {
    setState(() {
      gameActive = false;
      isComplete = true;
    });
    
    gameTimer?.cancel();
    _celebrationController.forward();
    
    Future.delayed(const Duration(milliseconds: 2000), () {
      final accuracy = (wordsTyped / totalWords * 100).round();
      final finalScore = score + (lives * 20); // Bonus for remaining lives
      widget.onComplete(true, finalScore);
    });
  }

  Widget _buildFallingWord(FallingWord word) {
    final isTarget = word.text.toUpperCase().startsWith(currentInput) && currentInput.isNotEmpty;
    
    return Positioned(
      left: word.x,
      top: word.y,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isTarget ? Colors.yellow[200] : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isTarget ? Colors.orange : Colors.blue,
            width: isTarget ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: (isTarget ? Colors.orange : Colors.blue).withOpacity(0.3),
              blurRadius: isTarget ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          word.text,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isTarget ? Colors.orange[800] : Colors.blue[800],
          ),
        ),
      ).animate(target: isTarget ? 1 : 0)
       .shimmer(duration: 300.ms, color: Colors.yellow.withOpacity(0.5)),
    );
  }

  Widget _buildGameStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Score', score.toString(), Icons.star, Colors.orange),
          _buildStatItem('Lives', lives.toString(), Icons.favorite, Colors.red),
          _buildStatItem('Typed', '$wordsTyped/$totalWords', Icons.keyboard, Colors.blue),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildInputArea() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
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
                Icons.keyboard,
                color: Colors.purple[600],
              ),
              const SizedBox(width: 8),
              const Text(
                'Type the falling words:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: inputController,
            focusNode: inputFocus,
            onChanged: _onInputChanged,
            enabled: gameActive,
            decoration: InputDecoration(
              hintText: 'Type here...',
              prefixIcon: const Icon(Icons.edit),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.purple[50],
            ),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (currentInput.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                'Typing: $currentInput',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.purple[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSuccessOverlay() {
    if (!isComplete) return const SizedBox.shrink();
    
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
              ).animate(controller: _celebrationController)
               .rotate(begin: 0, end: 2)
               .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.2, 1.2)),
              
              const SizedBox(height: 20),
              
              const Text(
                'Typing Star!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'You typed $wordsTyped words correctly!',
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              
              Text(
                'Final Score: $score points',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Your typing skills are getting stronger!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  Widget _buildGameOverOverlay() {
    if (gameActive || isComplete) return const SizedBox.shrink();
    
    return Positioned.fill(
      child: Container(
        color: Colors.red.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.keyboard_alt,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'Keep Practicing!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'You typed $wordsTyped words - not bad!',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'The more you practice, the faster you will get!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
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
    // Update word positions
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (gameActive && mounted) {
        _updateWords();
      }
    });
    
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.indigo[900]!,
            Colors.indigo[700]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Stars background
          ...List.generate(20, (index) {
            return Positioned(
              left: math.Random().nextDouble() * 400,
              top: math.Random().nextDouble() * 400,
              child: AnimatedBuilder(
                animation: _rainController,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _rainController.value * 2 * math.pi,
                    child: Icon(
                      Icons.star,
                      color: Colors.white.withOpacity(0.3),
                      size: 12 + math.Random().nextDouble() * 8,
                    ),
                  );
                },
              ),
            );
          }),
          
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Game stats
                _buildGameStats(),
                
                const SizedBox(height: 20),
                
                // Game area
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue[50]?.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Stack(
                      children: [
                        // Falling words
                        ...fallingWords.map((word) => _buildFallingWord(word)),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Input area
                _buildInputArea(),
              ],
            ),
          ),

          // Success overlay
          _buildSuccessOverlay(),
          
          // Game over overlay
          _buildGameOverOverlay(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    gameTimer?.cancel();
    _rainController.dispose();
    _celebrationController.dispose();
    inputController.dispose();
    inputFocus.dispose();
    super.dispose();
  }
}

class FallingWord {
  final String text;
  final double x;
  final double y;
  final double speed;
  final int id;

  FallingWord({
    required this.text,
    required this.x,
    required this.y,
    required this.speed,
    required this.id,
  });
}