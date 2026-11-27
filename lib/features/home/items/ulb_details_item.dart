import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/models/ulb_detail_model.dart';

/// Reusable list item widget displaying a comprehensive, compact card for a ULB.
/// Includes:
/// - ULB Name & Type
/// - Target vs Registered Metrics (Wards, Vehicles, D2D Vehicles)
/// - Staffing & Personnel Breakdown (Sanitary Inspector, Env Inspector, Sanitary Worker, Driver, Helper, Employee)
class UlbDetailsItem extends StatelessWidget {
  final UlbDetailItemModel item;
  final VoidCallback? onTap;

  const UlbDetailsItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      color: colorScheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.25),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // =======================================================
            // 1. ULB Header: Icon + Name + Category Badge
            // =======================================================
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.location_city_rounded,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.ulbName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.textTitle,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.ulbType,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
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
            Divider(
              height: 1,
              color: colorScheme.outline.withValues(alpha: 0.12),
            ),
            const SizedBox(height: 12),

            // =======================================================
            // 2. Registered / Target Metrics (Wards, Vehicles, D2D)
            // =======================================================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.35,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTargetMetricCell(
                      context: context,
                      title: strings.wards,
                      registered: item.wardsRegistered,
                      target: item.wardsTarget,
                      icon: Icons.grid_view_rounded,
                      color: colorScheme.primary,
                    ),
                  ),
                  Container(
                    height: 38,
                    width: 1,
                    color: colorScheme.outline.withValues(alpha: 0.15),
                  ),
                  Expanded(
                    child: _buildTargetMetricCell(
                      context: context,
                      title: strings.vehiclesRegistered,
                      registered: item.vehiclesRegistered,
                      target: item.vehiclesTarget,
                      icon: Icons.directions_bus_rounded,
                      color: colorScheme.tertiary,
                    ),
                  ),
                  Container(
                    height: 38,
                    width: 1,
                    color: colorScheme.outline.withValues(alpha: 0.15),
                  ),
                  Expanded(
                    child: _buildTargetMetricCell(
                      context: context,
                      title: strings.d2dVehicles,
                      registered: item.d2dVehiclesRegistered,
                      target: item.d2dVehiclesTarget,
                      icon: Icons.local_shipping_rounded,
                      color: colorScheme.tertiary,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // =======================================================
            // 3. Staffing Breakdown (Sanitary, Env, Workers, Drivers, Helpers, Employees)
            // =======================================================
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.25,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildStaffItem(
                          context: context,
                          label: strings.sanitaryInspector,
                          count: item.sanitaryInspector,
                          icon: Icons.health_and_safety_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStaffItem(
                          context: context,
                          label: strings.environmentInspector,
                          count: item.environmentInspector,
                          icon: Icons.eco_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStaffItem(
                          context: context,
                          label: strings.sanitaryWorker,
                          count: item.sanitaryWorker,
                          icon: Icons.cleaning_services_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStaffItem(
                          context: context,
                          label: strings.driver,
                          count: item.driver,
                          icon: Icons.drive_eta_outlined,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStaffItem(
                          context: context,
                          label: strings.helper,
                          count: item.helper,
                          icon: Icons.support_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildStaffItem(
                          context: context,
                          label: strings.employee,
                          count: item.employee,
                          icon: Icons.badge_outlined,
                          isHighlight: false,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Metric cell displaying Registered / Target values with clarity.
  Widget _buildTargetMetricCell({
    required BuildContext context,
    required String title,
    required int registered,
    required int target,
    required IconData icon,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14, color: color),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$registered / $target',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Reg / Target',
            style: TextStyle(
              fontSize: 9,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  /// Compact, clean staff item for personnel breakdown.
  Widget _buildStaffItem({
    required BuildContext context,
    required String label,
    required int count,
    required IconData icon,
    bool isHighlight = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final Color color = isHighlight ? colorScheme.primary : colorScheme.onSurfaceVariant;

    return Row(
      children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 6),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: '$label: ',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: '$count',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isHighlight
                        ? colorScheme.primary
                        : colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }


}
