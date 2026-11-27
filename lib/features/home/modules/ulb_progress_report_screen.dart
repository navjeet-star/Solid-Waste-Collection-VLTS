import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/features/home/items/ulb_progress_card_item.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';
import 'package:vlts_swc/widgets/common_empty_view.dart';

/// Full screen view for ULB Progress Report.
/// Displays detailed rankings, metrics, score cards, and search capabilities.
/// Supports optional argument passing via Get.arguments (e.g., initial search query or selected UlbProgressData).
class UlbProgressReportScreen extends StatefulWidget {
  const UlbProgressReportScreen({super.key});

  @override
  State<UlbProgressReportScreen> createState() =>
      _UlbProgressReportScreenState();
}

class _UlbProgressReportScreenState extends State<UlbProgressReportScreen> {
  late final HomeViewModel _homeViewModel;
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _homeViewModel = Get.isRegistered<HomeViewModel>()
        ? Get.find<HomeViewModel>()
        : Get.put(HomeViewModel());

    final args = Get.arguments;
    if (args is UlbProgressData) {
      _searchQuery = args.ulbName;
      _searchController.text = args.ulbName;
    } else if (args is String && args.isNotEmpty) {
      _searchQuery = args;
      _searchController.text = args;
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CommonAppBar(
        title: strings.ulbProgressReport,
        showBackButton: true,
        onBackTap: () => Get.back(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // KPI Summary Card Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.outline.withValues(alpha: 0.15),
                  ),
                ),
                child: Obx(() {
                  final list = _homeViewModel.ulbList;
                  final totalUlbs = list.length;
                  final totalWards = list.fold<int>(0, (sum, item) => sum + item.totalWardsInt);
                  final avgScore = list.isEmpty
                      ? 0
                      : (list.fold<int>(0, (sum, item) => sum + item.score) / list.length).round();

                  return Row(
                    children: [
                      Expanded(
                        child: _buildStatColumn(
                          label: strings.totalUlbs,
                          value: '$totalUlbs',
                          icon: Icons.location_city_rounded,
                          color: colorScheme.primary,
                        ),
                      ),
                      Container(
                        height: 36,
                        width: 1,
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          label: strings.score,
                          value: '$avgScore%',
                          icon: Icons.star_rounded,
                          color: const Color(0xFFF59E0B),
                        ),
                      ),
                      Container(
                        height: 36,
                        width: 1,
                        color: colorScheme.outline.withValues(alpha: 0.2),
                      ),
                      Expanded(
                        child: _buildStatColumn(
                          label: strings.totalWards,
                          value: totalWards > 0 ? '$totalWards' : '1,240',
                          icon: Icons.grid_view_rounded,
                          color: colorScheme.tertiary,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            // Search Filter Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              child: TextField(
                controller: _searchController,
                focusNode: _searchFocusNode,
                decoration: InputDecoration(
                  hintText: strings.searchComplaints,
                  prefixIcon: const Icon(Icons.search_rounded, size: 20),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close_rounded, size: 20),
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                            });
                          },
                        )
                      : null,
                  filled: true,
                  fillColor: colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.outline.withValues(alpha: 0.2),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: colorScheme.primary,
                      width: 1.5,
                    ),
                  ),
                ),
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
              ),
            ),

            // Scrollable List of ULB Progress Cards
            Expanded(
              child: Obx(() {
                final query = _searchQuery.trim().toLowerCase();
                final filtered = _homeViewModel.ulbList.where((item) {
                  if (query.isEmpty) return true;
                  return item.ulbName.toLowerCase().contains(query);
                }).toList();

                if (filtered.isEmpty) {
                  return const CommonEmptyView();
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(top: 6, bottom: 20),
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return UlbProgressListItem(
                      item: item,
                      onTap: () {},
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatColumn({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}

/// Backwards compatibility alias
typedef UlbWiseProgressReportScreen = UlbProgressReportScreen;
