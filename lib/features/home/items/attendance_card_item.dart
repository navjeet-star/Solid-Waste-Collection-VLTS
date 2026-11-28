import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/models/AttendanceStatusList.dart';

class AttendanceCardItem extends StatelessWidget {
  final AttendanceStatusList record;
  final VoidCallback? onTap;

  const AttendanceCardItem({
    super.key,
    required this.record,
    this.onTap,
  });

  /// Convenient factory to construct from an [AttendanceStatusList] API model
  factory AttendanceCardItem.fromStatus({
    Key? key,
    required AttendanceStatusList status,
    VoidCallback? onTap,
    DateTime? date,
  }) {
    return AttendanceCardItem(
      key: key,
      record: status,
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    // Distinct Status Colors (Accessibility & Theme tuned)
    final Color greenColor = colorScheme.green;
    final Color redColor = colorScheme.red;
    final Color orangeColor = colorScheme.yellow;
    final Color greyColor = colorScheme.textDesc;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
        color: colorScheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.30),),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =========================================================
                // 1. Header: ULB Name & Total Staff Badge
                // =========================================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_city_rounded,
                      size: 18,
                      color: colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        record.ulbName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Total Staff Compact Pill
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      child: Text(
                        '${strings.totalStaff}: ${record.totalStaff}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // =========================================================
                // 2. Status Indicators: Present, Absent, Leave, Not Marked
                // =========================================================
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Standard 4-Column Responsive Row
                    return Row(
                      children: [
                        Expanded(
                          child: _buildStatusIndicator(
                            label: strings.present,
                            count: record.present,
                            color: greenColor,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatusIndicator(
                            label: strings.absent,
                            count: record.absent,
                            color: redColor,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatusIndicator(
                            label: strings.leave,
                            count: record.leave,
                            color: orangeColor,
                            isDark: isDark,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildStatusIndicator(
                            label: strings.notMarked,
                            count: record.notMarked,
                            color: greyColor,
                            isDark: isDark,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Compact status indicator badge with tinted background, border, value & label
  Widget _buildStatusIndicator({
    required String label,
    required int count,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 7),
      decoration: BoxDecoration(
        color: color.withValues(alpha: isDark ? 0.16 : 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: color.withValues(alpha: isDark ? 0.40 : 0.25),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
            maxLines: 1,
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.w600,
                color: color.withValues(alpha: 0.95),
              ),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
