import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? iconColor;
  final Color? fontColor;

  const CommonText({
    super.key,
    required this.text,
    this.prefixIcon,
    this.fontSize,
    this.fontWeight,
    this.iconColor,
    this.fontColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        if (prefixIcon != null) ...[
          Icon(
            prefixIcon,
            size: 16,
            color: iconColor ?? colorScheme.primary,
          ),
          const SizedBox(width: 6),
        ],
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 13,
            fontWeight: fontWeight ?? FontWeight.w700,
            color: fontColor ?? colorScheme.onSurface,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}
