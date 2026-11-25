import 'package:flutter/material.dart';


class CommonSimpleDropdown<T> extends StatelessWidget {
  final T? value;

  final List<T> items;

  final ValueChanged<T?> onChanged;

  final String Function(T item)? itemLabelBuilder;

  final String? hintText;

  final IconData? prefixIcon;

  final double height;

  /// Border radius of the container (defaults to 12.0).
  final BorderRadius? borderRadius;

  /// Custom background color.
  final Color? backgroundColor;

  /// Custom border color.
  final Color? borderColor;

  /// Custom text style for the selected item and menu items.

  const CommonSimpleDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
    this.hintText,
    this.prefixIcon,
    this.height = 42.0,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });

  String _getLabel(T item) {
    if (itemLabelBuilder != null) {
      return itemLabelBuilder!(item);
    }
    return item.toString();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12);

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: effectiveRadius,
        border: Border.all(
          color: borderColor ?? colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          hint: hintText != null
              ? Row(
                  children: [
                    if (prefixIcon != null) ...[
                      Icon(
                        prefixIcon,
                        size: 18,
                        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Expanded(
                      child: Text(
                        hintText!,
                        style: TextStyle(
                          fontSize: 13,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : null,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colorScheme.onSurfaceVariant,
            size: 20,
          ),
          dropdownColor: colorScheme.surface,
          borderRadius: effectiveRadius,
          style: TextStyle(
                fontSize: 13,
                color: colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
          items: items.map((item) {
            final label = _getLabel(item);
            return DropdownMenuItem<T>(
              value: item,
              child: Row(
                children: [
                  if (prefixIcon != null) ...[
                    Icon(
                      prefixIcon,
                      size: 16,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: Text(
                      label,
                      style: TextStyle(
                            fontSize: 13,
                            color: colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
                          ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
