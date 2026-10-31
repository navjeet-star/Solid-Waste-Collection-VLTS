import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/models/module_item.dart';

/// Simple, elegant CardView item for each module in the Grid
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
    final itemColor = item.color ?? colorScheme.primary;

    return Card(
      elevation: 2,
      shadowColor: itemColor.withValues(alpha: 0.18),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: item.onTap,
        splashColor: itemColor.withValues(alpha: 0.12),
        highlightColor: itemColor.withValues(alpha: 0.06),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Relevant icon/logo inside a circular tinted container
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: itemColor.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 26,
                  color: itemColor,
                ),
              ),

              const SizedBox(height: 12),

              // Module title placed below the icon
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                  height: 1.25,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}