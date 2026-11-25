import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';

/// Data model representing a citizen waste management complaint.
class ComplaintItem {
  final String id;
  final String title;
  final String location;
  final String time;
  final String status;
  final Color statusColor;
  final String citizenName;
  final String details;
  final DateTime date;

  const ComplaintItem({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.status,
    required this.statusColor,
    this.citizenName = '',
    this.details = '',
    required this.date,
  });
}

/// Complaint Card Item widget displaying complaint details in ComplaintsTab.
///
/// Preserves the existing clean complaint card layout:
/// - Complaint ID (#SWC-xxxx) and localized status badge
/// - Complaint title / issue type
/// - Location pin with ward and area
/// - Timestamp and citizen name with complaint details
class ComplaintCardItem extends StatelessWidget {
  final ComplaintItem item;
  final VoidCallback? onTap;
  final String? localizedStatus;

  const ComplaintCardItem({
    super.key,
    required this.item,
    this.onTap,
    this.localizedStatus,
  });

  String _getLocalizedStatus(BuildContext context, String status) {
    final strings = context.l10n;
    switch (status) {
      case 'All':
        return strings.all;
      case 'Pending':
        return strings.pending;
      case 'In Progress':
        return strings.inProgress;
      case 'Resolved':
        return strings.resolved;
      case 'Rejected':
        return strings.rejected;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final effectiveStatus =
        localizedStatus ?? _getLocalizedStatus(context, item.status);

    final card = Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.id,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.primary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: item.statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  effectiveStatus,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: item.statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 14,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  item.location,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                item.time,
                style: TextStyle(
                  fontSize: 11,
                  color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          if (item.citizenName.isNotEmpty || item.details.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                if (item.citizenName.isNotEmpty) ...[
                  Icon(
                    Icons.person_outline_rounded,
                    size: 13,
                    color: colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    item.citizenName,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (item.citizenName.isNotEmpty && item.details.isNotEmpty) ...[
                  const SizedBox(width: 6),
                  Text(
                    '•',
                    style: TextStyle(
                      fontSize: 11,
                      color: colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(width: 6),
                ],
                if (item.details.isNotEmpty)
                  Expanded(
                    child: Text(
                      item.details,
                      style: TextStyle(
                        fontSize: 11,
                        color:
                            colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: card,
        ),
      );
    }

    return card;
  }
}
