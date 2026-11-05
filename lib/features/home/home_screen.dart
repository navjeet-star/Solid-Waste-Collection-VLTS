import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';
import 'package:vlts_swc/models/module_item.dart';
import 'package:vlts_swc/models/ulb_progress_item.dart';
import 'package:vlts_swc/features/home/hero_header_content.dart';
import 'package:vlts_swc/features/home/items/dashboard_card_item.dart';
import 'package:vlts_swc/features/home/items/ulb_progress_list_item.dart';
import 'package:vlts_swc/features/home/items/vehicle_stat_card.dart';
import 'package:vlts_swc/widgets/CommonSnackBar.dart';
import 'package:vlts_swc/common_utils/generic_grid_view.dart';
import 'package:vlts_swc/widgets/common_stat_card.dart';
import 'package:vlts_swc/widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    const overlap = 24.0;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      backgroundColor: colorScheme.surface,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Layer 1: Natural-height Hero Header at the top
                  HeroHeaderContent(
                    onProfileTap: () => _scaffoldKey.currentState?.openDrawer(),
                    onNotificationTap: () => CommonSnackBar.show(
                      context,
                      strings.notificationsClicked,
                    ),
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
                            color: colorScheme.shadow.withValues(alpha: 0.12),
                            blurRadius: 18,
                            offset: const Offset(0, -6),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(18, 20, 18, 36),
                      child: _HomeBodyContent(
                        onViewAllCategories: () =>
                            CommonSnackBar.show(context, strings.categories),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
  bool _isTableView = false;

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    // Create the dynamic list of ModuleItem objects derived from theme colorScheme
    final List<ModuleItem> moduleList = [
      ModuleItem(
        title: strings.attendanceDashboard,
        icon: Icons.how_to_reg_rounded,
        color: colorScheme.tertiary,
        onTap: () => CommonSnackBar.show(context, strings.attendanceDashboard),
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.bar_chart_rounded,
        color: colorScheme.tertiary,
        onTap: () => CommonSnackBar.show(context, strings.ulbProgressReport),
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.pie_chart_rounded,
        color: colorScheme.tertiary,
        onTap: () => CommonSnackBar.show(context, strings.ulbProgressReport),
      ),
      ModuleItem(
        title: strings.swachhtaAppComplaints,
        icon: Icons.mark_chat_unread_rounded,
        color: colorScheme.tertiary,
        onTap: () => CommonSnackBar.show(context, strings.swachhtaAppComplaints),
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
                onTap: () => CommonSnackBar.show(
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
                onTap: () => CommonSnackBar.show(
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
                onTap: () => CommonSnackBar.show(
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

        // Display Cards
          ...UlbProgressItem.sampleList.map((ulb) {
            return UlbProgressListItem(
              item: ulb,
              onTap: () => CommonSnackBar.show(
                context,
                '${ulb.ulbName} • ${strings.score}: ${ulb.score}',
              ),
            );
          }),
      ],
    );
  }
}
