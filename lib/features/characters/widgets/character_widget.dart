import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';

class CharacterWidget extends StatefulWidget {
  final String characterId;
  final double size;
  final bool showSpeechBubble;
  final String? speechText;
  final bool isAnimated;

  const CharacterWidget({
    super.key,
    required this.characterId,
    this.size = 100.0,
    this.showSpeechBubble = false,
    this.speechText,
    this.isAnimated = true,
  });

  @override
  State<CharacterWidget> createState() => _CharacterWidgetState();
}

class _CharacterWidgetState extends State<CharacterWidget>
    with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late AnimationController _bounceController;
  
  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    
    _bounceController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    
    if (widget.isAnimated) {
      _startAnimations();
    }
  }

  void _startAnimations() {
    // Random blinking
    _blinkRandomly();
    
    // Gentle bouncing
    _bounceController.repeat(reverse: true);
  }

  void _blinkRandomly() {
    Future.delayed(Duration(milliseconds: 2000 + (1000 * (0.5 + 0.5 * 1.0)).round()), () {
      if (mounted) {
        _blinkController.forward().then((_) {
          _blinkController.reverse().then((_) {
            if (mounted) {
              _blinkRandomly();
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _blinkController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Speech bubble
        if (widget.showSpeechBubble && widget.speechText != null)
          _buildSpeechBubble(),
        
        // Character
        AnimatedBuilder(
          animation: widget.isAnimated ? _bounceController : const AlwaysStoppedAnimation(0),
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, widget.isAnimated ? 5 * _bounceController.value : 0),
              child: _buildCharacter(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSpeechBubble() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      constraints: const BoxConstraints(maxWidth: 250),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.speechText!,
            style: const TextStyle(
              fontSize: 14,
              color: AppConstants.textPrimaryColor,
            ),
            textAlign: TextAlign.center,
          ),
          // Speech bubble tail
          Transform.translate(
            offset: const Offset(0, 8),
            child: Transform.rotate(
              angle: 0.785398, // 45 degrees
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 500.ms).slideY(begin: -0.3);
  }

  Widget _buildCharacter() {
    return Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _getCharacterGradient(),
        boxShadow: [
          BoxShadow(
            color: _getCharacterGradient().colors.first.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Character base
          Center(
            child: Container(
              width: widget.size * 0.8,
              height: widget.size * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: _getCharacterGradient().colors.first,
                  width: 3,
                ),
              ),
              child: _buildCharacterFace(),
            ),
          ),
          
          // Character accessories (helmet, cape, etc.)
          if (widget.characterId == 'digiBuddy')
            _buildDigiBuddyAccessories(),
        ],
      ),
    );
  }

  Widget _buildCharacterFace() {
    return Stack(
      children: [
        // Eyes
        Positioned(
          top: widget.size * 0.25,
          left: widget.size * 0.2,
          child: _buildEye(),
        ),
        Positioned(
          top: widget.size * 0.25,
          right: widget.size * 0.2,
          child: _buildEye(),
        ),
        
        // Mouth
        Positioned(
          bottom: widget.size * 0.25,
          left: widget.size * 0.3,
          right: widget.size * 0.3,
          child: Container(
            height: 4,
            decoration: BoxDecoration(
              color: AppConstants.textPrimaryColor,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
        
        // Cheeks
        Positioned(
          top: widget.size * 0.35,
          left: widget.size * 0.15,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppConstants.accentColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          top: widget.size * 0.35,
          right: widget.size * 0.15,
          child: Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppConstants.accentColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEye() {
    return AnimatedBuilder(
      animation: _blinkController,
      builder: (context, child) {
        return Container(
          width: 8,
          height: _blinkController.value == 0 ? 8 : 2,
          decoration: BoxDecoration(
            color: AppConstants.textPrimaryColor,
            borderRadius: BorderRadius.circular(_blinkController.value == 0 ? 4 : 1),
          ),
        );
      },
    );
  }

  Widget _buildDigiBuddyAccessories() {
    return Stack(
      children: [
        // Helmet/cap
        Positioned(
          top: 0,
          left: widget.size * 0.1,
          right: widget.size * 0.1,
          child: Container(
            height: widget.size * 0.3,
            decoration: BoxDecoration(
              color: AppConstants.primaryColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.shield,
                color: Colors.white,
                size: widget.size * 0.15,
              ),
            ),
          ),
        ),
        
        // Cape
        Positioned(
          top: widget.size * 0.6,
          left: widget.size * 0.05,
          child: Transform.rotate(
            angle: -0.3,
            child: Container(
              width: widget.size * 0.2,
              height: widget.size * 0.4,
              decoration: BoxDecoration(
                color: AppConstants.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        Positioned(
          top: widget.size * 0.6,
          right: widget.size * 0.05,
          child: Transform.rotate(
            angle: 0.3,
            child: Container(
              width: widget.size * 0.2,
              height: widget.size * 0.4,
              decoration: BoxDecoration(
                color: AppConstants.accentColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  LinearGradient _getCharacterGradient() {
    switch (widget.characterId) {
      case 'digiBuddy':
        return const LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
        );
      case 'cyberPal':
        return const LinearGradient(
          colors: [AppConstants.secondaryColor, AppConstants.warningColor],
        );
      case 'safeBot':
        return const LinearGradient(
          colors: [AppConstants.warningColor, AppConstants.accentColor],
        );
      default:
        return const LinearGradient(
          colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
        );
    }
  }
}