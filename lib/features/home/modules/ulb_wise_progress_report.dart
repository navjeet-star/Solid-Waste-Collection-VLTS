import 'package:flutter/material.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/widgets/common_app_bar.dart';

class UlbWiseProgressReportScreen extends StatefulWidget {
  const UlbWiseProgressReportScreen({super.key});

  @override
  State<UlbWiseProgressReportScreen> createState() =>
      _UlbWiseProgressReportScreenState();
}

class _UlbWiseProgressReportScreenState
    extends State<UlbWiseProgressReportScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: CommonAppBar(
        title: strings.ulbProgressReport,
        showBackButton: true,
        onBackTap: () => Navigator.of(context).maybePop(),
      ),
      body: Text("test"),
    );
  }
}
