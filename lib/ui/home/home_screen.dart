import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/models/module_item.dart';
import 'package:solid_waste_collection_vlts/ui/home/hero_header_content.dart';
import 'package:solid_waste_collection_vlts/ui/home/module_card_item.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/common_utils/generic_grid_view.dart';
import 'package:solid_waste_collection_vlts/widgets/side_menu.dart';

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
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.45 : 0.08,
                            ),
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

    // Create the dynamic list of ModuleItem objects
    final List<ModuleItem> moduleList = [
      ModuleItem(
        title: strings.attendanceDashboard,
        icon: Icons.how_to_reg_rounded,
        color: const Color(0xFF6366F1),
        onTap: () => CommonSnackBar.show(context, strings.attendanceDashboard),
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.bar_chart_rounded,
        color: const Color(0xFF10B981),
        onTap: () => CommonSnackBar.show(context, strings.ulbProgressReport),
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.pie_chart_rounded,
        color: const Color(0xFFF59E0B),
        onTap: () => CommonSnackBar.show(context, strings.ulbProgressReport),
      ),
      ModuleItem(
        title: strings.swachhtaAppComplaints,
        icon: Icons.mark_chat_unread_rounded,
        color: const Color(0xFFEF4444),
        onTap: () => CommonSnackBar.show(context, strings.swachhtaAppComplaints),
      ),
      ModuleItem(
        title: strings.ulbProgressReport,
        icon: Icons.pie_chart_rounded,
        color: const Color(0xFFF59E0B),
        onTap: () => CommonSnackBar.show(context, strings.ulbProgressReport),
      ),
      ModuleItem(
        title: strings.swachhtaAppComplaints,
        icon: Icons.mark_chat_unread_rounded,
        color: const Color(0xFFEF4444),
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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${moduleList.length} Modules',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Generic GridView builder used directly in HomeScreen
        GenericGridView<ModuleItem>(
          items: moduleList,
          itemBuilder: (context, module, index) {
            return ModuleCardItem(item: module);
          },
        ),
      ],
    );
  }
}

