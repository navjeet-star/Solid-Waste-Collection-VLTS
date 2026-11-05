import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/decoration/common_decorations.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';

/// A specialized, modern statistic card designed specifically for vehicle fleet types.
/// Displays an icon badge, prominent count, vehicle label, and accent indicator.
class VehicleStatCard extends StatelessWidget {
  /// The vehicle count / metric (e.g. "623", "3", "20")
  final String value;

  /// The vehicle type label (e.g. "D2D Tipper", "Tractor", "Others")
  final String title;

  /// Optional vehicle icon (e.g. Icons.local_shipping_rounded, Icons.agriculture_rounded)
  final IconData? icon;

  /// Accent color for the icon badge and bottom indicator bar
  final Color? accentColor;

  /// Optional tap callback
  final VoidCallback? onTap;

  /// Optional custom padding
  final EdgeInsetsGeometry padding;

  const VehicleStatCard({
    super.key,
    required this.value,
    required this.title,
    this.icon,
    this.accentColor,
    this.onTap,
    this.padding = const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveAccent = accentColor ?? colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Card(
        margin: const EdgeInsets.all(2),
        elevation: 2,
        color: colorScheme.cardBg,
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
            child: Padding(
              padding: padding,
              child: Column(
                children: [
                  // Top Micro Icon Badge (if icon provided)
                  Container(
                    width: 32,
                    height: 32,
                    alignment: Alignment.center,
                    decoration: CommonDecoration.tintedBadge(effectiveAccent),
                    child: Icon(icon, size: 17, color: effectiveAccent),
                  ),
                  const SizedBox(height: 6),

                  // Prominent Count Number
                  Text(
                    value,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: colorScheme.textTitle,
                    ),
                  ),

                  const SizedBox(height: 4),

                  // Vehicle Type Label (Locked to 2-line vertical space for perfect alignment)
                  Center(
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.textDesc,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
