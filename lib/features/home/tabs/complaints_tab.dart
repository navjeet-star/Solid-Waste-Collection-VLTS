import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/features/home/tabs/complaint_card_item.dart';
import 'package:vlts_swc/features/home/tabs/complaint_status_item.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';
import 'package:vlts_swc/widgets/common_simple_dropdown.dart';

/// Complaints Tab view for the Bottom Navigation Bar.
///
/// Displays citizen Swachhta complaints with:
/// - A simple common dropdown for selecting complaint type
/// - A horizontally scrollable custom selectable status list (All, Pending, In Progress, Resolved, Rejected)
class ComplaintsTab extends StatefulWidget {
  final VoidCallback? onMenuTap;

  const ComplaintsTab({super.key, this.onMenuTap});

  @override
  State<ComplaintsTab> createState() => _ComplaintsTabState();
}

class _ComplaintsTabState extends State<ComplaintsTab> {
  // Filter States
  String _selectedComplaintType = 'All';
  String _selectedStatus = 'All'; // All, Pending, In Progress, Resolved, Rejected

  // Reference dataset containing diverse statuses, locations, and details
  late final List<_ComplaintItem> _allComplaints;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    _allComplaints = [
      _ComplaintItem(
        id: '#SWC-8921',
        title: 'Overflowing Waste Container',
        citizenName: 'Rajesh Kumar',
        details: 'Commercial dustbin at Central Market is overflowing for 2 days.',
        location: 'Ward 07 • Central Market Area, Dehradun',
        time: '15 mins ago',
        status: 'In Progress',
        statusColor: const Color(0xFFF59E0B),
        date: now,
      ),
      _ComplaintItem(
        id: '#SWC-8919',
        title: 'Missed D2D Tipper Collection',
        citizenName: 'Priya Sharma',
        details: 'Door-to-door waste vehicle missed morning collection in Lane 4.',
        location: 'Ward 12 • North Zone Sector 4, Haridwar',
        time: '42 mins ago',
        status: 'Pending',
        statusColor: const Color(0xFFEF4444),
        date: now,
      ),
      _ComplaintItem(
        id: '#SWC-8914',
        title: 'Street Garbage Dump Not Cleared',
        citizenName: 'Amit Verma',
        details: 'Roadside accumulated waste cleared and verified by field supervisor.',
        location: 'Ward 04 • East Enclave Main Road, Roorkee',
        time: '2 hours ago',
        status: 'Resolved',
        statusColor: const Color(0xFF10B981),
        date: now,
      ),
      _ComplaintItem(
        id: '#SWC-8902',
        title: 'Secondary Transfer Station Blocked',
        citizenName: 'Deepak Rawat',
        details: 'Access ramp cleared and normal tipper unloading resumed.',
        location: 'Ward 02 • South Terminal Yard, Almora',
        time: '4 hours ago',
        status: 'Resolved',
        statusColor: const Color(0xFF10B981),
        date: now,
      ),
      _ComplaintItem(
        id: '#SWC-8895',
        title: 'Biomedical Waste in Municipal Dustbin',
        citizenName: 'Sunil Bisht',
        details: 'Clinic dumped biohazard bags in public bin; inspection team dispatched.',
        location: 'Ward 05 • Mall Road, Mussoorie',
        time: 'Yesterday, 4:30 PM',
        status: 'Pending',
        statusColor: const Color(0xFFEF4444),
        date: now.subtract(const Duration(days: 1)),
      ),
      _ComplaintItem(
        id: '#SWC-8889',
        title: 'Damaged Wheeled Dustbin Replacement',
        citizenName: 'Kavita Joshi',
        details: 'Request rejected as private society area; citizen notified.',
        location: 'Ward 08 • Tallital Bazaar, Nainital',
        time: 'Yesterday, 11:15 AM',
        status: 'Rejected',
        statusColor: const Color(0xFF6B7280),
        date: now.subtract(const Duration(days: 1)),
      ),
      _ComplaintItem(
        id: '#SWC-8874',
        title: 'Irregular Tipper Schedule',
        citizenName: 'Virendra Negi',
        details: 'Route optimization reassigned tipper #05 to ensure 7:30 AM arrival.',
        location: 'Ward 03 • Station Road, Ramnagar',
        time: '2 days ago',
        status: 'In Progress',
        statusColor: const Color(0xFFF59E0B),
        date: now.subtract(const Duration(days: 2)),
      ),
      _ComplaintItem(
        id: '#SWC-8862',
        title: 'Drain Clogging by Plastic Waste',
        citizenName: 'Meena Bhatt',
        details: 'Sanitation team desilted stormwater drain and removed plastics.',
        location: 'Ward 01 • Temple Road, Kedarnath',
        time: '3 days ago',
        status: 'Resolved',
        statusColor: const Color(0xFF10B981),
        date: now.subtract(const Duration(days: 3)),
      ),
      _ComplaintItem(
        id: '#SWC-8850',
        title: 'Open Littering Near Pilgrim Route',
        citizenName: 'Harish Chandra',
        details: 'Littering complaint duplicate; existing action team already on site.',
        location: 'Ward 02 • Main Ghat Path, Badrinath',
        time: '4 days ago',
        status: 'Rejected',
        statusColor: const Color(0xFF6B7280),
        date: now.subtract(const Duration(days: 4)),
      ),
      _ComplaintItem(
        id: '#SWC-8841',
        title: 'Organic Waste Compost Bin Needed',
        citizenName: 'Pooja Rana',
        details: 'Market committee requested community composter for vegetable waste.',
        location: 'Ward 03 • Bus Stand Chowk, Joshimath',
        time: '5 days ago',
        status: 'In Progress',
        statusColor: const Color(0xFFF59E0B),
        date: now.subtract(const Duration(days: 5)),
      ),
    ];
  }

  /// Whether any filter is currently active
  bool get _hasActiveFilters {
    return _selectedStatus != 'All' || _selectedComplaintType != 'All';
  }

  /// Resets all filters back to default
  void _resetAllFilters() {
    setState(() {
      _selectedStatus = 'All';
      _selectedComplaintType = 'All';
    });
  }

  /// Evaluates whether a complaint item satisfies active status and type filters
  List<_ComplaintItem> get _filteredComplaints {
    return _allComplaints.where((item) {
      // 1. Status Filter
      if (_selectedStatus != 'All' && item.status != _selectedStatus) {
        return false;
      }

      // 2. Complaint Type Filter
      if (_selectedComplaintType != 'All' &&
          item.title != _selectedComplaintType) {
        return false;
      }

      return true;
    }).toList();
  }



  /// Returns localized label for status
  String _localizedStatus(BuildContext context, String status) {
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
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    final statuses = ['All', 'Pending', 'In Progress', 'Resolved', 'Rejected'];

    final complaintTypes = [
      'All',
      'Overflowing Waste Container',
      'Missed D2D Tipper Collection',
      'Street Garbage Dump Not Cleared',
      'Secondary Transfer Station Blocked'
    ];

    final filteredList = _filteredComplaints;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: CommonAppBar(
          title: strings.complaints,
          showDrawerButton: true,
          onMenuTap: widget.onMenuTap,
        ),
        body: Column(
          children: [
            // =========================================================
            // 1. Simple Common Dropdown: Select Complaint Type
            // =========================================================
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 10, 18, 8),
              child: CommonSimpleDropdown<String>(
                value: _selectedComplaintType,
                items: complaintTypes,
                hintText: strings.selectComplaintType,
                itemLabelBuilder: (type) {
                  if (type == 'All') return strings.allComplaintTypes;
                  return type;
                },
                onChanged: (val) {
                  setState(() {
                    _selectedComplaintType = val ?? 'All';
                  });
                },
              ),
            ),

            // =========================================================
            // 2. Horizontally Scrollable Custom Status List (No ChoiceChip)
            // =========================================================
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: statuses.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final status = statuses[index];
                  final isSelected = _selectedStatus == status;
                  final label = _localizedStatus(context, status);

                  return ComplaintStatusItem(
                    label: label,
                    isSelected: isSelected,
                    onTap: () {
                      setState(() {
                        _selectedStatus = status;
                      });
                    },
                  );
                },
              ),
            ),

            // =========================================================
            // 3. Active Filter Indicator & Reset Option
            // =========================================================
            if (_hasActiveFilters)
              Padding(
                padding: const EdgeInsets.fromLTRB(18, 6, 18, 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${filteredList.length} ${strings.complaints.toLowerCase()}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                    InkWell(
                      onTap: _resetAllFilters,
                      borderRadius: BorderRadius.circular(12),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4,
                          vertical: 2,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.refresh_rounded,
                              size: 13,
                              color: colorScheme.error,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              strings.resetFilters,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: colorScheme.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            else
              const SizedBox(height: 6),

            // =========================================================
            // 4. Complaints List (Preserving exact card design)
            // =========================================================
            Expanded(
              child: filteredList.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 40,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: colorScheme.primary
                                    .withValues(alpha: 0.08),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.inbox_rounded,
                                size: 40,
                                color: colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              strings.noComplaintsFound,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: colorScheme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: _resetAllFilters,
                              icon: const Icon(
                                Icons.refresh_rounded,
                                size: 15,
                              ),
                              label: Text(
                                strings.resetFilters,
                                style: const TextStyle(fontSize: 12),
                              ),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: colorScheme.primary,
                                side: BorderSide(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.4),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(18, 4, 18, 96),
                      itemCount: filteredList.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final item = filteredList[index];
                        return ComplaintCardItem(
                          item: item,
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

/// Type alias preserving backward compatibility
typedef _ComplaintItem = ComplaintItem;
