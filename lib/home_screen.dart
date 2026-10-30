import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/widgets/common_header.dart';
import 'package:solid_waste_collection_vlts/widgets/side_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
        child: Builder(
          builder: (scaffoldContext) {
            return Column(
              children: [
                CommonHeader(
                  title: strings.homeScreen,
                  notificationCount: 2,
                  onProfileTap: () {
                    CommonSnackBar.show(
                      context,
                      strings.profileClicked,
                    );
                    Scaffold.of(scaffoldContext).openDrawer();
                  },
                  onNotificationTap: () {
                    CommonSnackBar.show(
                      context,
                      strings.notificationsClicked,
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
