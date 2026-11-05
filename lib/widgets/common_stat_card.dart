import 'package:flutter/material.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';

/// A reusable statistic / metric card displaying an accent top stripe,
/// a prominent value/count, and a descriptive label below.
class CommonStatCard extends StatelessWidget {
  /// The main prominent number or text (e.g. "921", "1,184", "98.5%")
  final String value;

  /// The label or subtitle below the value (e.g. "Driver", "Total Wards")
  final String title;

  /// The accent color for the top stripe indicator (defaults to primary color)
  final Color? accentColor;

  /// Optional tap callback
  final VoidCallback? onTap;

  /// Optional fixed width (if null, fits parent or uses flex)
  final double? width;

  /// Optional fixed height
  final double? height;

  /// Optional background color (defaults to surface)
  final Color? backgroundColor;

  /// Custom inner padding
  final EdgeInsetsGeometry padding;

  const CommonStatCard({
    super.key,
    required this.value,
    required this.title,
    this.accentColor,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 2, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveAccent = accentColor ?? colorScheme.primary;

    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.all(1),
      child: Card(
        elevation: 1,
        color: colorScheme.cardBg,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            child: Column(
              children: [
                // Card content
                Padding(
                  padding: padding,
                  child: Column(
                    children: [
                      Text(
                        value,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.textTitle),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 36,
                        child: Center(
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.25,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.textDesc,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Top colored accent indicator bar
                Container(
                  height: 3.5,
                  width: 18,
                  color: effectiveAccent,
                ),

                SizedBox(height: 5)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

