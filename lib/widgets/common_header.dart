import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/widgets/theme_toggle_button.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final int notificationCount;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const CommonHeader({
    super.key,
    this.title = "App name",
    this.notificationCount = 0,
    this.onProfileTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.surface,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: colorScheme.primary.withValues(alpha: 0.15),
              child: Icon(Icons.person, color: colorScheme.primary, size: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ),
          ),
          const ThemeToggleButton(),
          Stack(
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: Icon(
                  Icons.notifications,
                  size: 25,
                  color: colorScheme.onSurface,
                ),
              ),
              Positioned(
                right: 5,
                top: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Center(
                    child: Text(
                      notificationCount > 99
                          ? '99+'
                          : notificationCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
