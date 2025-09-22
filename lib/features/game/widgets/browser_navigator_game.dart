import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class BrowserNavigatorGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const BrowserNavigatorGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<BrowserNavigatorGame> createState() => _BrowserNavigatorGameState();
}

class _BrowserNavigatorGameState extends State<BrowserNavigatorGame>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _successController;
  
  String targetPart = '';
  List<String> browserParts = [];
  Map<String, bool> foundParts = {};
  int score = 0;
  bool isComplete = false;
  
  @override
  void initState() {
    super.initState();
    
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _successController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _initializeGame();
  }

  void _initializeGame() {
    browserParts = List<String>.from(widget.gameData['browserParts'] ?? []);
    targetPart = widget.gameData['targetPart'] ?? browserParts.first;
    
    // Initialize found parts
    for (String part in browserParts) {
      foundParts[part] = false;
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    _successController.dispose();
    super.dispose();
  }

  void _onPartTapped(String partId) {
    if (foundParts[partId] == true) return; // Already found
    
    if (partId == targetPart) {
      setState(() {
        foundParts[partId] = true;
        score += 20;
      });
      
      _showCorrectPartDialog(partId);
      
      // Move to next part or complete game
      Future.delayed(const Duration(milliseconds: 2000), () {
        _nextTarget();
      });
    } else {
      _showIncorrectPartDialog(partId);
    }
  }

  void _nextTarget() {
    final unFoundParts = foundParts.entries
        .where((entry) => !entry.value)
        .map((entry) => entry.key)
        .toList();
    
    if (unFoundParts.isEmpty) {
      _completeGame();
    } else {
      setState(() {
        targetPart = unFoundParts.first;
      });
    }
  }

  void _completeGame() {
    setState(() {
      isComplete = true;
    });
    
    _successController.forward();
    
    Future.delayed(const Duration(milliseconds: 2000), () {
      widget.onComplete(true, score);
    });
  }

  void _showCorrectPartDialog(String partId) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green, size: 30),
            const SizedBox(width: 8),
            const Text('Correct!', style: TextStyle(color: Colors.green)),
          ],
        ),
        content: Text(_getPartDescription(partId)),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text('Continue', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showIncorrectPartDialog(String partId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.error, color: Colors.orange, size: 30),
            const SizedBox(width: 8),
            const Text('Try Again!', style: TextStyle(color: Colors.orange)),
          ],
        ),
        content: Text('That\'s the ${_getPartName(partId)}. Look for the ${_getPartName(targetPart)}!'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('OK', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  String _getPartName(String partId) {
    switch (partId) {
      case 'address_bar':
        return 'Address Bar';
      case 'back_button':
        return 'Back Button';
      case 'forward_button':
        return 'Forward Button';
      case 'refresh_button':
        return 'Refresh Button';
      case 'tabs':
        return 'Tabs';
      case 'bookmarks':
        return 'Bookmarks';
      default:
        return partId.replaceAll('_', ' ');
    }
  }

  String _getPartDescription(String partId) {
    switch (partId) {
      case 'address_bar':
        return 'Great! The Address Bar is where you type website addresses like www.google.com';
      case 'back_button':
        return 'Perfect! The Back Button takes you to the previous page you visited.';
      case 'forward_button':
        return 'Excellent! The Forward Button moves you forward after going back.';
      case 'refresh_button':
        return 'Correct! The Refresh Button reloads the current page.';
      case 'tabs':
        return 'Nice! Tabs let you have multiple websites open at the same time.';
      case 'bookmarks':
        return 'Right! Bookmarks save your favorite websites for quick access.';
      default:
        return 'Well done! You found the ${_getPartName(partId)}.';
    }
  }

  Widget _buildBrowserFrame() {
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Browser header
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Column(
              children: [
                // Tab bar
                Container(
                  height: 35,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Row(
                    children: [
                      _buildClickableArea(
                        'tabs',
                        Container(
                          width: 120,
                          height: 25,
                          margin: const EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'My Website',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 30,
                        height: 25,
                        margin: const EdgeInsets.only(top: 5, left: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        child: const Center(
                          child: Text('+', style: TextStyle(fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
                // Navigation bar
                Container(
                  height: 45,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: Row(
                    children: [
                      // Back button
                      _buildClickableArea(
                        'back_button',
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.arrow_back, size: 18),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Forward button
                      _buildClickableArea(
                        'forward_button',
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.arrow_forward, size: 18),
                        ),
                      ),
                      const SizedBox(width: 4),
                      // Refresh button
                      _buildClickableArea(
                        'refresh_button',
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.refresh, size: 18),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Address bar
                      Expanded(
                        child: _buildClickableArea(
                          'address_bar',
                          Container(
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey[400]!),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'https://www.example.com',
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Bookmarks
                      _buildClickableArea(
                        'bookmarks',
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Icon(Icons.star, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Browser content area
          Expanded(
            child: Container(
              color: Colors.white,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.web, size: 60, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'Website Content Area',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This is where web pages are displayed',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClickableArea(String partId, Widget child) {
    final isTarget = partId == targetPart;
    final isFound = foundParts[partId] == true;
    
    return GestureDetector(
      onTap: () => _onPartTapped(partId),
      child: Container(
        decoration: BoxDecoration(
          border: isTarget && !isFound
            ? Border.all(
                color: Colors.blue,
                width: 2,
              )
            : isFound
              ? Border.all(
                  color: Colors.green,
                  width: 2,
                )
              : null,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Stack(
          children: [
            child,
            if (isTarget && !isFound)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ).animate(target: 1)
               .shimmer(duration: 1000.ms, color: Colors.blue.withOpacity(0.3)),
            if (isFound)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(Icons.check, color: Colors.green, size: 20),
                  ),
                ),
              ),
          ],
        ),
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
                Icons.web,
                size: 100,
                color: Colors.white,
              ).animate(controller: _successController)
               .rotate(begin: 0, end: 0.3)
               .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2)),
              
              const SizedBox(height: 20),
              
              const Text(
                'Browser Expert!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'You found all ${browserParts.length} browser parts!',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              
              Text(
                'Score: $score points',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              const Text(
                'Now you can navigate the web like a pro!',
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
    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.blue[50]!,
            Colors.blue[100]!,
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
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Colors.blue[600],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Find the ${_getPartName(targetPart)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                            const Text(
                              'Click on the browser parts to learn about them!',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                          ],
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
                ),

                const SizedBox(height: 30),

                // Browser frame
                Center(child: _buildBrowserFrame()),
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