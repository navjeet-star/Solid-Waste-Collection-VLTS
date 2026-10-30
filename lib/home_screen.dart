import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/widgets/common_header.dart';
import 'package:solid_waste_collection_vlts/widgets/side_menu.dart';
import 'package:solid_waste_collection_vlts/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) {
            return Column(
              children: [
                CommonHeader(
                  title: "",
                  notificationCount: 2,
                  onProfileTap:() {
                    CommonSnackBar.show(
                      context,
                      'Profile clicked',
                    );
                    Scaffold.of(scaffoldContext).openDrawer();
                  },
                  onNotificationTap:() {
                    CommonSnackBar.show(
                      context,
                      'notification clicked',
                    );
                  },
                )
              ],
            );
          }
        ),
      ),
    );
  }
}
