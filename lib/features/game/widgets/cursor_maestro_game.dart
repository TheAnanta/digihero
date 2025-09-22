import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CursorMaestroGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const CursorMaestroGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<CursorMaestroGame> createState() => _CursorMaestroGameState();
}

class _CursorMaestroGameState extends State<CursorMaestroGame>
    with TickerProviderStateMixin {
  late AnimationController _instructionController;
  late AnimationController _successController;
  
  String action = '';
  String sourceItem = '';
  String targetLocation = '';
  bool isComplete = false;
  bool showInstructions = true;
  int clickCount = 0;
  DateTime? lastClickTime;
  
  Offset? dragStart;
  Offset? dragEnd;
  bool isDragging = false;
  bool dragSuccess = false;

  @override
  void initState() {
    super.initState();
    
    _instructionController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _successController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    _initializeGame();
  }

  void _initializeGame() {
    action = widget.gameData['action'] ?? 'drag_to_folder';
    sourceItem = widget.gameData['sourceItem'] ?? 'document_file';
    targetLocation = widget.gameData['targetLocation'] ?? 'my_folder';
    
    // Show instructions for a few seconds then hide
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          showInstructions = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _instructionController.dispose();
    _successController.dispose();
    super.dispose();
  }

  void _handleSingleClick() {
    final now = DateTime.now();
    
    if (lastClickTime != null && now.difference(lastClickTime!).inMilliseconds < 500) {
      // This is a double click
      _handleDoubleClick();
      return;
    }
    
    lastClickTime = now;
    clickCount = 1;
    
    // Wait to see if there's a second click
    Future.delayed(const Duration(milliseconds: 500), () {
      if (clickCount == 1 && action == 'single_click') {
        _onActionCompleted();
      }
      clickCount = 0;
    });
  }

  void _handleDoubleClick() {
    clickCount = 2;
    if (action == 'double_click') {
      _onActionCompleted();
    }
  }

  void _onDragStart(Offset position) {
    setState(() {
      dragStart = position;
      isDragging = true;
    });
  }

  void _onDragUpdate(Offset position) {
    setState(() {
      dragEnd = position;
    });
  }

  void _onDragEnd(Offset position) {
    setState(() {
      dragEnd = position;
      isDragging = false;
    });

    // Check if drag was successful (dropped on target)
    if (action.startsWith('drag_') && _isValidDrop(position)) {
      setState(() {
        dragSuccess = true;
      });
      _onActionCompleted();
    }
  }

  bool _isValidDrop(Offset dropPosition) {
    // Define target area (folder area)
    const targetArea = Rect.fromLTWH(300, 200, 120, 100);
    return targetArea.contains(dropPosition);
  }

  void _onActionCompleted() {
    setState(() {
      isComplete = true;
    });
    
    _successController.forward();
    
    Future.delayed(const Duration(milliseconds: 1200), () {
      widget.onComplete(true, 90);
    });
  }

  Widget _buildSourceFile() {
    return Positioned(
      left: 100,
      top: 250,
      child: GestureDetector(
        onTap: _handleSingleClick,
        onPanStart: (details) => _onDragStart(details.localPosition),
        onPanUpdate: (details) => _onDragUpdate(details.localPosition),
        onPanEnd: (details) => _onDragEnd(details.localPosition),
        child: Container(
          width: 80,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _getFileIcon(),
                size: 40,
                color: Colors.blue[600],
              ),
              const SizedBox(height: 8),
              Text(
                _getFileName(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ).animate(target: showInstructions ? 1 : 0)
       .shimmer(duration: 1000.ms, color: Colors.yellow.withOpacity(0.3))
       .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.05, 1.05)),
    );
  }

  Widget _buildTargetFolder() {
    return Positioned(
      left: 300,
      top: 200,
      child: Container(
        width: 120,
        height: 100,
        decoration: BoxDecoration(
          color: dragSuccess ? Colors.green[100] : Colors.orange[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: dragSuccess ? Colors.green : Colors.orange,
            width: 2,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder,
              size: 50,
              color: dragSuccess ? Colors.green[600] : Colors.orange[600],
            ),
            const SizedBox(height: 8),
            Text(
              'My Folder',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: dragSuccess ? Colors.green[800] : Colors.orange[800],
              ),
            ),
          ],
        ),
      ).animate(target: isDragging ? 1 : 0)
       .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.1, 1.1))
       .shimmer(duration: 800.ms, color: Colors.orange.withOpacity(0.3)),
    );
  }

  Widget _buildDragLine() {
    if (!isDragging || dragStart == null || dragEnd == null) {
      return const SizedBox.shrink();
    }

    return CustomPaint(
      painter: DragLinePainter(
        start: Offset(dragStart!.dx + 140, dragStart!.dy + 300), // Adjust for file position
        end: Offset(dragEnd!.dx + 140, dragEnd!.dy + 300),
      ),
      size: Size.infinite,
    );
  }

  Widget _buildInstructions() {
    if (!showInstructions) return const SizedBox.shrink();
    
    String instructionText = widget.gameData['instructions'] ?? 
        _getDefaultInstructions();
    
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
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
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getActionIcon(),
                color: Colors.blue[700],
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                instructionText,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    ).animate().slideY(
      begin: -1,
      end: 0,
      duration: 500.ms,
    ).fadeIn();
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
                Icons.mouse,
                size: 100,
                color: Colors.white,
              ).animate(controller: _successController)
               .rotate(begin: 0, end: 0.1)
               .then()
               .rotate(begin: 0.1, end: -0.1)
               .then()
               .rotate(begin: -0.1, end: 0),
              
              const SizedBox(height: 20),
              
              Text(
                _getSuccessMessage(),
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 10),
              
              Text(
                _getSuccessDescription(),
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

  IconData _getFileIcon() {
    switch (sourceItem) {
      case 'document_file':
        return Icons.description;
      case 'picture_file':
        return Icons.image;
      case 'music_file':
        return Icons.audio_file;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _getFileName() {
    switch (sourceItem) {
      case 'document_file':
        return 'My\nDocument';
      case 'picture_file':
        return 'My\nPicture';
      case 'music_file':
        return 'My\nSong';
      default:
        return 'My\nFile';
    }
  }

  IconData _getActionIcon() {
    switch (action) {
      case 'drag_to_folder':
        return Icons.drag_indicator;
      case 'double_click':
        return Icons.mouse;
      case 'single_click':
        return Icons.touch_app;
      default:
        return Icons.mouse;
    }
  }

  String _getDefaultInstructions() {
    switch (action) {
      case 'drag_to_folder':
        return 'Click and drag the file into the folder';
      case 'double_click':
        return 'Double-click the file to open it';
      case 'single_click':
        return 'Single-click to select the file';
      default:
        return 'Follow the instruction to complete the task';
    }
  }

  String _getSuccessMessage() {
    switch (action) {
      case 'drag_to_folder':
        return 'Perfect Drag!';
      case 'double_click':
        return 'Great Double-Click!';
      case 'single_click':
        return 'Nice Click!';
      default:
        return 'Well Done!';
    }
  }

  String _getSuccessDescription() {
    switch (action) {
      case 'drag_to_folder':
        return 'You successfully moved the file to the folder using drag and drop!';
      case 'double_click':
        return 'You opened the file with a perfect double-click!';
      case 'single_click':
        return 'You selected the file with a single click!';
      default:
        return 'You completed the mouse action correctly!';
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
            Colors.purple[100]!,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Desktop background
          Positioned.fill(
            child: Container(
              margin: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[300]!, width: 2),
              ),
            ),
          ),
          
          // Instructions
          _buildInstructions(),
          
          // Drag line
          _buildDragLine(),
          
          // Source file
          _buildSourceFile(),
          
          // Target folder
          _buildTargetFolder(),
          
          // Success overlay
          _buildSuccessOverlay(),
        ],
      ),
    );
  }
}

class DragLinePainter extends CustomPainter {
  final Offset start;
  final Offset end;

  DragLinePainter({required this.start, required this.end});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    canvas.drawLine(start, end, paint);
    
    // Draw arrow head at end
    const arrowSize = 10;
    final angle = (end - start).direction;
    
    final arrowP1 = Offset(
      end.dx - arrowSize * math.cos(angle - 0.5),
      end.dy - arrowSize * math.sin(angle - 0.5),
    );
    
    final arrowP2 = Offset(
      end.dx - arrowSize * math.cos(angle + 0.5),
      end.dy - arrowSize * math.sin(angle + 0.5),
    );
    
    final arrowPath = Path()
      ..moveTo(end.dx, end.dy)
      ..lineTo(arrowP1.dx, arrowP1.dy)
      ..lineTo(arrowP2.dx, arrowP2.dy)
      ..close();
      
    canvas.drawPath(arrowPath, paint..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}