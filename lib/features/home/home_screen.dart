import'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/storage/shared_prefs_service.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/features/home/viewModels/home_view_model.dart';
import 'package:vlts_swc/models/module_item.dart';
import 'package:vlts_swc/models/ulb_model.dart';
import 'package:vlts_swc/features/home/hero_header_content.dart';
import 'package:vlts_swc/features/home/items/dashboard_card_item.dart';
import 'package:vlts_swc/features/home/items/ulb_progress_list_item.dart';
import 'package:vlts_swc/features/home/items/vehicle_stat_card.dart';
import 'package:vlts_swc/common_utils/generic_grid_view.dart';
import 'package:vlts_swc/widgets/common_stat_card.dart';
import 'package:vlts_swc/widgets/side_menu.dart';
import 'package:vlts_swc/widgets/common_bottom_nav_bar.dart';
import 'tabs/complaints_tab.dart';
import 'tabs/reports_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final HomeViewModel homeViewModel = Get.put(HomeViewModel());

  // Stored preference values fetched from SharedPreferences
  bool isFirstLaunch = false;
  bool isLoggedIn = false;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _fetchPreferences();
    homeViewModel.fetchUlbWiseProgress();
  }

  /// Fetches preferences synchronously on screen load without await
  void _fetchPreferences() {
    isFirstLaunch = SharedPrefsService.isFirstLaunch;
    isLoggedIn = SharedPrefsService.isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme
        .of(context)
        .colorScheme;
    const overlap = 24.0;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      backgroundColor: colorScheme.surface,
      extendBody: true,
      bottomNavigationBar: CommonBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: [

             LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  onRefresh: () => homeViewModel.fetchUlbWiseProgress(),
                  color: colorScheme.primary,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Layer 1: Natural-height Hero Header at the top
                          HeroHeaderContent(
                            onProfileTap: () =>
                                _scaffoldKey.currentState?.openDrawer(),
                            onNotificationTap: () =>
                                CommonFunctions.showSnackBar(
                                    context, strings.notificationsClicked),
                          ),

                          // Layer 2: Body card placed ON TOP of header with top curve,
                          // overlap, elevation shadow, and filling all remaining height
                          Transform.translate(
                            offset: const Offset(0, -overlap),
                            child: Container(
                              width: double.infinity,
                              constraints: BoxConstraints(
                                minHeight: constraints.maxHeight * 0.6,
                              ),
                              decoration: BoxDecoration(
                                color: colorScheme.surface,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(32),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.shadow
                                        .withValues(alpha: 0.12),
                                    blurRadius: 18,
                                    offset: const Offset(0, -6),
                                  ),
                                ],
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(18, 20, 18, 96),
                              child: _HomeBodyContent(
                                  onViewAllCategories: () =>
                                      CommonFunctions.showSnackBar(
                                          context, strings.categories)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),

      // Tab 1: Reports
      ReportsTab(
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),

      // // Tab 2: Complaints
      ComplaintsTab(
        onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      //
      // // Tab 3: Profile
      // ProfileTab(
      //   user: currentUser,
      //   onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
      // ),
    ],
  ),
);
  }
}

/// Categories Sheet Content with Trend Card, Header, and Category List
class _HomeBodyContent extends StatefulWidget {
  final VoidCallback onViewAllCategories;

  const _HomeBodyContent({required this.onViewAllCategories});

  @override
  State<_HomeBodyContent> createState() => _HomeBodyContentState();
}

class _HomeBodyContentState extends State<_HomeBodyContent> {
  @override
  Widget build(BuildContext context) {
    final HomeViewModel homeViewModel = Get.find<HomeViewModel>();
    final strings = context.l10n;
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    // Create the dynamic list of ModuleItem objects derived from theme colorScheme
    final List<ModuleItem> moduleList = [
      ModuleItem(
        title: strings.attendanceDashboard,
        icon: Icons.how_to_reg_rounded,
        color: colorScheme.tertiary,
        onTap: () => CommonFunctions.showSnackBar(context, strings.attendanceDashboard),
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.bar_chart_rounded,
        color: colorScheme.tertiary,
        onTap: () =>CommonFunctions.showSnackBar(context, strings.ulbProgressReport) ,
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.pie_chart_rounded,
        color: colorScheme.tertiary,
        onTap: () => CommonFunctions.showSnackBar(context, strings.ulbProgressReport)  ,
      ),
      ModuleItem(
        title: strings.swachhtaAppComplaints,
        icon: Icons.mark_chat_unread_rounded,
        color: colorScheme.tertiary,
        onTap: () =>CommonFunctions.showSnackBar(context, strings.swachhtaAppComplaints)
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Operational Modules Section Header
        Text(
          strings.dashboardModules,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 10),

        // Generic GridView builder used directly in HomeScreen
        GenericGridView<ModuleItem>(
          items: moduleList,
          childAspectRatio: 1.5,
          itemBuilder: (context, module, index) {
            return DashboardCardItem(item: module);
          },
        ),

        const SizedBox(height: 20),

        Text(
          strings.employeeType,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 10),

        // Employee type rows
        Row(
          children: [
            Expanded(
              flex: 1,
              child: CommonStatCard(
                value: '921',
                title: strings.driver,
                accentColor: colorScheme.blue,
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: CommonStatCard(
                value: '875',
                title: strings.helper,
                accentColor: colorScheme.green,
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: CommonStatCard(
                value: '3997',
                title: strings.sanitaryWorker,
                accentColor: colorScheme.red,
                onTap: () {},
              ),
            ),
            Expanded(
              flex: 1,
              child: CommonStatCard(
                value: '346',
                title: strings.others,
                accentColor: colorScheme.yellow,
                onTap: () {},
              ),
            )
          ],
        ),

        const SizedBox(height: 20),

        Text(
          strings.vehicleType,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 10),

        // Vehicle type rows
        Row(
          children: [
            Expanded(
              flex: 1,
              child: VehicleStatCard(
                value: '623',
                title: strings.d2dTipper,
                icon: Icons.local_shipping_rounded,
                accentColor: colorScheme.blue,
                onTap: () => CommonFunctions.showSnackBar(
                  context,
                  '${strings.d2dTipper}: 623',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: VehicleStatCard(
                value: '3',
                title: strings.tractor,
                icon: Icons.agriculture_rounded,
                accentColor: colorScheme.green,
                onTap: () => CommonFunctions.showSnackBar(
                  context,
                  '${strings.tractor}: 3',
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: VehicleStatCard(
                value: '20',
                title: strings.others,
                icon: Icons.commute_rounded,
                accentColor: colorScheme.yellow,
                onTap: () => CommonFunctions.showSnackBar(
                  context,
                  '${strings.others}: 20',
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // ULB-wise Progress Report Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                strings.ulbProgressReportToday,
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: colorScheme.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              strings.viewAll,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: colorScheme.primary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Display Cards (Reactively bound to HomeViewModel.ulbList)
        Obx(() {
          // Uses API list if loaded; falls back to sampleList if empty
          final items = homeViewModel.ulbList.isNotEmpty
              ? homeViewModel.ulbList
              : UlbProgressData.sampleList;

          return Column(
            children: items.asMap().entries.map((entry) {
              final index = entry.key;
              final ulb = entry.value;
              return UlbProgressListItem(
                item: ulb,
                rank: index + 1,
                onTap: () => CommonFunctions.showSnackBar(
                  context,
                  '${ulb.ulbName} • ${strings.score}: ${ulb.score}',
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }
}

/// Backwards-compatibility alias for MainScreen
typedef MainScreen = HomeScreen;
