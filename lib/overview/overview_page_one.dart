import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';

class OverviewPageOne extends StatelessWidget {
  const OverviewPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return _OverviewContent(
      icon: Icons.location_city_rounded,
      title: strings.overviewTitle1,
      description: strings.overviewDesc1,
    );
  }
}

class _OverviewContent extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _OverviewContent({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            width: 200,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 100,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 40),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 1.6,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
