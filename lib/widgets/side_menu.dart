import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/ui/login_screen.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/widgets/LanguageSelector.dart';
import 'package:solid_waste_collection_vlts/widgets/theme_toggle_button.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      backgroundColor: colorScheme.surface,
      width: MediaQuery.of(context).size.width * 0.82,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: isDark ? 0.12 : 0.08),
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: colorScheme.primary,
                            child: const Text(
                              'TU',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Test user',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              strings.profileRole,
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'test.user@swm.gov.in',
                              style: TextStyle(
                                fontSize: 11,
                                color: colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),

            // Navigation List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                children: [
                  _buildMenuItem(
                    context: context,
                    icon: Icons.dashboard_rounded,
                    title: strings.dashboard,
                    isSelected: true,
                    onTap: () => Navigator.pop(context),
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.radar_rounded,
                    title: strings.realTimeTracking,
                    onTap: () {
                      Navigator.pop(context);
                      CommonSnackBar.show(context, strings.realTimeTracking);
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.route_rounded,
                    title: strings.routeAnalytics,
                    onTap: () {
                      Navigator.pop(context);
                      CommonSnackBar.show(context, strings.routeAnalytics);
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.recycling_rounded,
                    title: strings.swachhBharatMission,
                    onTap: () {
                      Navigator.pop(context);
                      CommonSnackBar.show(context, strings.swachhBharatMission);
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.insert_chart_outlined_rounded,
                    title: strings.reports,
                    onTap: () {
                      Navigator.pop(context);
                      CommonSnackBar.show(context, strings.reports);
                    },
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Divider(),
                  ),

                  // Language Selection in Drawer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.translate_rounded, size: 20, color: colorScheme.onSurfaceVariant),
                            const SizedBox(width: 12),
                            Text(
                              strings.language,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        const LanguageSelector(),
                      ],
                    ),
                  ),

                  // Theme Selection in Drawer
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.brightness_6_rounded, size: 20, color: colorScheme.onSurfaceVariant),
                            const SizedBox(width: 12),
                            Text(
                              isDark ? strings.switchToLightMode : strings.switchToDarkMode,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                        const ThemeToggleButton(),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Logout Footer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                  ),
                ),
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                title: Text(
                  strings.logout,
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary.withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        dense: true,
        leading: Icon(
          icon,
          color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
          size: 22,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? colorScheme.primary : colorScheme.onSurface,
          ),
        ),
        trailing: isSelected
            ? Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary,
                ),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
