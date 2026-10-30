import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';

class CommonText extends StatelessWidget {
  final String text;
  final IconData? prefixIcon;

  const CommonText({super.key, required this.text, this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (prefixIcon != null) ...[
          Row(
            children: [
              Icon(prefixIcon, size: 20, color: AppColors.textPrimary),
              SizedBox(width: 10)
            ],
          ),
        ],
        Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
