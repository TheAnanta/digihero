import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/utils/level_content_localizer.dart';
import 'dart:math' as math;

class SlideDesignerGame extends StatefulWidget {
  final Map<String, dynamic> gameData;
  final Function(bool isCorrect, int points) onComplete;

  const SlideDesignerGame({
    super.key,
    required this.gameData,
    required this.onComplete,
  });

  @override
  State<SlideDesignerGame> createState() => _SlideDesignerGameState();
}

class _SlideDesignerGameState extends State<SlideDesignerGame>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _successController;

  String task = '';
  Map<String, dynamic> requirements = {};
  List<String> availableTools = [];

  // Slide content
  String slideTitle = '';
  String slideSubtitle = '';
  Color backgroundColor = Colors.white;
  String selectedImage = '';
  bool hasTitle = false;
  bool hasSubtitle = false;
  bool hasBackground = false;
  bool hasImage = false;

  bool isComplete = false;
  List<String> completedRequirements = [];

  // UI controllers
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    _successController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _initializeGame();
  }

  void _initializeGame() {
    task = widget.gameData['task'] ?? 'create_title_slide';
    requirements =
        Map<String, dynamic>.from(widget.gameData['requirements'] ?? {});
    availableTools = List<String>.from(widget.gameData['tools'] ?? []);

    // Set default values based on requirements
    if (requirements['title'] != null) {
      slideTitle = requirements['title'];
      titleController.text = slideTitle;
      hasTitle = true;
    }
    if (requirements['subtitle'] != null) {
      slideSubtitle = requirements['subtitle'];
      subtitleController.text = slideSubtitle;
      hasSubtitle = true;
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    _successController.dispose();
    titleController.dispose();
    subtitleController.dispose();
    super.dispose();
  }

  void _addTitle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Title'),
        content: TextField(
          controller: titleController,
          decoration: const InputDecoration(
            hintText: 'Enter slide title',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                slideTitle = titleController.text;
                hasTitle = slideTitle.isNotEmpty;
                if (hasTitle) _checkRequirement('title');
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addSubtitle() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Subtitle'),
        content: TextField(
          controller: subtitleController,
          decoration: const InputDecoration(
            hintText: 'Enter slide subtitle',
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                slideSubtitle = subtitleController.text;
                hasSubtitle = slideSubtitle.isNotEmpty;
                if (hasSubtitle) _checkRequirement('subtitle');
              });
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  void _addImage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImageOption('flower', '🌸 Flower', Colors.pink),
            _buildImageOption('tree', '🌳 Tree', Colors.green),
            _buildImageOption('sun', '☀️ Sun', Colors.orange),
            _buildImageOption('mountain', '⛰️ Mountain', Colors.grey),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildImageOption(String imageId, String label, Color color) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label.split(' ')[0], // Just the emoji
            style: const TextStyle(fontSize: 24),
          ),
        ),
      ),
      title: Text(label),
      onTap: () {
        setState(() {
          selectedImage = imageId;
          hasImage = true;
          _checkRequirement('image');
        });
        Navigator.pop(context);
      },
    );
  }

  void _changeBackground() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Background'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildColorOption('White', Colors.white),
            _buildColorOption('Light Blue', Colors.blue[50]!),
            _buildColorOption('Light Green', Colors.green[50]!),
            _buildColorOption('Light Yellow', Colors.yellow[50]!),
            _buildColorOption('Light Pink', Colors.pink[50]!),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Widget _buildColorOption(String name, Color color) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
      ),
      title: Text(name),
      onTap: () {
        setState(() {
          backgroundColor = color;
          hasBackground = true;
          _checkRequirement('background');
        });
        Navigator.pop(context);
      },
    );
  }

  void _checkRequirement(String requirement) {
    if (!completedRequirements.contains(requirement)) {
      setState(() {
        completedRequirements.add(requirement);
      });

      // Check if all requirements are met
      _checkCompletion();
    }
  }

  void _checkCompletion() {
    final requiredTasks = requirements.keys.toList();
    bool allCompleted = true;

    for (String requirement in requiredTasks) {
      switch (requirement) {
        case 'title':
          if (!hasTitle || slideTitle.isEmpty) allCompleted = false;
          break;
        case 'subtitle':
          if (!hasSubtitle || slideSubtitle.isEmpty) allCompleted = false;
          break;
        case 'image_type':
          if (!hasImage) allCompleted = false;
          break;
        case 'background':
          if (!hasBackground) allCompleted = false;
          break;
      }
    }

    if (allCompleted && !isComplete) {
      setState(() {
        isComplete = true;
      });

      _successController.forward();

      Future.delayed(const Duration(milliseconds: 1500), () {
        widget.onComplete(true, 100);
      });
    }
  }

  Widget _buildSlidePreview() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background pattern
          if (hasBackground && backgroundColor != Colors.white)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      backgroundColor,
                      backgroundColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),

          // Title
          if (hasTitle && slideTitle.isNotEmpty)
            Positioned(
              top: 20,
              left: 20,
              right: 20,
              child: Text(
                slideTitle,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Subtitle
          if (hasSubtitle && slideSubtitle.isNotEmpty)
            Positioned(
              top: 50,
              left: 20,
              right: 20,
              child: Text(
                slideSubtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Image
          if (hasImage && selectedImage.isNotEmpty)
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: _getImageColor(selectedImage).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getImageColor(selectedImage)),
                ),
                child: Center(
                  child: Text(
                    _getImageEmoji(selectedImage),
                    style: const TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
        ],
      ),
    )
        .animate(target: isComplete ? 1 : 0)
        .shimmer(duration: 1000.ms, color: Colors.amber.withOpacity(0.3));
  }

  Widget _buildToolbox() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.build, color: Colors.purple),
              SizedBox(width: 8),
              Text(
                'Toolbox',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              if (availableTools.contains('text_box'))
                _buildToolButton(
                    'Add Title', Icons.title, Colors.blue, _addTitle),
              if (availableTools.contains('text_box'))
                _buildToolButton('Add Subtitle', Icons.subtitles, Colors.green,
                    _addSubtitle),
              if (availableTools.contains('image_gallery'))
                _buildToolButton(
                    'Add Picture', Icons.image, Colors.orange, _addImage),
              if (availableTools.contains('background_selector'))
                _buildToolButton('Background', Icons.color_lens, Colors.purple,
                    _changeBackground),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolButton(
      String label, IconData icon, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontSize: 12)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color.withOpacity(0.1),
        foregroundColor: color,
        elevation: 2,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildTaskChecklist() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.checklist, color: Colors.green),
              SizedBox(width: 8),
              Text(
                'Tasks',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...requirements.keys.map((req) => _buildTaskItem(req)),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String requirement) {
    bool completed = completedRequirements.contains(requirement);
    String taskName = _getTaskName(requirement);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            completed ? Icons.check_circle : Icons.radio_button_unchecked,
            color: completed ? Colors.green : Colors.grey,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(
            taskName,
            style: TextStyle(
              color: completed ? Colors.green : Colors.grey[700],
              fontWeight: completed ? FontWeight.w600 : FontWeight.normal,
              decoration: completed ? TextDecoration.lineThrough : null,
            ),
          ),
        ],
      ),
    )
        .animate(target: completed ? 1 : 0)
        .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.02, 1.02))
        .shimmer(duration: 500.ms, color: Colors.green.withOpacity(0.3));
  }

  String _getTaskName(String requirement) {
    switch (requirement) {
      case 'title':
        return 'Add a title';
      case 'subtitle':
        return 'Add a subtitle';
      case 'image_type':
        return 'Add an image';
      case 'background':
        return 'Choose background';
      default:
        return requirement;
    }
  }

  Color _getImageColor(String imageId) {
    switch (imageId) {
      case 'flower':
        return Colors.pink;
      case 'tree':
        return Colors.green;
      case 'sun':
        return Colors.orange;
      case 'mountain':
        return Colors.grey;
      default:
        return Colors.blue;
    }
  }

  String _getImageEmoji(String imageId) {
    switch (imageId) {
      case 'flower':
        return '🌸';
      case 'tree':
        return '🌳';
      case 'sun':
        return '☀️';
      case 'mountain':
        return '⛰️';
      default:
        return '🖼️';
    }
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
                Icons.slideshow,
                size: 100,
                color: Colors.white,
              )
                  .animate(controller: _successController)
                  .rotate(begin: 0, end: 0.5)
                  .scale(
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.2, 1.2)),
              const SizedBox(height: 20),
              const Text(
                'Slide Created!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'You\'ve designed a beautiful presentation slide!',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                'Great presentations communicate ideas clearly!',
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
            Colors.purple[50]!,
            Colors.purple[100]!,
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
                    LevelContentLocalizer.getLocalizedInstruction(
                        context,
                        widget.gameData['instructions'] ??
                            'Use the toolbox to design your slide!'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 20),

                // Main content
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left column - Tools and Tasks
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildToolbox(),
                            const SizedBox(height: 16),
                            _buildTaskChecklist(),
                          ],
                        ),
                      ),

                      const SizedBox(width: 20),

                      // Right column - Slide preview
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            const Text(
                              'Slide Preview',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            const SizedBox(height: 12),
                            _buildSlidePreview(),
                          ],
                        ),
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
