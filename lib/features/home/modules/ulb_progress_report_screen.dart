import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';
import 'package:vlts_swc/widgets/common_button.dart';
import 'package:vlts_swc/widgets/common_date_picker.dart';
import 'package:vlts_swc/widgets/common_grouped_dropdown.dart';


class UlbProgressReportScreen extends StatefulWidget {
  const UlbProgressReportScreen({super.key});

  @override
  State<UlbProgressReportScreen> createState() =>
      _UlbProgressReportScreenState();
}

class _UlbProgressReportScreenState extends State<UlbProgressReportScreen> {
  late final HomeViewModel _homeViewModel;

  DateTime _selectedDate = DateTime(2026, 11, 18);
  String _selectedUlb = 'Almora';
  String? _selectedOption = 'all';

  @override
  void initState() {
    super.initState();
    _homeViewModel = Get.isRegistered<HomeViewModel>()
        ? Get.find<HomeViewModel>()
        : Get.put(HomeViewModel());
  }

  @override
  void dispose() {
    super.dispose();
  }


  /// Filters and updates selected ULB when an option is chosen from the grouped dropdown
  void _onDropdownChanged(String? val) {
    setState(() {
      _selectedOption = val;

    });
  }

  /// Builds grouped dropdown options matching the project standards:

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

  /// Dedicated callback method for "Get Report"
  Future<void> _onGetReportPressed() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${context.l10n.ulbProgressReport}: $_selectedUlb (${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')})',
        ),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  /// Finds the currently active [UlbProgressData] for the detailed card
  UlbProgressData _getActiveUlbData(List<UlbProgressData> list) {
    if (list.isEmpty) {
      return UlbProgressData.sampleList[2]; // Almora fallback
    }
    final match = list.firstWhereOrNull(
      (e) =>
          e.ulbName.toLowerCase().contains(_selectedUlb.toLowerCase()) ||
          _selectedUlb.toLowerCase().contains(e.ulbName.toLowerCase()),
    );
    return match ?? list.first;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    final dropdownItems = _buildDropdownItems(context);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CommonAppBar(
        title: strings.ulbProgressReport,
        showBackButton: true,
        onBackTap: () => Get.back(),
      ),
      body: SafeArea(
        child: Obx(() {
          final list = _homeViewModel.ulbList;
          final activeItem = _getActiveUlbData(list);

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // =========================================================
                // 1. Top Section: Modern Filter Card (Dropdown + Date + Get Report)
                // =========================================================
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: colorScheme.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.04),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                prefixIcon: Icons.location_city_rounded,
                                backgroundColor: colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.35),
                                borderColor: colorScheme.outline
                                    .withValues(alpha: 0.2),
                                onChanged: _onDropdownChanged,
                              ),
                            ),

                            const SizedBox(width: 8),

                            // B. Common Date Picker
                            Expanded(
                              flex: 4,
                              child: CommonDatePicker(
                                selectedDate: _selectedDate,
                                onDateSelected: (newDate) {
                                  setState(() {
                                    _selectedDate = newDate;
                                  });
                                },
                                backgroundColor: colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.35),
                                borderColor: colorScheme.outline
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // C. "Get Report" Action Button
                        CommonButton(
                          text: strings.getReport,
                          icon: Icons.query_stats_rounded,
                          height: 44,
                          onPressed: _onGetReportPressed,
                        ),
                      ],
                    ),
                  ),
                ),


                // =========================================================
                // 3. Selected ULB Detailed Telemetry Card (From User Screenshot)
                // =========================================================
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: colorScheme.cardBg,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.18),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow.withValues(alpha: 0.04),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Card Header: ULB Name & Telemetry Active Status
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                activeItem.ulbName.contains(',')
                                    ? activeItem.ulbName.split(',').last.trim()
                                    : activeItem.ulbName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF2E7D32), // Modern forest green from screenshot
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Visual Coverage Gauge Banner
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    strings.coveragePercent,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                  Text(
                                    '${activeItem.coverageDouble}%',
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1E88E5),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: (activeItem.coverageDouble / 100)
                                      .clamp(0.0, 1.0),
                                  minHeight: 6,
                                  backgroundColor: colorScheme.outline
                                      .withValues(alpha: 0.15),
                                  valueColor: const AlwaysStoppedAnimation<Color>(
                                      Color(0xFF2E7D32)),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // 13 Metrics Grid (Matching Screenshot Telemetry Grid)
                        // Row 1: Wards Count & Covered Wards
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: '${strings.wards} (Total)',
                                value: '${activeItem.totalWardsInt}',
                                icon: Icons.holiday_village_rounded,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.coveredWards,
                                value: '${activeItem.coveredWardsCount}',
                                icon: Icons.check_circle_outline_rounded,
                                accentColor: const Color(0xFF2E7D32),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Row 2: Not Covered & Total Vehicles
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.notCovered,
                                value: '${activeItem.notCoveredWardsCount}',
                                icon: Icons.highlight_off_rounded,
                                accentColor: const Color(0xFFE65100),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.totalVehicles,
                                value: '${activeItem.totalVehiclesCount}',
                                icon: Icons.local_shipping_outlined,
                                accentColor: const Color(0xFF1565C0),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Row 3: Active Vehicles & Inactive Vehicles
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.activeVehicles,
                                value: '${activeItem.activeVehiclesCount}',
                                icon: Icons.directions_car_filled_rounded,
                                accentColor: const Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.inactiveVehicles,
                                value: '${activeItem.inactiveVehiclesCount}',
                                icon: Icons.no_crash_rounded,
                                accentColor: const Color(0xFFC62828),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Row 4: Never Sent Data & Reached Ward
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.neverSentData,
                                value: '${activeItem.neverSentDataCount}',
                                icon: Icons.signal_cellular_connected_no_internet_0_bar_rounded,
                                accentColor: const Color(0xFF546E7A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.reachedWard,
                                value: '${activeItem.reachedWardCount}',
                                icon: Icons.tour_rounded,
                                accentColor: const Color(0xFF3949AB),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Row 5: Not Reached & Assigned Route (KM)
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.notReached,
                                value: '${activeItem.notReachedCount}',
                                icon: Icons.near_me_disabled_rounded,
                                accentColor: const Color(0xFFD81B60),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.assignedRoute,
                                value: activeItem.assignedRouteKm.toStringAsFixed(2),
                                icon: Icons.alt_route_rounded,
                                accentColor: const Color(0xFF00838F),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Row 6: Matched Route (KM) & Uncovered Route (KM)
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.matchedRoute,
                                value: activeItem.matchedRouteKm.toStringAsFixed(2),
                                icon: Icons.route_rounded,
                                accentColor: const Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.uncoveredRoute,
                                value: activeItem.uncoveredRouteKm.toStringAsFixed(2),
                                icon: Icons.linear_scale_rounded,
                                accentColor: const Color(0xFFEF6C00),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Row 7: Coverage %
                        Row(
                          children: [
                            Expanded(
                              child: _buildMetricTile(
                                context: context,
                                title: strings.coveragePercent,
                                value: activeItem.wardMappedCoverage.replaceAll('%', '').trim(),
                                icon: Icons.percent_rounded,
                                accentColor: const Color(0xFF6A1B9A),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              ],
            ),
          );
        }),
      ),
    );
  }

  /// Compact, modern metric tile matching the screenshot layout
  Widget _buildMetricTile({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    Color? accentColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = accentColor ?? colorScheme.primary;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color:colorScheme.blue,
            ),
          ),
        ],
      ),
    );
  }
}

/// Backwards compatibility alias
typedef UlbWiseProgressReportScreen = UlbProgressReportScreen;
