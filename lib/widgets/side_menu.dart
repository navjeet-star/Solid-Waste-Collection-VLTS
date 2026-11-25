import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/extensions/Extensions.dart';
import 'package:vlts_swc/features/login/models/ProfileDetail.dart';
import 'package:vlts_swc/widgets/LanguageSelector.dart';
import 'package:vlts_swc/widgets/theme_toggle_button.dart';

class SideMenu extends StatefulWidget {
  final ProfileDetail? user;

  const SideMenu({super.key, this.user});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  ProfileDetail? _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.user;
    if (_profile == null) {
      _loadProfile();
    }
  }

  @override
  void didUpdateWidget(covariant SideMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      setState(() {
        _profile = widget.user;
      });
    }
  }

  Future<void> _loadProfile() async {
    try {
      final profile = await SharedPrefsService.getProfile();
      if (mounted) {
        setState(() {
          _profile = profile;
        });
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final profile = _profile ?? widget.user;
    final name = profile?.name?.trim().isNotEmpty == true
        ? profile!.name!
        : 'Super Admin';
    final role = profile?.designation?.trim().isNotEmpty == true
        ? profile!.designation!
        : (profile?.roleName?.trim().isNotEmpty == true
            ? profile!.roleName!
            : strings.profileRole);
    final email = profile?.emailID?.trim().isNotEmpty == true
        ? profile!.emailID!
        : (profile?.mobileNo?.trim().isNotEmpty == true
            ? profile!.mobileNo!
            : 'admin@swc.gov.in');
    final initials = name.getInitials(fallback: 'SA');

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
                color: colorScheme.primary.withValues(alpha: 0.08),
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
                            child: Text(
                              initials,
                              style: TextStyle(
                                color: colorScheme.onPrimary,
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
                              name,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              role,
                              style: TextStyle(
                                fontSize: 12,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              email,
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
                      CommonFunctions.showSnackBar(context, strings.realTimeTracking);
                      },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.route_rounded,
                    title: strings.routeAnalytics,
                    onTap: () {
                      Navigator.pop(context);
                      CommonFunctions.showSnackBar(context, strings.routeAnalytics);
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.recycling_rounded,
                    title: strings.swachhBharatMission,
                    onTap: () {
                      Navigator.pop(context);
                      CommonFunctions.showSnackBar(context, strings.swachhBharatMission);
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.insert_chart_outlined_rounded,
                    title: strings.reports,
                    onTap: () {
                      Navigator.pop(context);
                      CommonFunctions.showSnackBar(context, strings.reports);
                    },
                  ),
                  _buildMenuItem(
                    context: context,
                    icon: Icons.leaderboard_rounded,
                    title: strings.ulbProgressReport,
                    onTap: () {
                      Navigator.pop(context);
                      CommonFunctions.showSnackBar(context, strings.ulbProgressReport);
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
                              isDarkMode ? strings.switchToLightMode : strings.switchToDarkMode,
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
                leading: Icon(Icons.logout_rounded, color: colorScheme.error),
                title: Text(
                  strings.logout,
                  style: TextStyle(
                    color: colorScheme.error,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                onTap: () {
                  CommonFunctions.showLogoutDialog(context);
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

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Material(
        color: isSelected
            ? colorScheme.primary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: ListTile(
          dense: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          leading: Icon(
            icon,
            color:
                isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
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
      ),
    );
  }
}
