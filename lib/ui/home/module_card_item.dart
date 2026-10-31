import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/models/module_item.dart';

/// Clean, modern CardView item for each module in the dashboard grid
class ModuleCardItem extends StatelessWidget {
  final ModuleItem item;

  const ModuleCardItem({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final itemColor = item.color ?? colorScheme.primary;

    return Card(
      margin: EdgeInsets.zero,
      elevation: 2.5,
      shadowColor: itemColor.withValues(alpha: isDark ? 0.25 : 0.12),
      color: isDark ? colorScheme.surface : Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: colorScheme.outline.withValues(
            alpha: isDark ? 0.22 : 0.12,
          ),
          width: 1.2,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: itemColor.withValues(alpha: 0.14),
        highlightColor: itemColor.withValues(alpha: 0.06),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                itemColor.withValues(alpha: isDark ? 0.08 : 0.035),
                Colors.transparent,
              ],
            ),
          ),
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Top Row: Squircle Icon Container and Action Arrow Button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon Squircle with soft dual-tone gradient
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          itemColor.withValues(alpha: isDark ? 0.28 : 0.16),
                          itemColor.withValues(alpha: isDark ? 0.14 : 0.07),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(13),
                      border: Border.all(
                        color: itemColor.withValues(
                          alpha: isDark ? 0.35 : 0.22,
                        ),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      item.icon,
                      color: itemColor,
                      size: 23,
                    ),
                  ),

                  // Mini outward arrow action indicator
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: itemColor.withValues(
                        alpha: isDark ? 0.16 : 0.08,
                      ),
                    ),
                    child: Icon(
                      Icons.arrow_outward_rounded,
                      size: 15,
                      color: itemColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Bottom Section: Module Title, optional Subtitle & Accent Bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontSize: 13.5,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.onSurface,
                      height: 1.25,
                      letterSpacing: -0.2,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (item.subtitle != null) ...[
                    const SizedBox(height: 3),
                    Text(
                      item.subtitle!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Micro accent indicator capsule
                  Container(
                    width: 24,
                    height: 3,
                    decoration: BoxDecoration(
                      color: itemColor.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
