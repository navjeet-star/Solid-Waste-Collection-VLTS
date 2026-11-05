import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/models/module_item.dart';
import 'package:vlts_swc/features/home/hero_header_content.dart';
import 'package:vlts_swc/features/home/module_card_item.dart';
import 'package:vlts_swc/widgets/CommonSnackBar.dart';
import 'package:vlts_swc/common_utils/generic_grid_view.dart';
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
                    // onProfileTap: () => _scaffoldKey.currentState?.openDrawer(),
                    onProfileTap:() {},
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
class _HomeBodyContent extends StatelessWidget {
  final VoidCallback onViewAllCategories;

  const _HomeBodyContent({required this.onViewAllCategories});

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
        Row(
          children: [
            Expanded(
              child: Text(
                strings.dashboardModules,
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
          ],
        ),

        const SizedBox(height: 12),

        // Generic GridView builder used directly in HomeScreen
        GenericGridView<ModuleItem>(
          items: moduleList,
          childAspectRatio: 1.95,
          itemBuilder: (context, module, index) {
            return ModuleCardItem(item: module);
          },
        ),

        const SizedBox(height: 12),

        Text(
          strings.employeeType,
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )

      ],
    );
  }
}

