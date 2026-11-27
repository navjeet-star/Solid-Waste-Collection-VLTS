import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';

/// Reusable empty state view displayed when lists or queries return no results.
/// Automatically localizes "No data found" in English ("No data found")
/// and Hindi ("कोई डेटा नहीं मिला").
class CommonEmptyView extends StatelessWidget {
  /// Main headline/title text. Defaults to localized "No data found" (or "कोई डेटा नहीं मिला").
  final String? title;

  /// Optional secondary description/guidance text below the title.
  final String? subtitle;

  /// Icon to display above the title. Defaults to [Icons.search_off_rounded].
  final IconData icon;

  /// Size of the icon. Defaults to 48.0.
  final double iconSize;

  /// Optional custom icon color. Defaults to `colorScheme.onSurfaceVariant` with 60% opacity.
  final Color? iconColor;

  /// Padding around the content. Defaults to `const EdgeInsets.all(24.0)`.
  final EdgeInsetsGeometry padding;

  /// Optional action button or widget rendered below the texts (e.g., Reset Filters / Retry).
  final Widget? action;

  const CommonEmptyView({
    super.key,
    this.title,
    this.subtitle,
    this.icon = Icons.search_off_rounded,
    this.iconSize = 48.0,
    this.iconColor,
    this.padding = const EdgeInsets.all(24.0),
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final effectiveTitle = title ?? strings.noDataFound;
    final effectiveIconColor = iconColor ??
        colorScheme.onSurfaceVariant.withValues(alpha: 0.6);

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: iconSize,
              color: effectiveIconColor,
            ),
            const SizedBox(height: 12),
            Text(
              effectiveTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                subtitle!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.normal,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (action != null) ...[
              const SizedBox(height: 16),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Backwards compatibility and alternative naming aliases
typedef CommonNoDataFound = CommonEmptyView;
typedef CommonNoDataView = CommonEmptyView;
