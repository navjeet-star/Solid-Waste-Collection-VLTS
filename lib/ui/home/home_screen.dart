import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/ui/home/hero_header_content.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        // Waste Categories Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              strings.categories,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.onSurface,
              ),
            ),
            GestureDetector(
              onTap: onViewAllCategories,
              child: Text(
                strings.viewAll,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 14),

        // Category 1: Wet / Organic Waste
        _CategoryItem(
          icon: Icons.compost_rounded,
          iconColor: const Color(0xFF10B981),
          iconBgColor: const Color(0xFF10B981).withValues(alpha: 0.12),
          title: strings.wetWasteTitle,
          subtitle: strings.wetWasteSubtitle,
          weight: '1,420.5 MT',
          percentage: '60.5%',
          progress: 0.605,
          progressColor: const Color(0xFF10B981),
        ),

        const SizedBox(height: 12),

        // Category 2: Dry / Recyclable Waste
        _CategoryItem(
          icon: Icons.recycling_rounded,
          iconColor: const Color(0xFF3B82F6),
          iconBgColor: const Color(0xFF3B82F6).withValues(alpha: 0.12),
          title: strings.dryWasteTitle,
          subtitle: strings.dryWasteSubtitle,
          weight: '682.3 MT',
          percentage: '29.1%',
          progress: 0.291,
          progressColor: const Color(0xFF3B82F6),
        ),

        const SizedBox(height: 12),

        // Category 3: Hazardous & Sanitary
        _CategoryItem(
          icon: Icons.warning_amber_rounded,
          iconColor: const Color(0xFFF59E0B),
          iconBgColor: const Color(0xFFF59E0B).withValues(alpha: 0.12),
          title: strings.hazardousWasteTitle,
          subtitle: strings.hazardousWasteSubtitle,
          weight: '164.8 MT',
          percentage: '7.0%',
          progress: 0.07,
          progressColor: const Color(0xFFF59E0B),
        ),

        const SizedBox(height: 12),

        // Category 4: Inert & Construction Debris
        _CategoryItem(
          icon: Icons.foundation_rounded,
          iconColor: const Color(0xFF14B8A6),
          iconBgColor: const Color(0xFF14B8A6).withValues(alpha: 0.12),
          title: strings.inertWasteTitle,
          subtitle: strings.inertWasteSubtitle,
          weight: '81.0 MT',
          percentage: '3.4%',
          progress: 0.034,
          progressColor: const Color(0xFF14B8A6),
        ),
      ],
    );
  }
}

/// Category Item Row with Icon, Titles, Weight, Percentage, and Progress Bar
class _CategoryItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final String weight;
  final String percentage;
  final double progress;
  final Color progressColor;

  const _CategoryItem({
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.weight,
    required this.percentage,
    required this.progress,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.22),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 11,
                        color: colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    weight,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    percentage,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: iconColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 4,
              backgroundColor: progressColor.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
            ),
          ),
        ],
      ),
    );
  }
}
