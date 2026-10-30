import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/overview_screen.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/widgets/LanguageSelector.dart';
import 'package:solid_waste_collection_vlts/widgets/common_button.dart';
import 'package:solid_waste_collection_vlts/widgets/common_text.dart';
import 'package:solid_waste_collection_vlts/widgets/common_text_field.dart';
import 'package:solid_waste_collection_vlts/widgets/theme_toggle_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Theme toggle and Language dropdown at top right
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    ThemeToggleButton(),
                    SizedBox(width: 8),
                    LanguageSelector(),
                  ],
                ),

                const SizedBox(height: 60),

                Center(
                  child: Icon(
                    Icons.local_activity_rounded,
                    size: 80,
                    color: colorScheme.primary,
                  ),
                ),

                const SizedBox(height: 30),

                Center(
                  child: Text(
                    strings.welcomeBack,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                Center(
                  child: Text(
                    strings.loginToYourAccount,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                CommonText(text: strings.enterEmail),

                const SizedBox(height: 15),

                CommonTextField(
                  hintText: strings.enterYourEmail,
                  prefixIcon: Icons.email_outlined,
                ),

                const SizedBox(height: 15),

                CommonText(text: strings.enterPassword),

                const SizedBox(height: 15),

                CommonTextField(
                  hintText: strings.enterYourPassword,
                  prefixIcon: Icons.password_outlined,
                  obscureText: true,
                ),

                const SizedBox(height: 25),

                CommonButton(
                  text: strings.login,
                  onPressed: () {
                    CommonSnackBar.show(context, strings.loginSuccessfully);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OverviewScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
