import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/services/shared_prefs_service.dart';
import 'package:vlts_swc/features/login/models/login_model.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';

/// Profile Tab view for the Bottom Navigation Bar.
///
/// Displays logged-in officer profile details, assigned ULB/Ward jurisdiction,
/// and quick settings (Language, Theme, and Logout).
class ProfileTab extends StatefulWidget {
  final LoginModel? user;
  final VoidCallback? onMenuTap;

  const ProfileTab({super.key, this.user, this.onMenuTap});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  LoginModel? _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    if (_user == null) {
      _loadProfile();
    }
  }

  @override
  void didUpdateWidget(covariant ProfileTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.user != oldWidget.user) {
      setState(() {
        _user = widget.user;
      });
    }
  }

  Future<void> _loadProfile() async {
    final user = await SharedPrefsService.instance.getLoginResponse();
    if (mounted) {
      setState(() {
        _user = user;
      });
    }
  }

  String get _initials {
    final name = _user?.name?.trim();
    if (name == null || name.isEmpty) return 'U';
    final parts = name.split(RegExp(r'\s+'));
    if (parts.length >= 2 && parts[0].isNotEmpty && parts[1].isNotEmpty) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    final userName = _user?.name?.isNotEmpty == true ? _user!.name! : 'Super Admin';
    final userRole = _user?.roleName?.isNotEmpty == true ? _user!.roleName! : strings.profileRole;
    final userEmail = _user?.emailId?.isNotEmpty == true
        ? _user!.emailId!
        : (_user?.mobileNo?.isNotEmpty == true ? _user!.mobileNo! : 'admin@swc.gov.in');
    final userDistrict = _user?.district?.isNotEmpty == true ? _user!.district! : 'Headquarters';
    final userUlb = _user?.ulb?.isNotEmpty == true ? _user!.ulb! : 'Urban Development Directorate';

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: CommonAppBar(
          title: strings.profile,
          showDrawerButton: true,
          onMenuTap: widget.onMenuTap,
          // actions: const [
          //   ThemeToggleButton(),
          //   SizedBox(width: 8),
          //   LanguageSelector(),
          //   SizedBox(width: 12),
          // ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Identity Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: colorScheme.primary,
                      child: Text(
                        _initials,
                        style: TextStyle(
                          color: colorScheme.onPrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            userRole,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            userEmail,
                            style: TextStyle(
                              fontSize: 12,
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
              ),

              const SizedBox(height: 24),

              // Official Jurisdiction Section
              Text(
                'Jurisdiction & Assignment',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 12),

              _buildInfoTile(
                context,
                title: 'Assigned District',
                value: userDistrict,
                icon: Icons.map_outlined,
              ),
              const SizedBox(height: 10),

              _buildInfoTile(
                context,
                title: 'Urban Local Body (ULB)',
                value: userUlb,
                icon: Icons.location_city_outlined,
              ),

              if (_user?.ward?.isNotEmpty == true) ...[
                const SizedBox(height: 10),
                _buildInfoTile(
                  context,
                  title: 'Assigned Ward',
                  value: _user!.ward!,
                  icon: Icons.holiday_village_outlined,
                ),
              ],

              const SizedBox(height: 28),

              // Danger / Account Actions
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => CommonFunctions.showLogoutDialog(context),
                  icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
                  label: Text(
                    strings.logout,
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red.withValues(alpha: 0.4)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required String title,
    required String value,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 22, color: colorScheme.primary),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 11,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
