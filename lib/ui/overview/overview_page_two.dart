import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';

class OverviewPageTwo extends StatelessWidget {
  final bool isActive;

  const OverviewPageTwo({
    super.key,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 1),

          // Illustration with Zoom-in / Scale Animation
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.85, end: isActive ? 1.0 : 0.85),
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Opacity(
                  opacity: ((scale - 0.85) / 0.15).clamp(0.0, 1.0),
                  child: child,
                ),
              );
            },
            child: const _SbmManagementIllustration(),
          ),

          const SizedBox(height: 36),

          // Fade-in animated Title & Description
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: isActive ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOut,
            builder: (context, opacity, child) {
              return Opacity(
                opacity: opacity,
                child: Transform.translate(
                  offset: Offset(0, 16 * (1 - opacity)),
                  child: child,
                ),
              );
            },
            child: Column(
              children: [
                // SBM Tag Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.recycling_rounded,
                        size: 14,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        strings.swachhBharatMission,
                        style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Title
                Text(
                  strings.overviewTitle2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onSurface,
                    letterSpacing: -0.4,
                    height: 1.3,
                  ),
                ),

                const SizedBox(height: 14),

                // Description
                Text(
                  strings.overviewDesc2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

/// Illustration for SBM Waste Collection Management System:
/// Displays the custom isometric artwork depicting Swachh Bharat Mission smart
/// waste segregation, digital dashboard metrics, eco-friendly green city, and electric collection truck.
class _SbmManagementIllustration extends StatelessWidget {
  const _SbmManagementIllustration();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: 290,
      height: 240,
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.35)
                : colorScheme.primary.withValues(alpha: 0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/sbm_waste_management.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Center(
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 48,
                    color: colorScheme.outline,
                  ),
                );
              },
            ),
            // Floating Smart Sanitation Badge
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark
                      ? colorScheme.surface.withValues(alpha: 0.88)
                      : Colors.white.withValues(alpha: 0.92),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.3),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.energy_savings_leaf_rounded,
                      color: colorScheme.primary,
                      size: 12,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      strings.smartSanitation,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
