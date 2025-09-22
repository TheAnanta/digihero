import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_constants.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final double progress;
  final String label;
  final Color? progressColor;
  final Color? backgroundColor;
  final double height;
  final bool showPercentage;

  const ProgressIndicatorWidget({
    super.key,
    required this.progress,
    required this.label,
    this.progressColor,
    this.backgroundColor,
    this.height = 8.0,
    this.showPercentage = true,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);
    final percentage = (clampedProgress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (showPercentage)
              Text(
                '$percentage%',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          height: height,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(height / 2),
          ),
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: height,
                decoration: BoxDecoration(
                  color: backgroundColor ?? Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(height / 2),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                curve: Curves.easeOutCubic,
                width: MediaQuery.of(context).size.width * 0.7 * clampedProgress,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      progressColor ?? AppConstants.secondaryColor,
                      progressColor ?? AppConstants.primaryColor,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(height / 2),
                  boxShadow: [
                    BoxShadow(
                      color: (progressColor ?? AppConstants.primaryColor).withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CircularProgressWidget extends StatelessWidget {
  final double progress;
  final double size;
  final Color? progressColor;
  final Color? backgroundColor;
  final double strokeWidth;
  final Widget? child;

  const CircularProgressWidget({
    super.key,
    required this.progress,
    this.size = 100.0,
    this.progressColor,
    this.backgroundColor,
    this.strokeWidth = 8.0,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final clampedProgress = progress.clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        children: [
          // Background circle
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: 1.0,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                backgroundColor ?? Colors.grey.withOpacity(0.2),
              ),
            ),
          ),
          // Progress circle
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: clampedProgress,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                progressColor ?? AppConstants.primaryColor,
              ),
            ),
          ).animate().scale(
            duration: 800.ms,
            curve: Curves.easeOutBack,
          ),
          // Center content
          if (child != null)
            Center(child: child!),
        ],
      ),
    );
  }
}

class StarsWidget extends StatelessWidget {
  final int totalStars;
  final int filledStars;
  final double size;
  final Color? filledColor;
  final Color? emptyColor;

  const StarsWidget({
    super.key,
    required this.totalStars,
    required this.filledStars,
    this.size = 24.0,
    this.filledColor,
    this.emptyColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(totalStars, (index) {
        final isFilled = index < filledStars;
        return Icon(
          isFilled ? Icons.star : Icons.star_border,
          color: isFilled 
              ? (filledColor ?? AppConstants.warningColor)
              : (emptyColor ?? Colors.grey.withOpacity(0.5)),
          size: size,
        ).animate(delay: (index * 100).ms).fadeIn().scale();
      }),
    );
  }
}

class GameCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final List<BoxShadow>? boxShadow;
  final BorderRadius? borderRadius;

  const GameCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.boxShadow,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(16),
      margin: margin ?? const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        boxShadow: boxShadow ?? [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}