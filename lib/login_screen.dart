import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_colors.dart';
import 'package:solid_waste_collection_vlts/overview_screen.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/widgets/LanguageSelector.dart';
import 'package:solid_waste_collection_vlts/l10n/app_localizations.dart';
import 'package:solid_waste_collection_vlts/widgets/common_button.dart';
import 'package:solid_waste_collection_vlts/widgets/common_text.dart';
import 'package:solid_waste_collection_vlts/widgets/common_text_field.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      body:
      SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.white, // White
                AppColors.verLightBlue, // Very light blue
                AppColors.lightBlue, // Light blue
              ],
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Language dropdown at the top
                  const Align(
                    alignment: Alignment.centerRight,
                    child: LanguageSelector(),
                  ),

                  const SizedBox(height: 100),
        
                  const Center(
                    child: Icon(
                      Icons.local_activity_rounded,
                      size: 80,
                      color: AppColors.white,
                    ),
                  ),
        
                  const SizedBox(height: 30),
        
                  Center(
                    child: Text(
                      strings.welcomeBack,
                      style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
        
                  const SizedBox(height: 15),
        
                  Center(
                    child: Text(
                      strings.loginToYourAccount,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
        
                  const SizedBox(height: 30),
        
                  CommonText(text: strings.enterEmail),
        
                  const SizedBox(height: 15),
        
                  CommonTextField(
                    hintText:strings.enterYourEmail ,
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
                      CommonSnackBar.show(context, "Login successfully");
        
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
      ),
    );
  }
}
