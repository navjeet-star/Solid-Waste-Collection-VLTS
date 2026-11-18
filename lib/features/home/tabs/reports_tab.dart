import 'package:flutter/material.dart';
import 'package:vlts_swc/common_utils/common_functions.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';

/// Reports Tab view for the Bottom Navigation Bar.
///
/// Fully responsive with Material 3 styling and English/Hindi localization.
class ReportsTab extends StatelessWidget {
  final VoidCallback? onMenuTap;

  const ReportsTab({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: CommonAppBar(
          title: strings.reports,
          showDrawerButton: true,
          onMenuTap: onMenuTap,
        ),
        body: Text("test"),
      ),
    );
  }
}
