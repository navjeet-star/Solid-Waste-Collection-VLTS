import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';

class CommonHeader extends StatelessWidget {
  final String title;
  final int notificationCount;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  const CommonHeader({
    super.key,
    this.title = "App name",
    this.notificationCount = 0,
    this.onProfileTap,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: onProfileTap,
            child: CircleAvatar(
              radius: 24,
              backgroundColor: AppColors.lightBlue,
              child: Icon(Icons.person, color: AppColors.primary, size: 24),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Stack(
            children: [
              IconButton(
                onPressed: onNotificationTap,
                icon: Icon(
                  Icons.notifications,
                  size: 25,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Positioned(
                right: 5,
                top: 3,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.red,
                  ),
                  constraints: BoxConstraints(minWidth: 18, minHeight: 18),
                  child: Center(
                    child: Text(
                      notificationCount > 99
                          ? '99+'
                          : notificationCount.toString(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
