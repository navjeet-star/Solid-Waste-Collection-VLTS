import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/core/theme/CustomColorScheme.dart';

/// Reusable AppBar with static height and configurable actions:
/// - Static height: defaults to [defaultHeight] (56.0) or custom static [height]
/// - Drawer / Menu button (toggleable via [showDrawerButton] or [onMenuTap])
/// - Back button (toggleable via [showBackButton] or [onBackTap])
/// - Configurable trailing [actions], [titleWidget], and Material 3 theme colors.
class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Static default height for the AppBar
  static const double defaultHeight = 56.0;

  final String? title;
  final bool centerTitle;
  final bool showBackButton;
  final bool showDrawerButton;
  final VoidCallback? onBackTap;
  final VoidCallback? onMenuTap;
  final double height;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    this.title,
    this.centerTitle = true,
    this.showBackButton = false,
    this.showDrawerButton = false,
    this.onBackTap,
    this.onMenuTap,
    this.height = defaultHeight,
    this.bottom,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    Widget? effectiveLeading;
    if (showBackButton) {
      effectiveLeading = IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: colorScheme.onSurface),
        tooltip: MaterialLocalizations
            .of(context)
            .backButtonTooltip,
        onPressed: onBackTap ?? () => Get.back(),
      );
    } else if (showDrawerButton || onMenuTap != null) {
      effectiveLeading = IconButton(
        icon: Icon(Icons.menu_rounded, color: colorScheme.onSurface),
        tooltip: MaterialLocalizations
            .of(context)
            .openAppDrawerTooltip,
        onPressed: onMenuTap ?? () => Scaffold.maybeOf(context)?.openDrawer(),
      );
    }

    return AppBar(
      toolbarHeight: 50,
      backgroundColor: colorScheme.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      centerTitle: centerTitle,
      automaticallyImplyLeading: false,
      leading: effectiveLeading,
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: colorScheme.textDesc,
              ),
            )
          : null,
      actions: actions,
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(
        height + (bottom?.preferredSize.height ?? 0.0),
      );

}
