import 'package:flutter/material.dart';

class CommonDecoration {
  CommonDecoration._();


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



