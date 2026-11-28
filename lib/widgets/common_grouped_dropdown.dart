import 'package:flutter/material.dart';

/// Represents an item in a [CommonGroupedDropdown].
/// Can be either an unselectable category header ([isHeader] = true)
/// or a selectable option item ([isHeader] = false).
class GroupedDropdownItem<T> {
  final T? value;
  final String label;
  final String? groupTitle;
  final bool isHeader;
  final IconData? icon;

  const GroupedDropdownItem({
    required this.label,
    this.value,
    this.groupTitle,
    this.isHeader = false,
    this.icon,
  });

  /// Factory constructor for a non-selectable category header.
  factory GroupedDropdownItem.header(
    String title, {
    IconData? icon,
  }) =>
      GroupedDropdownItem(
        label: title,
        groupTitle: title,
        isHeader: true,
        icon: icon,
      );

  /// Factory constructor for a selectable option inside a group.
  factory GroupedDropdownItem.option({
    required T value,
    required String label,
    String? groupTitle,
    IconData? icon,
  }) =>
      GroupedDropdownItem(
        value: value,
        label: label,
        groupTitle: groupTitle,
        isHeader: false,
        icon: icon,
      );
}

/// A responsive, reusable grouped dropdown component.
/// Visually distinguishes category headers from selectable options,
/// indents grouped children, and displays category context when closed.
class CommonGroupedDropdown<T> extends StatelessWidget {
  final T? value;
  final List<GroupedDropdownItem<T>> items;
  final ValueChanged<T?>? onChanged;
  final String? hintText;
  final IconData? prefixIcon;
  final double height;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final Color? borderColor;

  const CommonGroupedDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText,
    this.prefixIcon,
    this.height = 48.0,
    this.borderRadius,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final effectiveRadius = borderRadius ?? BorderRadius.circular(12);

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        borderRadius: effectiveRadius,
        border: Border.all(
          color: borderColor ?? colorScheme.outline.withValues(alpha: 0.25),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: value,
          isExpanded: true,
          dropdownColor: colorScheme.surface,
          borderRadius: effectiveRadius,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: colorScheme.onSurfaceVariant,
            size: 22,
          ),
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
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                )
              : null,
          // Custom closed-box display: shows both Category + Option label
          selectedItemBuilder: (context) {
            return items.map((item) {
              final displayText = item.groupTitle != null && item.groupTitle != item.label
                  ? '${item.groupTitle}: ${item.label}'
                  : item.label;

              return Row(
                children: [
                  Expanded(
                    child: Text(
                      displayText,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              );
            }).toList();
          },
          items: items.map((item) {
            if (item.isHeader) {
              // ---------------- Non-selectable Category Header ----------------
              return DropdownMenuItem<T>(
                enabled: false,
                value: null,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      if (item.icon != null) ...[
                        Icon(
                          item.icon,
                          size: 15,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 6),
                      ],
                      Expanded(
                        child: Text(
                          item.label.toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.8,
                            color: colorScheme.primary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            // ---------------- Selectable Option Item ----------------
            final bool isSubOption = item.groupTitle != null;

            return DropdownMenuItem<T>(
              value: item.value,
              child: Padding(
                padding: EdgeInsets.only(left: isSubOption ? 16.0 : 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: item.value == value
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: item.value == value
                              ? colorScheme.primary
                              : colorScheme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
