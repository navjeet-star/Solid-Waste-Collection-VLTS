import 'package:flutter/material.dart';

/// A reusable, theme-aware Date Picker component.
/// Provides an interactive tap-to-pick field with custom styling,
/// height, border, prefix/suffix icons, date range limits, and formatting.
class CommonDatePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final String? hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final double height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool enabled;
  final String Function(DateTime)? dateFormatter;

  const CommonDatePicker({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.firstDate,
    this.lastDate,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon = Icons.calendar_month_rounded,
    this.height = 48.0,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
    this.enabled = true,
    this.dateFormatter,
  });

  /// Static helper method to trigger the system [showDatePicker] dialog directly
  static Future<DateTime?> pickDate(
    BuildContext context, {
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final now = DateTime.now();
    return showDatePicker(
      context: context,
      initialDate: initialDate ?? now,
      firstDate: firstDate ?? DateTime(2020),
      lastDate: lastDate ?? DateTime(2035),
    );
  }

  /// Default date format YYYY-MM-DD
  static String defaultFormat(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Future<void> _handleTap(BuildContext context) async {
    if (!enabled || onDateSelected == null) return;

    final picked = await pickDate(
      context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (picked != null) {
      onDateSelected!(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12);

    final displayText = selectedDate != null
        ? (dateFormatter != null
            ? dateFormatter!(selectedDate!)
            : defaultFormat(selectedDate!))
        : (hintText ?? 'Select Date');

    final isPlaceholder = selectedDate == null;

    return InkWell(
      onTap: enabled ? () => _handleTap(context) : null,
      borderRadius: effectiveRadius,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: backgroundColor ?? colorScheme.surface,
          borderRadius: effectiveRadius,
          border: Border.all(
            color: borderColor ?? colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (prefixIcon != null) ...[
              Icon(
                prefixIcon,
                size: 18,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                displayText,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isPlaceholder
                      ? colorScheme.onSurfaceVariant.withValues(alpha: 0.7)
                      : colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (suffixIcon != null) ...[
              const SizedBox(width: 4),
              Icon(
                suffixIcon,
                size: 18,
                color: enabled
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
