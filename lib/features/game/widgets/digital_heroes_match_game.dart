import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class DigitalHeroesMatchGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const DigitalHeroesMatchGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<DigitalHeroesMatchGame> createState() => _DigitalHeroesMatchGameState();
}

class _DigitalHeroesMatchGameState extends State<DigitalHeroesMatchGame>
    with TickerProviderStateMixin {
  late AnimationController _connectionController;
  late AnimationController _celebrationController;
  
  List<MatchPair> pairs = [];
  List<ConnectionLine> connections = [];
  int? selectedImageIndex;
  int correctMatches = 0;
  bool isComplete = false;
  
  @override
  void initState() {
    super.initState();
    
    _connectionController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _initializeGame();
  }

  void _initializeGame() {
    final pairsData = List<Map<String, dynamic>>.from(widget.gameData['pairs'] ?? []);
    
    pairs = pairsData.map((pairData) => MatchPair(
      imageDescription: pairData['image'] ?? '',
      textDescription: pairData['description'] ?? '',
      isMatched: false,
    )).toList();
    
    // Shuffle descriptions to make it challenging
    final descriptions = pairs.map((p) => p.textDescription).toList()..shuffle();
    for (int i = 0; i < pairs.length; i++) {
      pairs[i] = MatchPair(
        imageDescription: pairs[i].imageDescription,
        textDescription: descriptions[i],
        isMatched: pairs[i].isMatched,
      );
    }
  }

  @override
  void dispose() {
    _connectionController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  void _onImageTapped(int index) {
    setState(() {
      selectedImageIndex = selectedImageIndex == index ? null : index;
    });
  }

  void _onDescriptionTapped(int index) {
    if (selectedImageIndex == null) return;
    
    final imagePair = pairs[selectedImageIndex!];
    final descriptionText = pairs[index].textDescription;
    
    // Check if this is a correct match
    final isCorrect = _isCorrectMatch(imagePair.imageDescription, descriptionText);
    
    if (isCorrect) {
      setState(() {
        // Mark both as matched
        pairs[selectedImageIndex!] = MatchPair(
          imageDescription: imagePair.imageDescription,
          textDescription: imagePair.textDescription,
          isMatched: true,
        );
        
        pairs[index] = MatchPair(
          imageDescription: pairs[index].imageDescription,
          textDescription: descriptionText,
          isMatched: true,
        );
        
        // Add connection line
        connections.add(ConnectionLine(
          fromIndex: selectedImageIndex!,
          toIndex: index,
          isCorrect: true,
        ));
        
        correctMatches++;
        selectedImageIndex = null;
      });
      
      _connectionController.forward().then((_) {
        _connectionController.reset();
        
        // Check if game is complete
        if (correctMatches >= pairs.length) {
          _completeGame();
        }
      });
    } else {
      // Wrong match - show temporary incorrect connection
      setState(() {
        connections.add(ConnectionLine(
          fromIndex: selectedImageIndex!,
          toIndex: index,
          isCorrect: false,
        ));
        selectedImageIndex = null;
      });
      
      // Remove incorrect connection after animation
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          connections.removeWhere((conn) => !conn.isCorrect);
        });
      });
    }
  }

  bool _isCorrectMatch(String imageDescription, String textDescription) {
    // Define the correct matches based on the original pairs data
    final originalPairs = List<Map<String, dynamic>>.from(widget.gameData['pairs'] ?? []);
    
    for (final pairData in originalPairs) {
      if (pairData['image'] == imageDescription && 
          pairData['description'] == textDescription) {
        return true;
      }
    }
    return false;
  }

  void _completeGame() {
    setState(() {
      isComplete = true;
    });
    
    _celebrationController.forward();
    
    Future.delayed(const Duration(milliseconds: 2000), () {
      final accuracy = (correctMatches / pairs.length * 100).round();
      final points = math.max(80, accuracy * 2);
      widget.onComplete(true, points);
    });
  }

  Widget _buildImageCard(int index) {
    final pair = pairs[index];
    final isSelected = selectedImageIndex == index;
    final isMatched = pair.isMatched;
    
    return GestureDetector(
      onTap: isMatched ? null : () => _onImageTapped(index),
      child: Container(
        width: 140,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMatched 
            ? Colors.green[100] 
            : isSelected 
              ? Colors.blue[100] 
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isMatched 
              ? Colors.green 
              : isSelected 
                ? Colors.blue 
                : Colors.grey[300]!,
            width: isMatched || isSelected ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: isSelected ? 8 : 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getImageIcon(pair.imageDescription),
              size: 40,
              color: isMatched 
                ? Colors.green[600] 
                : isSelected 
                  ? Colors.blue[600] 
                  : Colors.grey[600],
            ),
            const SizedBox(height: 8),
            Text(
              _getImageLabel(pair.imageDescription),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isMatched 
                  ? Colors.green[800] 
                  : isSelected 
                    ? Colors.blue[800] 
                    : Colors.grey[800],
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    ).animate(target: isSelected ? 1 : 0)
     .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.05, 1.05))
     .shimmer(duration: 1000.ms, color: Colors.blue.withOpacity(0.3));
  }

  Widget _buildDescriptionCard(int index) {
    final pair = pairs[index];
    final isMatched = pair.isMatched;
    
    return GestureDetector(
      onTap: isMatched || selectedImageIndex == null 
        ? null 
        : () => _onDescriptionTapped(index),
      child: Container(
        width: 140,
        height: 100,
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMatched 
            ? Colors.green[100] 
            : selectedImageIndex != null 
              ? Colors.orange[50] 
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isMatched 
              ? Colors.green 
              : selectedImageIndex != null 
                ? Colors.orange 
                : Colors.grey[300]!,
            width: isMatched ? 3 : 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            pair.textDescription,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: isMatched 
                ? Colors.green[800] 
                : Colors.grey[800],
            ),
            textAlign: TextAlign.center,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
    ).animate(target: selectedImageIndex != null && !isMatched ? 1 : 0)
     .shimmer(duration: 800.ms, color: Colors.orange.withOpacity(0.2));
  }

  Widget _buildConnectionLines() {
    return CustomPaint(
      painter: ConnectionLinePainter(connections),
      size: Size.infinite,
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
                Icons.people,
                size: 100,
                color: Colors.white,
              ).animate(controller: _celebrationController)
               .rotate(begin: 0, end: 0.2)
               .then()
               .rotate(begin: 0.2, end: -0.2)
               .then()
               .rotate(begin: -0.2, end: 0),
              
              const SizedBox(height: 20),
              
              const Text(
                'Perfect Matches!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'You connected all $correctMatches digital heroes with their stories!',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Digital skills help people in every profession!',
                style: TextStyle(
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

  IconData _getImageIcon(String imageDescription) {
    if (imageDescription.contains('farmer')) return Icons.agriculture;
    if (imageDescription.contains('shopkeeper')) return Icons.store;
    if (imageDescription.contains('student')) return Icons.school;
    if (imageDescription.contains('doctor')) return Icons.medical_services;
    if (imageDescription.contains('teacher')) return Icons.person;
    return Icons.person;
  }

  String _getImageLabel(String imageDescription) {
    if (imageDescription.contains('farmer')) return 'Smart Farmer';
    if (imageDescription.contains('shopkeeper')) return 'Digital Shopkeeper';
    if (imageDescription.contains('student')) return 'Online Student';
    if (imageDescription.contains('doctor')) return 'Digital Doctor';
    if (imageDescription.contains('teacher')) return 'Tech Teacher';
    return 'Digital Hero';
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
            Colors.teal[50]!,
            Colors.teal[100]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // Instructions
                Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Text(
                    widget.gameData['instructions'] ?? 
                    'Tap a person, then tap their matching description to connect them!',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // Game area
                Expanded(
                  child: Stack(
                    children: [
                      // Connection lines
                      _buildConnectionLines(),
                      
                      // Game content
                      Row(
                        children: [
                          // Images column
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Digital Heroes',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: pairs.length,
                                    itemBuilder: (context, index) => _buildImageCard(index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(width: 20),
                          
                          // Descriptions column
                          Expanded(
                            child: Column(
                              children: [
                                const Text(
                                  'Their Stories',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: pairs.length,
                                    itemBuilder: (context, index) => _buildDescriptionCard(index),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Success overlay
          _buildSuccessOverlay(),
        ],
      ),
    );
  }
}

class MatchPair {
  final String imageDescription;
  final String textDescription;
  final bool isMatched;

  MatchPair({
    required this.imageDescription,
    required this.textDescription,
    required this.isMatched,
  });
}

class ConnectionLine {
  final int fromIndex;
  final int toIndex;
  final bool isCorrect;

  ConnectionLine({
    required this.fromIndex,
    required this.toIndex,
    required this.isCorrect,
  });
}

class ConnectionLinePainter extends CustomPainter {
  final List<ConnectionLine> connections;

  ConnectionLinePainter(this.connections);

  @override
  void paint(Canvas canvas, Size size) {
    for (final connection in connections) {
      final paint = Paint()
        ..color = connection.isCorrect ? Colors.green : Colors.red
        ..strokeWidth = 3
        ..style = PaintingStyle.stroke;

      // Calculate positions (simplified - would need actual widget positions)
      final fromX = size.width * 0.25;
      final fromY = 100.0 + (connection.fromIndex * 120.0);
      final toX = size.width * 0.75;
      final toY = 100.0 + (connection.toIndex * 120.0);

      canvas.drawLine(
        Offset(fromX, fromY),
        Offset(toX, toY),
        paint,
      );
      
      // Draw arrow at end
      const arrowSize = 8;
      final angle = (Offset(toX, toY) - Offset(fromX, fromY)).direction;
      
      final arrowP1 = Offset(
        toX - arrowSize * math.cos(angle - 0.5),
        toY - arrowSize * math.sin(angle - 0.5),
      );
      
      final arrowP2 = Offset(
        toX - arrowSize * math.cos(angle + 0.5),
        toY - arrowSize * math.sin(angle + 0.5),
      );
      
      final arrowPath = Path()
        ..moveTo(toX, toY)
        ..lineTo(arrowP1.dx, arrowP1.dy)
        ..lineTo(arrowP2.dx, arrowP2.dy)
        ..close();
        
      canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}