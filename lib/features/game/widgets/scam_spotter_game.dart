import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class ScamSpotterGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const ScamSpotterGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<ScamSpotterGame> createState() => _ScamSpotterGameState();
}

class _ScamSpotterGameState extends State<ScamSpotterGame>
    with TickerProviderStateMixin {
  late AnimationController _cardController;
  late AnimationController _swipeController;
  late AnimationController _successController;
  
  List<ScamCard> cards = [];
  int currentCardIndex = 0;
  int score = 0;
  int correctAnswers = 0;
  bool isComplete = false;
  bool isSwipeActive = false;
  
  @override
  void initState() {
    super.initState();
    
    _cardController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    
    _swipeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    
    _successController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _initializeCards();
    _cardController.forward();
  }

  void _initializeCards() {
    // Sample scam cards - in real implementation these would come from gameData
    cards = [
      ScamCard(
        message: "Congratulations! You have won ₹50,000! Click here and enter your PIN to claim!",
        isScam: true,
        scamType: 'fake_prize',
        explanation: 'Real prizes never ask for your PIN or password. Always delete messages like this immediately.',
      ),
      ScamCard(
        message: "Your account will be closed in 24 hours! Enter your bank details immediately to prevent this!",
        isScam: true,
        scamType: 'urgent_threat',
        explanation: 'Real banks communicate through official channels and never threaten account closure suddenly.',
      ),
      ScamCard(
        message: "Thank you for your payment to XYZ Store. If this was not you, call 123-456-7890",
        isScam: true,
        scamType: 'fake_transaction',
        explanation: 'Scammers trick you into calling them. Check your bank app directly, don\'t call numbers from messages.',
      ),
      ScamCard(
        message: "Your bank is updating security. Please verify your account by clicking this link from our official website.",
        isScam: false,
        scamType: '',
        explanation: 'This appears to be from an official bank communication, but always verify by visiting the bank\'s website directly.',
      ),
    ];
    
    // Override with actual game data if available
    final gameCards = widget.gameData['cards'] as List<Map<String, dynamic>>?;
    if (gameCards != null) {
      cards = gameCards.map((cardData) => ScamCard(
        message: cardData['message'] ?? '',
        isScam: cardData['isScam'] ?? false,
        scamType: cardData['scamType'] ?? '',
        explanation: cardData['explanation'] ?? '',
      )).toList();
    }
  }

  @override
  void dispose() {
    _cardController.dispose();
    _swipeController.dispose();
    _successController.dispose();
    super.dispose();
  }

  void _swipeCard(bool swipedLeft) {
    if (isSwipeActive || currentCardIndex >= cards.length) return;
    
    setState(() {
      isSwipeActive = true;
    });
    
    final currentCard = cards[currentCardIndex];
    final isScam = currentCard.isScam;
    final userSaysScam = swipedLeft; // Left swipe = SCAM, Right swipe = SAFE
    
    final isCorrect = (isScam && userSaysScam) || (!isScam && !userSaysScam);
    
    if (isCorrect) {
      correctAnswers++;
      score += 20;
    }
    
    _swipeController.forward().then((_) {
      _showResultDialog(currentCard, isCorrect);
    });
  }

  void _showResultDialog(ScamCard card, bool wasCorrect) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              wasCorrect ? Icons.check_circle : Icons.error,
              color: wasCorrect ? Colors.green : Colors.red,
              size: 30,
            ),
            const SizedBox(width: 8),
            Text(
              wasCorrect ? 'Correct!' : 'Not quite!',
              style: TextStyle(
                color: wasCorrect ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.isScam ? 'This is a SCAM' : 'This appears SAFE',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: card.isScam ? Colors.red : Colors.green,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              card.explanation,
              style: const TextStyle(fontSize: 14),
            ),
            if (!card.isScam) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange[100],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning, color: Colors.orange[600], size: 20),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Always verify by visiting official websites directly!',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: _nextCard,
            style: ElevatedButton.styleFrom(
              backgroundColor: wasCorrect ? Colors.green : Colors.orange,
            ),
            child: const Text(
              'Next',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _nextCard() {
    Navigator.pop(context);
    
    setState(() {
      currentCardIndex++;
      isSwipeActive = false;
    });
    
    _swipeController.reset();
    
    if (currentCardIndex >= cards.length) {
      _completeGame();
    } else {
      _cardController.reset();
      _cardController.forward();
    }
  }

  void _completeGame() {
    setState(() {
      isComplete = true;
    });
    
    _successController.forward();
    
    Future.delayed(const Duration(milliseconds: 2000), () {
      final accuracy = (correctAnswers / cards.length * 100).round();
      final finalScore = score + (accuracy > 80 ? 50 : 0); // Bonus for high accuracy
      widget.onComplete(accuracy >= 60, finalScore);
    });
  }

  Widget _buildCard() {
    if (currentCardIndex >= cards.length) {
      return const SizedBox.shrink();
    }
    
    final card = cards[currentCardIndex];
    
    return AnimatedBuilder(
      animation: Listenable.merge([_cardController, _swipeController]),
      builder: (context, child) {
        final swipeOffset = _swipeController.value * 300;
        final opacity = 1.0 - _swipeController.value;
        
        return Transform.translate(
          offset: Offset(swipeOffset, 0),
          child: Transform.scale(
            scale: _cardController.value * (1.0 - _swipeController.value * 0.1),
            child: Opacity(
              opacity: opacity,
              child: Container(
                width: 320,
                height: 400,
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Card header
                    Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red[50],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(Icons.message, color: Colors.red[400]),
                          const SizedBox(width: 12),
                          const Text(
                            'Message Received',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'Unknown Sender',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ),
                    
                    // Message content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  card.message,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Swipe indicators
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _buildSwipeIndicator(
                                  'SCAM',
                                  Icons.arrow_back,
                                  Colors.red,
                                  'Swipe Left',
                                ),
                                _buildSwipeIndicator(
                                  'SAFE',
                                  Icons.arrow_forward,
                                  Colors.green,
                                  'Swipe Right',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwipeIndicator(String label, IconData icon, Color color, String instruction) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color, width: 2),
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          instruction,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSwipeButtons() {
    if (currentCardIndex >= cards.length || isSwipeActive) {
      return const SizedBox.shrink();
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () => _swipeCard(true), // Left = SCAM
          icon: const Icon(Icons.close),
          label: const Text('SCAM'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _swipeCard(false), // Right = SAFE
          icon: const Icon(Icons.check),
          label: const Text('SAFE'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    final progress = currentCardIndex / cards.length;
    
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Card ${currentCardIndex + 1} of ${cards.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'Score: $score',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[600]!),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessOverlay() {
    if (!isComplete) return const SizedBox.shrink();
    
    final accuracy = (correctAnswers / cards.length * 100).round();
    
    return Positioned.fill(
      child: Container(
        color: accuracy >= 80 
          ? Colors.green.withOpacity(0.9)
          : Colors.orange.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                accuracy >= 80 ? Icons.security : Icons.shield,
                size: 100,
                color: Colors.white,
              ).animate(controller: _successController)
               .rotate(begin: 0, end: 0.5)
               .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
              
              const SizedBox(height: 20),
              
              Text(
                accuracy >= 80 ? 'Scam Detector!' : 'Keep Learning!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'You got $correctAnswers out of ${cards.length} correct ($accuracy%)',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              
              Text(
                'Final Score: $score points',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                accuracy >= 80
                  ? 'Excellent! You can spot scams like a pro!'
                  : 'Practice makes perfect - keep learning about online safety!',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
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
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red[50]!,
            Colors.orange[50]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              // Instructions
              Container(
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
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
                  children: [
                    Icon(Icons.security, color: Colors.red[600]),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Swipe left for SCAM, right for SAFE!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Progress bar
              _buildProgressBar(),
              
              // Card
              Expanded(
                child: Center(
                  child: _buildCard(),
                ),
              ),
              
              // Swipe buttons
              Padding(
                padding: const EdgeInsets.all(20),
                child: _buildSwipeButtons(),
              ),
            ],
          ),

          // Success overlay
          _buildSuccessOverlay(),
        ],
      ),
    );
  }
}

class ScamCard {
  final String message;
  final bool isScam;
  final String scamType;
  final String explanation;

  ScamCard({
    required this.message,
    required this.isScam,
    required this.scamType,
    required this.explanation,
  });
}