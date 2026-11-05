import 'package:flutter/material.dart';

/// Reusable BoxDecorations for badges, pills, cards, and highlighted containers
class CommonDecoration {
  CommonDecoration._();

  /// Creates a tinted badge/pill [BoxDecoration] with a dynamic [baseColor],
  /// light background opacity, and a matching subtle border.
  ///
  /// Example:
  /// ```dart
  /// decoration: CommonDecoration.tintedBadge(colorScheme.primary),
  /// ```
  static BoxDecoration tintedBadge(
    Color baseColor, {
    double borderRadius = 8.0,
    double bgAlpha = 0.08,
    double borderAlpha = 0.2,
    double borderWidth = 0.8,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return BoxDecoration(
      color: baseColor.withValues(alpha: bgAlpha),
      shape: shape,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: baseColor.withValues(alpha: borderAlpha),
        width: borderWidth,
      ),
    );
  }
}

/// Fluent extension to easily create tinted [BoxDecoration] directly on any [Color]
///
/// Example:
/// ```dart
/// decoration: colorScheme.primary.toTintedBadge(),
/// decoration: itemColor.toTintedBadge(borderRadius: 12),
/// ```
extension TintedDecorationExtension on Color {
  BoxDecoration toTintedBadge({
    double borderRadius = 8.0,
    double bgAlpha = 0.12,
    double borderAlpha = 0.25,
    double borderWidth = 0.8,
    BoxShape shape = BoxShape.rectangle,
  }) {
    return CommonDecoration.tintedBadge(
      this,
      borderRadius: borderRadius,
      bgAlpha: bgAlpha,
      borderAlpha: borderAlpha,
      borderWidth: borderWidth,
      shape: shape,
    );
  }
}

