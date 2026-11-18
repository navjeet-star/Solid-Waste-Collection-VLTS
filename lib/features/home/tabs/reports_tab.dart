import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/app_locale.dart';

/// Reports Tab view for the Bottom Navigation Bar.
///
/// Fully responsive with Material 3 styling and English/Hindi localization.
class ReportsTab extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const ReportsTab({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu_rounded, color: colorScheme.onSurface),
            onPressed: onMenuTap,
          ),
          title: Text(
            strings.reports,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(18, 12, 18, 96),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Banner Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withValues(alpha: 0.25),
                      blurRadius: 14,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      strings.wasteCollectedThisMonth,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '2,348.60 MT',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildQuickMetric(strings.totalUlbs, '175'),
                        const SizedBox(width: 20),
                        _buildQuickMetric(strings.totalWards, '1,184'),
                        const SizedBox(width: 20),
                        _buildQuickMetric(strings.registeredFleet, '794'),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Operational Reports Section Header
              Text(
                strings.dashboardModules,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
              ),

              const SizedBox(height: 12),

              _buildReportCard(
                context,
                title: strings.ulbProgressReport,
                subtitle: strings.ulbProgressReportToday,
                icon: Icons.bar_chart_rounded,
                accentColor: colorScheme.primary,
                onTap: () => CommonFunctions.showSnackBar(context, strings.ulbProgressReport),
              ),

              const SizedBox(height: 12),

              _buildReportCard(
                context,
                title: strings.attendanceDashboard,
                subtitle: strings.attendanceSubtitle,
                icon: Icons.how_to_reg_rounded,
                accentColor: const Color(0xFFF59E0B),
                onTap: () => CommonFunctions.showSnackBar(context, strings.attendanceDashboard),
              ),

              const SizedBox(height: 12),

              _buildReportCard(
                context,
                title: strings.routeAnalytics,
                subtitle: strings.routeCoverage,
                icon: Icons.alt_route_rounded,
                accentColor: const Color(0xFF2563EB),
                onTap: () => CommonFunctions.showSnackBar(context, strings.routeAnalytics),
              ),

              const SizedBox(height: 12),

              _buildReportCard(
                context,
                title: strings.vehicleTracking,
                subtitle: strings.d2dTipper,
                icon: Icons.local_shipping_rounded,
                accentColor: const Color(0xFF10B981),
                onTap: () => CommonFunctions.showSnackBar(context, strings.vehicleTracking),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickMetric(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildReportCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withValues(alpha: 0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.shadow.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: accentColor, size: 24),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
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
              Icon(
                Icons.chevron_right_rounded,
                color: colorScheme.onSurfaceVariant.withValues(alpha: 0.6),
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
