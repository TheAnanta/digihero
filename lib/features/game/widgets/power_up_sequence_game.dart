import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PowerUpSequenceGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const PowerUpSequenceGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<PowerUpSequenceGame> createState() => _PowerUpSequenceGameState();
}

class _PowerUpSequenceGameState extends State<PowerUpSequenceGame>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  List<String> availableSteps = [];
  List<String?> orderedSteps = [];
  List<int> correctOrder = [];
  String? draggedStep;
  bool isComplete = false;
  bool showResult = false;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _initializeSteps();
  }

  void _initializeSteps() {
    correctOrder =
        List<int>.from(widget.gameData['correctOrder'] ?? [0, 1, 2, 3]);
    // Get steps from the parent challenge options if not in gameData
    final steps = widget.gameData['steps'] ?? widget.gameData['options'] ?? [];

    // Convert steps to list of strings
    availableSteps = List<String>.from(steps)..shuffle();
    orderedSteps = List.filled(availableSteps.length, null);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  void _onStepPlaced(String step, int position) {
    setState(() {
      // Remove step from available steps
      availableSteps.remove(step);

      // If there was already a step in this position, move it back to available
      if (orderedSteps[position] != null) {
        availableSteps.add(orderedSteps[position]!);
      }

      // Place the new step
      orderedSteps[position] = step;

      draggedStep = null;
    });

    // Check if all slots are filled
    if (!orderedSteps.contains(null)) {
      _enableCheckButton();
    }
  }

  void _enableCheckButton() {
    // Add a small delay before enabling check to prevent accidental clicks
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        // Check button is now ready
      });
    });
  }

  void _checkSequence() {
    final allSteps = List<String>.from(widget.gameData['steps'] ?? []);
    bool isCorrect = true;

    for (int i = 0; i < correctOrder.length; i++) {
      if (orderedSteps[i] != allSteps[correctOrder[i]]) {
        isCorrect = false;
        break;
      }
    }

    setState(() {
      isComplete = isCorrect;
      showResult = true;
    });

    if (isCorrect) {
      _showSuccess();
    } else {
      _showError();
    }
  }

  void _showSuccess() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      widget.onComplete(true, 100);
    });
  }

  void _showError() {
    // Show error animation and reset after a delay
    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        showResult = false;
        // Reset the game
        availableSteps.clear();
        orderedSteps.clear();
        _initializeSteps();
      });
    });
  }

  Widget _buildDraggableStep(String step) {
    return Draggable<String>(
      data: step,
      onDragStarted: () {
        setState(() {
          draggedStep = step;
        });
      },
      onDragEnd: (details) {
        setState(() {
          draggedStep = null;
        });
      },
      feedback: Material(
        color: Colors.transparent,
        child: _buildStepCard(step, isDragging: true),
      ),
      childWhenDragging: Container(
        width: 160,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.5), width: 2),
        ),
      ),
      child: _buildStepCard(step),
    );
  }

  Widget _buildStepCard(String step, {bool isDragging = false}) {
    return Container(
      width: 160,
      height: 80,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDragging ? Colors.orange[300] : Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.orange[600]!,
          width: 2,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.5),
                  blurRadius: 12,
                  spreadRadius: 4,
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: Center(
        child: Text(
          step,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.orange[800],
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildDropSlot(int index) {
    final isEmpty = orderedSteps[index] == null;
    final isHighlighted = draggedStep != null && isEmpty;

    return DragTarget<String>(
      onAccept: (step) => _onStepPlaced(step, index),
      builder: (context, candidateData, rejectedData) {
        return Container(
          width: 180,
          height: 100,
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isEmpty
                ? (isHighlighted
                    ? Colors.blue.withOpacity(0.3)
                    : Colors.grey[200])
                : Colors.green[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isEmpty
                  ? (isHighlighted ? Colors.blue : Colors.grey[400]!)
                  : Colors.green,
              width: isEmpty ? 1 : 3,
            ),
          ),
          child: Stack(
            children: [
              // Step number
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),

              // Content
              if (orderedSteps[index] != null)
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 40, 8, 8),
                    child: Text(
                      orderedSteps[index]!,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.green[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              else
                const Center(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(8, 40, 8, 8),
                    child: Text(
                      'Drop step here',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResultOverlay() {
    if (!showResult) return const SizedBox.shrink();

    return Positioned.fill(
      child: Container(
        color: isComplete
            ? Colors.green.withOpacity(0.9)
            : Colors.red.withOpacity(0.9),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isComplete ? Icons.check_circle : Icons.error,
                size: 100,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              Text(
                isComplete ? 'Perfect Sequence!' : 'Not quite right...',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                isComplete
                    ? 'You got the power-on sequence exactly right!'
                    : 'Try again - check the correct order of steps.',
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

  @override
  Widget build(BuildContext context) {
    final canCheck = !orderedSteps.contains(null);

    return Container(
      width: double.infinity,
      height: 600,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.orange[50]!,
            Colors.orange[100]!,
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
                        'Arrange the steps in the right order',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.orange,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 30),

                // Available steps
                if (availableSteps.isNotEmpty) ...[
                  const Text(
                    'Available Steps:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: availableSteps
                        .map((step) => _buildDraggableStep(step))
                        .toList(),
                  ),
                  const SizedBox(height: 30),
                ],

                // Drop slots
                const Text(
                  'Correct Order:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 15),

                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 5,
                  runSpacing: 5,
                  children: List.generate(
                    orderedSteps.length,
                    (index) => _buildDropSlot(index),
                  ),
                ),

                const SizedBox(height: 30),

                // Check button
                ElevatedButton(
                  onPressed: canCheck ? _checkSequence : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: canCheck ? Colors.green : Colors.grey,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Check Sequence',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: canCheck ? Colors.white : Colors.grey[600],
                    ),
                  ),
                )
                    .animate(target: canCheck ? 1 : 0)
                    .scale(
                        begin: const Offset(0.9, 0.9),
                        end: const Offset(1.0, 1.0))
                    .then()
                    .shimmer(
                        duration: 1000.ms,
                        color: Colors.white.withOpacity(0.5)),
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
