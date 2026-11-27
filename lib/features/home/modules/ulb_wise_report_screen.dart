import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/features/home/items/ulb_details_item.dart';
import 'package:vlts_swc/models/ulb_detail_model.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';
import 'package:vlts_swc/widgets/common_empty_view.dart';
import 'package:vlts_swc/widgets/common_grouped_dropdown.dart';

class UlbWiseReportScreen extends StatefulWidget {
  const UlbWiseReportScreen({super.key});

  @override
  State<UlbWiseReportScreen> createState() => _UlbWiseReportScreenState();
}

class _UlbWiseReportScreenState extends State<UlbWiseReportScreen> {
  String? _selectedOption = 'all';
  List<UlbDetailItemModel> _displayedList = [];

  @override
  void initState() {
    super.initState();
    // Initially populate with all sample items
    _displayedList = UlbDetailItemModel.sampleList;
  }

  /// Filters data dynamically when an option is selected from the dropdown
  void _onDropdownChanged(String? val) {
    setState(() {
      _selectedOption = val;
      _displayedList = UlbDetailItemModel.filterByOption(val);
    });
  }

  /// Builds the grouped dropdown options matching the prompt specifications:
  /// - All ULB
  /// - Nagar Nigam: 1, 2, 3, 4
  /// - Nagar Palika Parishad: 1, 2, 3, 4
  /// - Nagar Panchayat: 1, 2, 3, 4
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

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final dropdownItems = _buildDropdownItems(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CommonAppBar(
        title: strings.ulbWiseDetails,
        showBackButton: true,
        onBackTap: () => Get.back(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // =========================================================
            // Top Section: Grouped Dropdown (Filters automatically on selection)
            // =========================================================
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: CommonGroupedDropdown<String>(
                value: _selectedOption,
                items: dropdownItems,
                hintText: strings.selectUlb,
                prefixIcon: Icons.location_city_rounded,
                onChanged: _onDropdownChanged,
              ),
            ),

            // =========================================================
            // Results Counter Bar
            // =========================================================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_displayedList.length} ${strings.allUlbs}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_selectedOption != null && _selectedOption != 'all')
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedOption = 'all';
                          _displayedList = UlbDetailItemModel.sampleList;
                        });
                      },
                      child: Text(
                        strings.resetFilters,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 4),

            // =========================================================
            // 3. Scrollable ULB Details Listing
            // =========================================================
            Expanded(
              child:_displayedList.isEmpty
                      ? const CommonEmptyView()
                      : ListView.builder(
                        padding: const EdgeInsets.only(top: 4, bottom: 20),
                        physics: const AlwaysScrollableScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        itemCount: _displayedList.length,
                        itemBuilder: (context, index) {
                          final item = _displayedList[index];
                          return UlbDetailsItem(
                            item: item,
                            onTap: () {
                              // Can show quick details or snackbar
                            },
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

/// Backwards compatibility alias
typedef UlbWiseDetailsScreen = UlbWiseReportScreen;
