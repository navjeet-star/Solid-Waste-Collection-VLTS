import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Profile header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              child: Column(),
            ),
          ],
        ),
      ),
    );
  }
}
