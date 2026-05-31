import 'dart:ui';
import 'package:flutter/material.dart';

/// A reusable glassmorphic container that applies a frosted-glass blur effect.
/// Highly customizable to match any layout styling.
class GlassContainer extends StatelessWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final double blurX;
  final double blurY;
  final Color backgroundColor;
  final Border? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final AlignmentGeometry? alignment;
  final List<BoxShadow>? boxShadow;
  final Widget child;

  const GlassContainer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 24.0,
    this.blurX = 16.0,
    this.blurY = 16.0,
    this.backgroundColor = const Color(0x1AFFFFFF), // white with ~10% opacity
    this.border,
    this.padding,
    this.margin,
    this.alignment,
    this.boxShadow,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurX, sigmaY: blurY),
          child: Container(
            width: width,
            height: height,
            padding: padding,
            alignment: alignment,
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border ?? Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 1.0,
              ),
              boxShadow: boxShadow,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
