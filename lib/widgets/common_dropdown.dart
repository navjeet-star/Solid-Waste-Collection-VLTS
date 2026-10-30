import 'package:flutter/material.dart';

/// Style variants for [CommonDropdown].
enum CommonDropdownVariant {
  solid,
  outline,
}

/// A clean, reusable dropdown form field with basic parameters supporting
/// solid and outline styles with [Theme.of(context).colorScheme].
class CommonDropdown<T> extends StatelessWidget {
  /// Creates a solid (filled background) dropdown.
  const CommonDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.isRequired = false,
  }) : variant = CommonDropdownVariant.solid;

  /// Explicit constructor for a solid (filled background) dropdown.
  const CommonDropdown.solid({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.isRequired = false,
  }) : variant = CommonDropdownVariant.solid;

  /// Creates an outline (transparent background with border) dropdown.
  const CommonDropdown.outline({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.isRequired = false,
  }) : variant = CommonDropdownVariant.outline;

  /// Alias for [CommonDropdown.outline].
  const CommonDropdown.outlined({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.itemLabelBuilder,
    this.label,
    this.hintText,
    this.prefixIcon,
    this.validator,
    this.enabled = true,
    this.isRequired = false,
  }) : variant = CommonDropdownVariant.outline;

  final T? value;
  final List<T> items;
  final ValueChanged<T?>? onChanged;
  final String Function(T item)? itemLabelBuilder;
  final String? label;
  final String? hintText;
  final Widget? prefixIcon;
  final FormFieldValidator<T>? validator;
  final bool enabled;
  final bool isRequired;
  final CommonDropdownVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderRadius = BorderRadius.circular(10.0);

    final isSolid = variant == CommonDropdownVariant.solid;

    final resolvedFillColor = isSolid
        ? (theme.inputDecorationTheme.fillColor ??
            colorScheme.surfaceContainerHighest.withValues(alpha: 0.3))
        : Colors.transparent;

    final dropdownItems = items.map((item) {
      final displayText = itemLabelBuilder != null
          ? itemLabelBuilder!(item)
          : item.toString();

      return DropdownMenuItem<T>(
        value: item,
        child: Text(
          displayText,
          style: TextStyle(
            fontSize: 15,
            color: colorScheme.onSurface,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      );
    }).toList();

    Widget? labelWidget;
    if (label != null) {
      if (isRequired) {
        labelWidget = RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 14,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: TextStyle(
                  color: colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      } else {
        labelWidget = Text(label!);
      }
    }

    return DropdownButtonFormField<T>(
      initialValue: value,
      items: dropdownItems,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      isExpanded: true,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: colorScheme.onSurfaceVariant,
      ),
      dropdownColor: colorScheme.surface,
      decoration: InputDecoration(
        label: labelWidget,
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: isSolid,
        fillColor: enabled
            ? resolvedFillColor
            : colorScheme.onSurface.withValues(alpha: 0.04),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: colorScheme.outline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: colorScheme.primary,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1.2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: colorScheme.error,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
