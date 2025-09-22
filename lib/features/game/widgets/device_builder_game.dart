import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;

class DeviceBuilderGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const DeviceBuilderGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<DeviceBuilderGame> createState() => _DeviceBuilderGameState();
}

class _DeviceBuilderGameState extends State<DeviceBuilderGame>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  Map<String, bool> placedLabels = {};
  Map<String, Offset> labelPositions = {};
  String? draggedLabel;
  bool isGameComplete = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();

    // Initialize label positions
    final parts = List<String>.from(widget.gameData['parts'] ?? []);
    for (int i = 0; i < parts.length; i++) {
      labelPositions[parts[i]] = Offset(50.0 + (i * 120.0), 500.0);
      placedLabels[parts[i]] = false;
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  void _onLabelDragged(String label, Offset position) {
    setState(() {
      labelPositions[label] = position;
      draggedLabel = null;
    });
  }

  void _onTargetZoneHit(String label, String targetId) {
    if (label == targetId) {
      // Correct placement
      setState(() {
        placedLabels[label] = true;
      });
      
      // Check if game is complete
      if (placedLabels.values.every((placed) => placed)) {
        _completeGame();
      }
    } else {
      // Incorrect placement - bounce back
      _bounceBack(label);
    }
  }

  void _bounceBack(String label) {
    setState(() {
      // Reset to original position with bounce animation
      final parts = List<String>.from(widget.gameData['parts'] ?? []);
      final index = parts.indexOf(label);
      labelPositions[label] = Offset(50.0 + (index * 120.0), 500.0);
    });
  }

  void _completeGame() {
    setState(() {
      isGameComplete = true;
    });
    
    Future.delayed(const Duration(milliseconds: 500), () {
      widget.onComplete(true, 100);
    });
  }

  Widget _buildDeviceImage() {
    final deviceType = widget.gameData['deviceType'] ?? 'computer';
    
    return Container(
      width: 400,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!, width: 2),
      ),
      child: Stack(
        children: [
          // Device image placeholder
          Center(
            child: Icon(
              deviceType == 'computer' ? Icons.computer : Icons.phone_android,
              size: 150,
              color: Colors.grey[600],
            ),
          ),
          
          // Target zones for device parts
          ..._buildTargetZones(),
        ],
      ),
    );
  }

  List<Widget> _buildTargetZones() {
    final parts = List<String>.from(widget.gameData['parts'] ?? []);
    final deviceType = widget.gameData['deviceType'] ?? 'computer';
    
    if (deviceType == 'computer') {
      return [
        // Monitor target zone
        _buildTargetZone('Monitor', const Offset(150, 50), 100, 60),
        // CPU target zone
        _buildTargetZone('CPU', const Offset(300, 150), 80, 100),
        // Keyboard target zone
        _buildTargetZone('Keyboard', const Offset(120, 220), 160, 40),
        // Mouse target zone
        _buildTargetZone('Mouse', const Offset(50, 180), 60, 40),
      ];
    }
    
    return [];
  }

  Widget _buildTargetZone(String targetId, Offset position, double width, double height) {
    final isHighlighted = draggedLabel != null && !placedLabels[draggedLabel]!;
    final isOccupied = placedLabels[targetId] == true;
    
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: DragTarget<String>(
        onAccept: (label) => _onTargetZoneHit(label, targetId),
        builder: (context, candidateData, rejectedData) {
          return Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: isOccupied 
                  ? Colors.green.withOpacity(0.3)
                  : isHighlighted 
                      ? Colors.blue.withOpacity(0.3)
                      : Colors.transparent,
              border: Border.all(
                color: isHighlighted ? Colors.blue : Colors.grey.withOpacity(0.5),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: isOccupied
                ? Center(
                    child: Text(
                      targetId,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                        fontSize: 12,
                      ),
                    ),
                  )
                : null,
          );
        },
      ),
    );
  }

  Widget _buildDraggableLabel(String label) {
    final isPlaced = placedLabels[label] == true;
    if (isPlaced) return const SizedBox.shrink();
    
    return Positioned(
      left: labelPositions[label]!.dx,
      top: labelPositions[label]!.dy,
      child: Draggable<String>(
        data: label,
        onDragStarted: () {
          setState(() {
            draggedLabel = label;
          });
        },
        onDragEnd: (details) {
          setState(() {
            draggedLabel = null;
          });
        },
        feedback: Material(
          color: Colors.transparent,
          child: _buildLabelChip(label, isDragging: true),
        ),
        childWhenDragging: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey, style: BorderStyle.solid),
          ),
        ),
        child: _buildLabelChip(label),
      ),
    );
  }

  Widget _buildLabelChip(String label, {bool isDragging = false}) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        color: isDragging ? Colors.blue[300] : Colors.blue[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.blue, width: 2),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue[800],
            fontSize: 12,
          ),
        ),
      ),
    ).animate().scale(
      duration: 200.ms,
      begin: const Offset(1.0, 1.0),
      end: isDragging ? const Offset(1.1, 1.1) : const Offset(1.0, 1.0),
    );
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
          // Instructions
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: Container(
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
                'Drag each label to the matching part of the device',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          // Device image with target zones
          Positioned(
            top: 100,
            left: (MediaQuery.of(context).size.width - 400) / 2,
            child: _buildDeviceImage(),
          ),

          // Draggable labels
          ...labelPositions.keys.map((label) => _buildDraggableLabel(label)),

          // Success celebration
          if (isGameComplete)
            Positioned.fill(
              child: Container(
                color: Colors.green.withOpacity(0.8),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.celebration,
                        size: 80,
                        color: Colors.white,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Excellent Work!',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'All device parts identified correctly!',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ).animate().fadeIn(duration: 500.ms).scale(
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                  duration: 500.ms,
                ),
        ],
      ),
    );
  }
}