import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/core/theme/app_theme_mode.dart';
import 'package:vlts_swc/extensions/Extensions.dart';
import 'package:vlts_swc/features/home/tabs/profile_info_tile.dart';
import 'package:vlts_swc/features/login/models/ProfileDetail.dart';
import 'package:vlts_swc/widgets/LanguageSelector.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';
import 'package:vlts_swc/widgets/theme_toggle_button.dart';


class ProfileTab extends StatefulWidget {
  final ProfileDetail? user;
  final VoidCallback? onMenuTap;

  const ProfileTab({
    super.key,
    this.user,
    this.onMenuTap,
  });

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  ProfileDetail? _profile;

  /// Default fallback dummy profile when no session is stored
  static final ProfileDetail _defaultDummyProfile = ProfileDetail(
    name: 'Rajesh Kumar Sharma',
    mobileNo: '+91 98765 43210',
    designation: 'Senior Sanitation Officer',
    roleName: 'Operations Administrator',
    emailID: 'rajesh.sharma@swc.gov.in',
    userLevel: 'State Level (Level 1)',
    district: 'Dehradun',
    ulb: 'Dehradun Municipal Corporation',
    ward: 'Ward 07',
    employeeID: 'EMP-SWC-8921',
  );

  @override
  void initState() {
    super.initState();
    _profile = widget.user;
    if (_profile == null) {
      _loadProfile();
    }
  }

  @override
  void didUpdateWidget(covariant ProfileTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      setState(() {
        _profile = widget.user ?? _defaultDummyProfile;
      });
    }
  }

  Future<void> _loadProfile() async {
    try {
      final saved = await SharedPrefsService.getProfile();
      if (mounted) {
        setState(() {
          _profile = saved ?? _defaultDummyProfile;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _profile = _defaultDummyProfile;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentLanguage =
        appLocale.value.languageCode == 'hi' ? 'हिन्दी' : 'English';

    final profile = _profile ?? _defaultDummyProfile;
    final name = profile.name ?? _defaultDummyProfile.name!;
    final designation = profile.designation ?? _defaultDummyProfile.designation!;
    final mobileNo = profile.mobileNo ?? _defaultDummyProfile.mobileNo!;
    final roleName = profile.roleName ?? _defaultDummyProfile.roleName!;
    final emailId = profile.emailID ?? _defaultDummyProfile.emailID!;
    final userLevel = profile.userLevel ?? _defaultDummyProfile.userLevel!;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: CommonAppBar(
          title: strings.profile,
          showDrawerButton: true,
          onMenuTap: widget.onMenuTap,
        ),
        body: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 640),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // =========================================
                            // 1. Profile Avatar & Identity Header Card
                            // =========================================
                            _buildHeaderCard(
                              context,
                              name: name,
                              designation: designation,
                              userLevel: userLevel,
                            ),

                            const SizedBox(height: 20),

                            // =========================================
                            // 2. Personal & Contact Information Card
                            // =========================================
                            _buildSectionTitle(
                              title: strings.profileInformation,
                              colorScheme: colorScheme,
                            ),
                            const SizedBox(height: 10),
                            _buildCardContainer(
                              colorScheme: colorScheme,
                              children: [
                                ProfileInfoTile(
                                  icon: Icons.person_outline_rounded,
                                  label: strings.name,
                                  value: name,
                                ),
                                _buildDivider(colorScheme),
                                ProfileInfoTile(
                                  icon: Icons.phone_outlined,
                                  label: strings.mobileNumber,
                                  value: mobileNo,
                                ),
                                _buildDivider(colorScheme),
                                ProfileInfoTile(
                                  icon: Icons.email_outlined,
                                  label: strings.emailId,
                                  value: emailId,
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // =========================================
                            // 3. Official & Role Information Card
                            // =========================================
                            _buildSectionTitle(
                              title: strings.officialInformation,
                              colorScheme: colorScheme,
                            ),
                            const SizedBox(height: 10),
                            _buildCardContainer(
                              colorScheme: colorScheme,
                              children: [
                                ProfileInfoTile(
                                  icon: Icons.work_outline_rounded,
                                  label: strings.designation,
                                  value: designation,
                                ),
                                _buildDivider(colorScheme),
                                ProfileInfoTile(
                                  icon: Icons.admin_panel_settings_outlined,
                                  label: strings.role,
                                  value: roleName,
                                ),
                                _buildDivider(colorScheme),
                                ProfileInfoTile(
                                  icon: Icons.layers_outlined,
                                  label: strings.userLevel,
                                  value: userLevel,
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),

                            // =========================================
                            // 3. Settings Option
                            // =========================================
                            _buildSectionTitle(
                              title: strings.settings,
                              colorScheme: colorScheme,
                            ),
                            const SizedBox(height: 10),
                            _buildCardContainer(
                              colorScheme: colorScheme,
                              children: [
                                ProfileInfoTile(
                                  icon: isDark
                                      ? Icons.light_mode_rounded
                                      : Icons.dark_mode_rounded,
                                  label: strings.changeTheme,
                                  value: isDark
                                      ? strings.switchToLightMode
                                      : strings.switchToDarkMode,
                                  trailing: const ThemeToggleButton(),
                                  onTap: () => toggleTheme(context),
                                ),
                                _buildDivider(colorScheme),
                                ProfileInfoTile(
                                  icon: Icons.translate_rounded,
                                  label: strings.changeLanguage,
                                  value: currentLanguage,
                                  trailing: const LanguageSelector(),
                                ),
                              ],
                            ),

                            const SizedBox(height: 28),
                            // =========================================
                            // 4. Logout Action
                            // =========================================
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: OutlinedButton.icon(
                                onPressed: () =>
                                    CommonFunctions.showLogoutDialog(context),
                                icon: Icon(
                                  Icons.logout_rounded,
                                  color: colorScheme.error,
                                  size: 20,
                                ),
                                label: Text(
                                  strings.logout,
                                  style: TextStyle(
                                    color: colorScheme.error,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(
                                    color: colorScheme.error
                                        .withValues(alpha: 0.4),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }

  /// Builds the top Profile Avatar Card
  Widget _buildHeaderCard(
    BuildContext context, {
    required String name,
    required String designation,
    required String userLevel,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final initials = name.getInitials();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Circular Avatar with initial letters
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withValues(alpha: 0.12),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.35),
                width: 2.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: 0.15),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Center(
              child: Text(
                initials,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          // User Name
          Text(
            name,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),

          const SizedBox(height: 6),

          // Designation Pill
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_user_rounded,
                  size: 14,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  designation,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a section title text
  Widget _buildSectionTitle({
    required String title,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
          letterSpacing: 0.2,
        ),
      ),
    );
  }

  /// Builds a clean card wrapper with subtle shadow and border
  Widget _buildCardContainer({
    required ColorScheme colorScheme,
    required List<Widget> children,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  /// Subtle separator between info tiles
  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      height: 16,
      thickness: 0.8,
      color: colorScheme.outline.withValues(alpha: 0.1),
    );
  }
}
