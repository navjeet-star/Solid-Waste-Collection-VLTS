import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';

/// Centralized, theme-aware Shimmer container.
/// Automatically adapts base and highlight colors to Light and Dark modes.
class AppShimmer extends StatelessWidget {
  final Widget child;
  final Color? baseColor;
  final Color? highlightColor;

  const AppShimmer({
    super.key,
    required this.child,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBase = baseColor ??
        (isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE2E4E8));
    final effectiveHighlight = highlightColor ??
        (isDark ? const Color(0xFF3D3D3D) : const Color(0xFFF4F5F7));

    return Shimmer.fromColors(
      baseColor: effectiveBase,
      highlightColor: effectiveHighlight,
      child: child,
    );
  }
}

/// Reusable rounded rectangular box used inside [AppShimmer] skeletons.
class ShimmerBox extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final EdgeInsetsGeometry? margin;

  const ShimmerBox({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(6)),
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: borderRadius,
      ),
    );
  }
}

/// Shimmer placeholder matching the exact card design of [UlbProgressListItem].
class UlbProgressItemShimmer extends StatelessWidget {
  const UlbProgressItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      elevation: 1,
      color: colorScheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top: ULB Title + Score Badge
            Row(
              children: [
                Expanded(
                  child: ShimmerBox(
                    width: 140,
                    height: 14,
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                ),
                SizedBox(width: 12),
                ShimmerBox(
                  width: 72,
                  height: 22,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Middle: Route Coverage Progress Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ShimmerBox(
                  width: 90,
                  height: 11,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
                ShimmerBox(
                  width: 36,
                  height: 11,
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                ),
              ],
            ),
            SizedBox(height: 6),
            ShimmerBox(
              width: double.infinity,
              height: 6,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            SizedBox(height: 12),

            // Bottom: 3-column metric cards
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: ShimmerBox(
                    height: 42,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  flex: 3,
                  child: ShimmerBox(
                    height: 42,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
                SizedBox(width: 6),
                Expanded(
                  flex: 3,
                  child: ShimmerBox(
                    height: 42,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer list containing multiple [UlbProgressItemShimmer] items.
class UlbProgressListShimmer extends StatelessWidget {
  final int itemCount;

  const UlbProgressListShimmer({
    super.key,
    this.itemCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    return AppShimmer(
      child: Column(
        children: List.generate(
          itemCount,
          (_) => const UlbProgressItemShimmer(),
        ),
      ),
    );
  }
}

/// Shimmer placeholder matching [CommonStatCard] (Employee counts).
class CommonStatCardShimmer extends StatelessWidget {
  const CommonStatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(1),
      child: Card(
        elevation: 1,
        color: colorScheme.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Column(
            children: [
              ShimmerBox(
                width: 42,
                height: 22,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              SizedBox(height: 8),
              ShimmerBox(
                width: 52,
                height: 12,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
              SizedBox(height: 10),
              ShimmerBox(
                width: 18,
                height: 3.5,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              SizedBox(height: 4),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer placeholder matching [VehicleStatCard] (Vehicle counts).
class VehicleStatCardShimmer extends StatelessWidget {
  const VehicleStatCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: Card(
        margin: const EdgeInsets.all(2),
        elevation: 2,
        color: colorScheme.cardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colorScheme.outline.withValues(alpha: 0.35),
            width: 1,
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          child: Column(
            children: [
              ShimmerBox(
                width: 32,
                height: 32,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              SizedBox(height: 8),
              ShimmerBox(
                width: 44,
                height: 20,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              SizedBox(height: 6),
              ShimmerBox(
                width: 60,
                height: 12,
                borderRadius: BorderRadius.all(Radius.circular(3)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shimmer row for Employee Type metrics.
class EmployeeTypeRowShimmer extends StatelessWidget {
  const EmployeeTypeRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: Row(
        children: [
          Expanded(child: CommonStatCardShimmer()),
          Expanded(child: CommonStatCardShimmer()),
          Expanded(child: CommonStatCardShimmer()),
          Expanded(child: CommonStatCardShimmer()),
        ],
      ),
    );
  }
}

/// Shimmer row for Vehicle Type metrics.
class VehicleTypeRowShimmer extends StatelessWidget {
  const VehicleTypeRowShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppShimmer(
      child: Row(
        children: [
          Expanded(child: VehicleStatCardShimmer()),
          Expanded(child: VehicleStatCardShimmer()),
          Expanded(child: VehicleStatCardShimmer()),
        ],
      ),
    );
  }
}

/// Shimmer placeholder matching [DashboardCardItem] (Operational Modules).
class DashboardCardItemShimmer extends StatelessWidget {
  const DashboardCardItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.all(1),
      elevation: 1,
      color: colorScheme.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colorScheme.outline.withValues(alpha: 0.35),
          width: 1,
        ),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ShimmerBox(
              width: 32,
              height: 32,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            ShimmerBox(
              width: 80,
              height: 12,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shimmer placeholder matching [HeroHeaderContent] (Hero Banner, Main Stat, 3-Card Metrics).
class HomeHeaderShimmer extends StatelessWidget {
  const HomeHeaderShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.primary,
      ),
      child: AppShimmer(
        baseColor: Colors.white.withValues(alpha: 0.18),
        highlightColor: Colors.white.withValues(alpha: 0.38),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 38),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Navigation Bar
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left Profile Avatar
                        Container(
                          width: 42,
                          height: 42,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                        // Center App Title
                        const ShimmerBox(
                          width: 160,
                          height: 18,
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        // Right Notification Icon
                        Container(
                          width: 38,
                          height: 38,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Main Stat Section
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Subtitle
                      const ShimmerBox(
                        width: 180,
                        height: 13,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      const SizedBox(height: 8),

                      // Large prominent number
                      const ShimmerBox(
                        width: 210,
                        height: 36,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      const SizedBox(height: 8),

                      // Target summary line
                      const ShimmerBox(
                        width: 140,
                        height: 11,
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                      const SizedBox(height: 18),

                      // 3-Column Translucent Metric Card (ULBs, Wards, Registered Fleet)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.22),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ShimmerBox(width: 55, height: 11),
                                  SizedBox(height: 6),
                                  ShimmerBox(width: 35, height: 18),
                                ],
                              ),
                            ),
                            SizedBox(width: 1, height: 38),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ShimmerBox(width: 55, height: 11),
                                  SizedBox(height: 6),
                                  ShimmerBox(width: 42, height: 18),
                                ],
                              ),
                            ),
                            SizedBox(width: 1, height: 38),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ShimmerBox(width: 65, height: 11),
                                  SizedBox(height: 6),
                                  ShimmerBox(width: 38, height: 18),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shimmer placeholder matching [_HomeBodyContent] (Modules Grid, Employees, Vehicles, ULB List).
class HomeBodyShimmer extends StatelessWidget {
  const HomeBodyShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Dashboard Modules Section
        ShimmerBox(
          width: 150,
          height: 16,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        SizedBox(height: 10),

        // 2x2 Grid matching GenericGridView (childAspectRatio: 1.5)
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: DashboardCardItemShimmer(),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: DashboardCardItemShimmer(),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: DashboardCardItemShimmer(),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.5,
                child: DashboardCardItemShimmer(),
              ),
            ),
          ],
        ),

        SizedBox(height: 20),

        // 2. Employee Type Section
        ShimmerBox(
          width: 120,
          height: 16,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        SizedBox(height: 10),
        EmployeeTypeRowShimmer(),

        SizedBox(height: 20),

        // 3. Vehicle Type Section
        ShimmerBox(
          width: 110,
          height: 16,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        SizedBox(height: 10),
        VehicleTypeRowShimmer(),

        SizedBox(height: 24),

        // 4. ULB Progress Report Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerBox(
              width: 180,
              height: 16,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            ShimmerBox(
              width: 50,
              height: 14,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
          ],
        ),
        SizedBox(height: 12),

        // ULB Progress Cards
        UlbProgressListShimmer(itemCount: 3),
      ],
    );
  }
}

/// Full Screen Shimmer displaying the complete page skeleton while data loads.
class HomeFullScreenShimmer extends StatelessWidget {
  const HomeFullScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    const overlap = 24.0;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(
        parent: BouncingScrollPhysics(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Shimmer Hero Header
          const HomeHeaderShimmer(),

          // 2. Curved Body Card overlapping Header
          Transform.translate(
            offset: const Offset(0, -overlap),
            child: Container(
              width: double.infinity,
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
              padding: const EdgeInsets.fromLTRB(18, 20, 18, 96),
              child: const HomeBodyShimmer(),
            ),
          ),
        ],
      ),
    );
  }
}
