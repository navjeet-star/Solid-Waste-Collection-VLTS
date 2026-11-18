import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';

class BottomNavItem {
  final IconData icon;
  final IconData? selectedIcon;
  final String label;

  const BottomNavItem({
    required this.icon,
    this.selectedIcon,
    required this.label,
  });
}

/// Floating Pill / Capsule Bottom Navigation Bar.

class CommonBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;
  final List<BottomNavItem>? items;


  const CommonBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navItems = items ?? [
      BottomNavItem(
        icon: Icons.grid_view_rounded,
        selectedIcon: Icons.grid_view_rounded,
        label: strings.home,
      ),
      BottomNavItem(
        icon: Icons.bar_chart_rounded,
        selectedIcon: Icons.bar_chart_rounded,
        label: strings.reports,
      ),
      BottomNavItem(
        icon: Icons.mark_chat_unread_outlined,
        selectedIcon: Icons.mark_chat_unread_rounded,
        label: strings.complaints,
      ),
      BottomNavItem(
        icon: Icons.person_outline_rounded,
        selectedIcon: Icons.person_rounded,
        label: strings.profile,
      ),
    ];


    return SafeArea(
      top: false,
      bottom: true,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        child: Container(
          height: 65,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color:colorScheme.surface,
            borderRadius: BorderRadius.circular(34),
            border: Border.all(
              color:  colorScheme.outline.withValues(alpha: isDark ? 0.25 : 0.45),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color:  isDark
                    ? Colors.black.withValues(alpha: 0.45)
                    : colorScheme.shadow.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: List.generate(navItems.length, (index) {
              final item = navItems[index];
              final isSelected = index == currentIndex;

              return Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => onItemSelected(index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 240),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ?  colorScheme.primary.withValues(alpha: isDark ? 0.22 : 0.12) : Colors.transparent,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          item.icon,
                          size: 21,
                          color: isSelected ?  colorScheme.primary :   colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ?  colorScheme.primary :   colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
