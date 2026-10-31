import 'package:flutter/material.dart';

/// A reusable, type-safe generic GridView builder for any list of items [T]
class GenericGridView<T> extends StatelessWidget {
  /// The dynamic list of items of type [T]
  final List<T> items;

  /// Builder function returning a Widget for each item
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  /// Number of columns on standard screens (defaults to 2)
  final int crossAxisCount;

  /// Spacing between columns
  final double crossAxisSpacing;

  /// Spacing between rows
  final double mainAxisSpacing;

  /// Width to height aspect ratio of each item
  final double childAspectRatio;

  /// Padding around the grid
  final EdgeInsetsGeometry? padding;

  /// Scroll physics (defaults to NeverScrollableScrollPhysics for nested scroll)
  final ScrollPhysics physics;

  /// Whether the grid should wrap its height (defaults to true)
  final bool shrinkWrap;

  /// Breakpoint width to expand columns for tablets/landscape (defaults to 600)
  final double wideBreakpoint;

  /// Number of columns when width exceeds [wideBreakpoint] (defaults to 4)
  final int wideCrossAxisCount;

  const GenericGridView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 12.0,
    this.mainAxisSpacing = 12.0,
    this.childAspectRatio = 1.05,
    this.padding,
    this.physics = const NeverScrollableScrollPhysics(),
    this.shrinkWrap = true,
    this.wideBreakpoint = 600.0,
    this.wideCrossAxisCount = 4,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Automatically adapt column count based on available width
        final effectiveCrossAxisCount =
            constraints.maxWidth > wideBreakpoint
                ? wideCrossAxisCount
                : crossAxisCount;

        return GridView.builder(
          padding: padding,
          shrinkWrap: shrinkWrap,
          physics: physics,
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: effectiveCrossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemBuilder: (context, index) {
            return itemBuilder(context, items[index], index);
          },
        );
      },
    );
  }
}

