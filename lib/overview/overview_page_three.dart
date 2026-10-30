import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';

class OverviewPageThree extends StatelessWidget {
  const OverviewPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.analytics_rounded,
          size: 120,
          color: AppColors.primary,
        ),
        const SizedBox(height: 40),
        Text(
          strings.overviewTitle3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            strings.overviewDesc3,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
