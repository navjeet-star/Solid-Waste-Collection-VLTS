import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';

/// Complaints Tab view for the Bottom Navigation Bar.
///
/// Displays citizen Swachhta complaints, resolution status, and filters.
class ComplaintsTab extends StatefulWidget {
  final VoidCallback? onMenuTap;

  const ComplaintsTab({super.key, this.onMenuTap});

  @override
  State<ComplaintsTab> createState() => _ComplaintsTabState();
}

class _ComplaintsTabState extends State<ComplaintsTab> {
  int _selectedFilter = 0; // 0: All, 1: Pending, 2: In Progress, 3: Resolved

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    final filterLabels = ['All (48)', 'Pending (9)', 'In Progress (12)', 'Resolved (27)'];

    final complaints = [
      _ComplaintItem(
        id: '#SWC-8921',
        title: 'Overflowing Waste Container',
        location: 'Ward 07 • Central Market Area',
        time: '15 mins ago',
        status: 'In Progress',
        statusColor: const Color(0xFFF59E0B),
      ),
      _ComplaintItem(
        id: '#SWC-8919',
        title: 'Missed D2D Tipper Collection',
        location: 'Ward 12 • North Zone Sector 4',
        time: '42 mins ago',
        status: 'Pending',
        statusColor: const Color(0xFFEF4444),
      ),
      _ComplaintItem(
        id: '#SWC-8914',
        title: 'Street Garbage Dump Not Cleared',
        location: 'Ward 04 • East Enclave Main Road',
        time: '2 hours ago',
        status: 'Resolved',
        statusColor: const Color(0xFF10B981),
      ),
      _ComplaintItem(
        id: '#SWC-8902',
        title: 'Secondary Transfer Station Blocked',
        location: 'Ward 02 • South Terminal Yard',
        time: '4 hours ago',
        status: 'Resolved',
        statusColor: const Color(0xFF10B981),
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.menu_rounded, color: colorScheme.onSurface),
            onPressed: widget.onMenuTap,
          ),
          title: Text(
            strings.complaints,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Filter Chips Horizontal List
            SizedBox(
              height: 48,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: filterLabels.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilter == index;
                  return ChoiceChip(
                    label: Text(filterLabels[index]),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedFilter = index;
                      });
                    },
                    selectedColor: colorScheme.primary,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Complaints List
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 96),
                itemCount: complaints.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = complaints[index];
                  return Container(
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
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: item.statusColor.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                item.status,
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
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ComplaintItem {
  final String id;
  final String title;
  final String location;
  final String time;
  final String status;
  final Color statusColor;

  const _ComplaintItem({
    required this.id,
    required this.title,
    required this.location,
    required this.time,
    required this.status,
    required this.statusColor,
  });
}
