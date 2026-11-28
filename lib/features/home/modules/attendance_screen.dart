import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/features/home/items/attendance_card_item.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/models/AttendanceStatusList.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';
import 'package:vlts_swc/widgets/common_date_picker.dart';
import 'package:vlts_swc/widgets/common_empty_view.dart';
import 'package:vlts_swc/widgets/common_grouped_dropdown.dart';
import 'package:vlts_swc/widgets/common_search_bar.dart';


class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  late final HomeViewModel _homeViewModel;
  final TextEditingController _searchController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String? _selectedOption = 'all';
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _homeViewModel = Get.isRegistered<HomeViewModel>()
        ? Get.find<HomeViewModel>()
        : Get.put(HomeViewModel());

    // Fetch live API data using GetAttendanceStatus endpoint if not yet loaded
    if (_homeViewModel.attendanceStatusList.isEmpty) {
      _homeViewModel.fetchAttendanceStatus();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  /// Builds grouped dropdown options matching the application standards
  List<GroupedDropdownItem<String>> _buildDropdownItems(BuildContext context) {
    final strings = context.l10n;

    return [
      // Top-level All option
      GroupedDropdownItem.option(
        value: 'all',
        label: strings.allUlb,
        icon: Icons.select_all_rounded,
      ),

      // Category 1: Nagar Nigam
      GroupedDropdownItem.header(
        strings.nagarNigam,
        icon: Icons.account_balance_rounded,
      ),
      GroupedDropdownItem.option(
        value: 'nn_1',
        label: '1',
        groupTitle: strings.nagarNigam,
      ),
      GroupedDropdownItem.option(
        value: 'nn_2',
        label: '2',
        groupTitle: strings.nagarNigam,
      ),
      GroupedDropdownItem.option(
        value: 'nn_3',
        label: '3',
        groupTitle: strings.nagarNigam,
      ),
      GroupedDropdownItem.option(
        value: 'nn_4',
        label: '4',
        groupTitle: strings.nagarNigam,
      ),

      // Category 2: Nagar Palika Parishad
      GroupedDropdownItem.header(
        strings.nagarPalikaParishad,
        icon: Icons.domain_rounded,
      ),
      GroupedDropdownItem.option(
        value: 'npp_1',
        label: '1',
        groupTitle: strings.nagarPalikaParishad,
      ),
      GroupedDropdownItem.option(
        value: 'npp_2',
        label: '2',
        groupTitle: strings.nagarPalikaParishad,
      ),
      GroupedDropdownItem.option(
        value: 'npp_3',
        label: '3',
        groupTitle: strings.nagarPalikaParishad,
      ),
      GroupedDropdownItem.option(
        value: 'npp_4',
        label: '4',
        groupTitle: strings.nagarPalikaParishad,
      ),

      // Category 3: Nagar Panchayat
      GroupedDropdownItem.header(
        strings.nagarPanchayat,
        icon: Icons.holiday_village_rounded,
      ),
      GroupedDropdownItem.option(
        value: 'np_1',
        label: '1',
        groupTitle: strings.nagarPanchayat,
      ),
      GroupedDropdownItem.option(
        value: 'np_2',
        label: '2',
        groupTitle: strings.nagarPanchayat,
      ),
      GroupedDropdownItem.option(
        value: 'np_3',
        label: '3',
        groupTitle: strings.nagarPanchayat,
      ),
      GroupedDropdownItem.option(
        value: 'np_4',
        label: '4',
        groupTitle: strings.nagarPanchayat,
      ),
    ];
  }

  /// Filters the attendance list according to selected category and search text
  List<AttendanceStatusList> _filterRecords(List<AttendanceStatusList> records) {
    return records.where((item) {
      // 1. Search Query filter
      if (_searchQuery.isNotEmpty) {
        final matchesQuery = item.ulbName.toLowerCase().contains(_searchQuery.toLowerCase());
        if (!matchesQuery) return false;
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final dropdownItems = _buildDropdownItems(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CommonAppBar(
        title: strings.attendanceDashboard,
        centerTitle: false,
        showBackButton: true,
        onBackTap: () => Get.back(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // =========================================================
            // 1. Filters Header (Dropdown + Date Picker + Search)
            // =========================================================
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
              decoration: BoxDecoration(
                color: colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: colorScheme.outline.withValues(alpha: 0.12),
                  ),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      // A. Grouped ULB Selector Dropdown
                      Expanded(
                        flex: 5,
                        child: CommonGroupedDropdown<String>(
                          value: _selectedOption,
                          items: dropdownItems,
                          hintText: strings.selectUlb,
                          height: 44,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
                          borderColor: colorScheme.outline.withValues(alpha: 0.20),
                          onChanged: (val) {
                            setState(() {
                              _selectedOption = val;
                            });
                          },
                        ),
                      ),

                      const SizedBox(width: 8),

                      // B. Date Picker Filter
                      Expanded(
                        flex: 4,
                        child: CommonDatePicker(
                          selectedDate: _selectedDate,
                          height: 44,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: colorScheme.surfaceContainerHighest
                              .withValues(alpha: 0.35),
                          borderColor:
                              colorScheme.outline.withValues(alpha: 0.20),
                          onDateSelected: (newDate) {
                            setState(() {
                              _selectedDate = newDate;
                            });
                          },
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // C. Compact Common Search Bar
                  CommonSearchBar(
                    controller: _searchController,
                    hintText: strings.searchUlb,
                    onChanged: (val) {
                      setState(() {
                        _searchQuery = val.trim();
                      });
                    },
                    onClear: () {
                      setState(() {
                        _searchQuery = '';
                      });
                    },
                  ),
                ],
              ),
            ),

            // =========================================================
            // 2. Reactive Attendance Listing & State Management
            // =========================================================
            Expanded(
              child: Obx(() {
                final apiList = _homeViewModel.attendanceStatusList;
                final List<AttendanceStatusList> allRecords;

                if (apiList.isNotEmpty) {
                  // Primary: Records returned directly from GetAttendanceStatus API
                  allRecords = apiList.toList();
                } else {
                  // Sample offline fallback
                  allRecords = AttendanceStatusList.sampleList;
                }

                final filteredList = _filterRecords(allRecords);


                return ListView(
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  padding: const EdgeInsets.only(top: 10, bottom: 24),
                  children: [
                    // B. Active Results Count Bar
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${filteredList.length} ${strings.allUlbs}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (_selectedOption != 'all' || _searchQuery.isNotEmpty)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedOption = 'all';
                                  _searchController.clear();
                                  _searchQuery = '';
                                });
                              },
                              child: Text(
                                strings.resetFilters,
                                style: TextStyle(
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.primary,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    // C. Empty View or List of Attendance Cards
                    if (filteredList.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: CommonEmptyView(),
                      )
                    else
                      ...filteredList.map(
                        (item) => AttendanceCardItem(
                          record: item,
                          onTap: () {
                            // Optional feedback on tap
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  '${item.ulbName}: ${item.present} ${strings.present}, ${item.absent} ${strings.absent}',
                                ),
                                duration: const Duration(seconds: 1),
                                behavior: SnackBarBehavior.floating,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
