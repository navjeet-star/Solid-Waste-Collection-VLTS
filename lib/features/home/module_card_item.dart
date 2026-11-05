import 'package:flutter/material.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/models/module_item.dart';

class ModuleCardItem extends StatelessWidget {
  final ModuleItem item;
  final String imagePath;

  const ModuleCardItem({super.key, required this.item, this.imagePath = ''});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final itemColor = item.color ?? colorScheme.primary;

    return Card(
      margin: const EdgeInsets.all(1),
      elevation: 1,
      color: colorScheme.cardBg,
      shadowColor: itemColor,
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
          onTap: item.onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Prominent clean icon (matching stat card value scale)

                Icon(item.icon, size: 28, color: itemColor),

                // Title matching CommonStatCard's text size, font weight & 2-line height
                SizedBox(
                  child: Center(
                    child: Text(
                      item.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.textTitle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
