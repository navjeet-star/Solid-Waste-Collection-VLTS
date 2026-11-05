import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/decoration/common_decorations.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/models/ulb_progress_item.dart';

class UlbProgressListItem extends StatelessWidget {
  final UlbProgressItem item;
  final VoidCallback? onTap;

  const UlbProgressListItem({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      elevation: 1,
      color: colorScheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Rank Badge + ULB Name + Score
                Row(
                  children: [
                    // ULB Name
                    Expanded(
                      child: Text(
                        item.ulbName,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.textTitle,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    // Score Badge using CommonDecoration
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: CommonDecoration.tintedBadge(
                        colorScheme.primary,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${strings.score} ',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.primary,
                            ),
                          ),
                          Text(
                            '${item.score}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Route Coverage Progress Bar
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          strings.routeCoverage,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: colorScheme.textDesc,
                          ),
                        ),
                        Text(
                          '${item.routeCoverage.toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colorScheme.textDesc,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: (item.routeCoverage / 100).clamp(0.0, 1.0),
                        minHeight: 6,
                        backgroundColor: colorScheme.outline.withValues(
                          alpha: 0.12,
                        ),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                // Metrics Row: Robust, distortion-free 3-column layout
                Row(
                  children: [
                    // Active Fleet Box (flex: 4 for longer "39/40 (97%)" text)
                    Expanded(
                      flex: 4,
                      child: _MetricBox(
                        label: strings.active,
                        value: item.fleetActive,
                        color: colorScheme.primary,
                        icon: Icons.local_shipping_outlined,
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Trips Done Box (flex: 3)
                    Expanded(
                      flex: 3,
                      child: _MetricBox(
                        label: strings.trips,
                        value: '${item.tripsDone}',
                        color: colorScheme.blue,
                        icon: Icons.alt_route_rounded,
                      ),
                    ),
                    const SizedBox(width: 6),

                    // Offline / Not Reporting Box (flex: 3)
                    Expanded(
                      flex: 3,
                      child: _MetricBox(
                        label: strings.notReporting,
                        value: item.notReporting,
                        color: colorScheme.red,
                        icon: Icons.wifi_off_rounded,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Robust, distortion-free metric box designed to fit gracefully across all screen widths
class _MetricBox extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  final IconData icon;

  const _MetricBox({
    required this.label,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
      decoration: CommonDecoration.tintedBadge(color),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            value,
            maxLines: 1,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
