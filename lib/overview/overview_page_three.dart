import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';

class OverviewPageThree extends StatelessWidget {
  const OverviewPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.analytics_rounded,
          size: 120,
          color: AppColors.primary,
        ),
        SizedBox(height: 40),
        Text(
          'Track Your Progress',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 28),
          child: Text(
            'Stay updated with reports, notifications, and important information.',
            textAlign: TextAlign.center,
            style: TextStyle(
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