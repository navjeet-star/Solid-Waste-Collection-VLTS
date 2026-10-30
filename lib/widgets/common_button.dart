import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';


class CommonButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  CommonButton({
    super.key,
    required this.text,
    this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
              )
          ),
          child: Text(text, style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,),
          )
      ),
    );
  }

}