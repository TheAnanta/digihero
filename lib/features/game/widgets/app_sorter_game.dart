import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class AppSorterGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const AppSorterGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<AppSorterGame> createState() => _AppSorterGameState();
}

class _AppSorterGameState extends State<AppSorterGame>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _celebrationController;
  
  List<AppItem> availableApps = [];
  Map<String, List<AppItem>> categoryBoxes = {};
  List<String> categories = [];
  String? draggedApp;
  bool isComplete = false;
  int correctPlacements = 0;
  
  @override
  void initState() {
    super.initState();
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    
    _celebrationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _initializeGame();
  }

  void _initializeGame() {
    categories = List<String>.from(widget.gameData['categories'] ?? ['System Software', 'Application Software']);
    
    // Initialize category boxes
    for (String category in categories) {
      categoryBoxes[category] = [];
    }
    
    // Parse app items from game data
    final items = List<Map<String, dynamic>>.from(widget.gameData['items'] ?? []);
    availableApps = items.map((item) => AppItem(
      name: item['name'] ?? '',
      type: item['type'] ?? '',
      icon: item['icon'] ?? 'app.png',
    )).toList();
    
    // Shuffle available apps
    availableApps.shuffle();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _celebrationController.dispose();
    super.dispose();
  }

  void _onAppDropped(AppItem app, String category) {
    final expectedCategory = app.type == 'system' ? 'System Software' : 'Application Software';
    final isCorrect = category == expectedCategory;
    
    setState(() {
      availableApps.remove(app);
      categoryBoxes[category]!.add(app);
      draggedApp = null;
      
      if (isCorrect) {
        correctPlacements++;
      }
    });
    
    // Check if game is complete
    if (availableApps.isEmpty) {
      _completeGame();
    }
  }

  void _completeGame() {
    final totalApps = categoryBoxes.values.fold(0, (sum, list) => sum + list.length);
    final accuracy = (correctPlacements / totalApps * 100).round();
    
    setState(() {
      isComplete = true;
    });
    
    _celebrationController.forward();
    
    Future.delayed(const Duration(milliseconds: 2000), () {
      final points = math.max(50, accuracy * 2);
      widget.onComplete(accuracy >= 80, points);
    });
  }

  Widget _buildAppIcon(AppItem app, {bool isDragging = false}) {
    return Container(
      width: 80,
      height: 100,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDragging ? Colors.blue : Colors.grey[300]!,
          width: isDragging ? 3 : 1,
        ),
        boxShadow: isDragging 
          ? [
              BoxShadow(
                color: Colors.blue.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 2,
              ),
            ]
          : [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            _getAppIcon(app.name),
            size: 36,
            color: _getAppColor(app.name),
          ),
          const SizedBox(height: 8),
          Text(
            app.name,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ).animate(target: isDragging ? 1 : 0)
     .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1));
  }

  Widget _buildDraggableApp(AppItem app) {
    return Draggable<AppItem>(
      data: app,
      onDragStarted: () {
        setState(() {
          draggedApp = app.name;
        });
      },
      onDragEnd: (details) {
        setState(() {
          draggedApp = null;
        });
      },
      feedback: Material(
        color: Colors.transparent,
        child: _buildAppIcon(app, isDragging: true),
      ),
      childWhenDragging: Container(
        width: 80,
        height: 100,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, style: BorderStyle.dashed),
        ),
      ),
      child: _buildAppIcon(app),
    );
  }

  Widget _buildCategoryBox(String category) {
    final isHighlighted = draggedApp != null;
    final apps = categoryBoxes[category] ?? [];
    
    return DragTarget<AppItem>(
      onAccept: (app) => _onAppDropped(app, category),
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 200,
          height: 300,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isHighlighted 
              ? Colors.blue[50] 
              : Colors.grey[100],
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHighlighted 
                ? Colors.blue 
                : Colors.grey[400]!,
              width: 2,
              style: isHighlighted ? BorderStyle.solid : BorderStyle.dashed,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            children: [
              // Category title
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: _getCategoryColor(category),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Apps in category
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: apps.map((app) => 
                      _buildAppIcon(app).animate().scale(
                        delay: Duration(milliseconds: apps.indexOf(app) * 100),
                        duration: 300.ms,
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1.0, 1.0),
                      )
                    ).toList(),
                  ),
                ),
              ),
              
              // Drop zone indicator
              if (apps.isEmpty)
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.apps,
                          size: 40,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Drop apps here',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    ).animate(target: isHighlighted ? 1 : 0)
     .shimmer(duration: 1000.ms, color: Colors.blue.withOpacity(0.3));
  }

  Widget _buildAvailableApps() {
    if (availableApps.isEmpty) return const SizedBox.shrink();
    
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Available Apps',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            children: availableApps.map((app) => _buildDraggableApp(app)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResultOverlay() {
    if (!isComplete) return const SizedBox.shrink();
    
    final totalApps = correctPlacements + (availableApps.length == 0 
      ? categoryBoxes.values.fold(0, (sum, list) => sum + list.length) - correctPlacements
      : 0);
    final accuracy = (correctPlacements / totalApps * 100).round();
    final isSuccess = accuracy >= 80;
    
    return Positioned.fill(
      child: Container(
        color: isSuccess 
          ? Colors.green.withOpacity(0.9)
          : Colors.orange.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSuccess ? Icons.celebration : Icons.lightbulb,
                size: 100,
                color: Colors.white,
              ).animate(controller: _celebrationController)
               .rotate(begin: 0, end: 0.5)
               .then()
               .rotate(begin: 0.5, end: -0.5)
               .then()
               .rotate(begin: -0.5, end: 0),
              
              const SizedBox(height: 20),
              
              Text(
                isSuccess ? 'Excellent Sorting!' : 'Good Try!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              
              const SizedBox(height: 10),
              
              Text(
                'You sorted $correctPlacements out of $totalApps apps correctly (${accuracy}%)',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              if (!isSuccess) ...[
                const SizedBox(height: 10),
                const Text(
                  'Remember: System software runs your device,\nApplication software does specific tasks.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }

  IconData _getAppIcon(String appName) {
    switch (appName.toLowerCase()) {
      case 'calculator':
        return Icons.calculate;
      case 'android os':
        return Icons.android;
      case 'paint':
        return Icons.brush;
      case 'windows':
        return Icons.computer;
      case 'notes app':
        return Icons.note;
      case 'ios':
        return Icons.phone_iphone;
      case 'music player':
        return Icons.music_note;
      case 'camera':
        return Icons.camera_alt;
      case 'browser':
        return Icons.web;
      default:
        return Icons.apps;
    }
  }

  Color _getAppColor(String appName) {
    switch (appName.toLowerCase()) {
      case 'calculator':
        return Colors.purple[600]!;
      case 'android os':
        return Colors.green[600]!;
      case 'paint':
        return Colors.blue[600]!;
      case 'windows':
        return Colors.blue[700]!;
      case 'notes app':
        return Colors.orange[600]!;
      case 'ios':
        return Colors.grey[700]!;
      case 'music player':
        return Colors.pink[600]!;
      case 'camera':
        return Colors.teal[600]!;
      case 'browser':
        return Colors.red[600]!;
      default:
        return Colors.grey[600]!;
    }
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'System Software':
        return Colors.red[600]!;
      case 'Application Software':
        return Colors.blue[600]!;
      default:
        return Colors.grey[600]!;
    }
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
            Colors.purple[50]!,
            Colors.blue[50]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          SingleChildScrollView(
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
                    'Drag each app icon to the correct category box',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // Available apps
                _buildAvailableApps(),

                const SizedBox(height: 20),

                // Category boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: categories.map((category) => _buildCategoryBox(category)).toList(),
                ),
              ],
            ),
          ),

          // Result overlay
          _buildResultOverlay(),
        ],
      ),
    );
  }
}

class AppItem {
  final String name;
  final String type; // 'system' or 'application'
  final String icon;

  AppItem({
    required this.name,
    required this.type,
    required this.icon,
  });
}