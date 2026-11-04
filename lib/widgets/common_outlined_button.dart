import 'package:flutter/material.dart';

class CommonOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final double height;
  final double? width;
  final Color? borderColor;
  final Color? textColor;

  const CommonOutlinedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.height = 52,
    this.width,
    this.borderColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isEnabled = onPressed != null;

    final effectiveTextColor = textColor ?? colorScheme.primary;
    final effectiveBorderColor = borderColor ??
        (isEnabled
            ? colorScheme.primary
            : colorScheme.outline.withValues(alpha: 0.25));

    Widget button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: effectiveTextColor,
        disabledForegroundColor:
            colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        minimumSize: Size(width ?? 0, height),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        side: BorderSide(color: effectiveBorderColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
        ],
      ),
    );

    if (width != null) {
      return SizedBox(
        width: width,
        height: height,
        child: button,
      );
    }

    return button;
  }
}

