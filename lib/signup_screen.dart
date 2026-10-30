import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/home_screen.dart';
import 'package:solid_waste_collection_vlts/overview_screen.dart';
import 'package:solid_waste_collection_vlts/widgets/CommonSnackBar.dart';
import 'package:solid_waste_collection_vlts/widgets/LanguageSelector.dart';
import 'package:solid_waste_collection_vlts/widgets/common_button.dart';
import 'package:solid_waste_collection_vlts/widgets/common_text.dart';
import 'package:solid_waste_collection_vlts/widgets/common_text_field.dart';
import 'package:solid_waste_collection_vlts/widgets/theme_toggle_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final strings = context.l10n;

    if (_passwordController.text != _confirmPasswordController.text) {
      CommonSnackBar.show(context, strings.passwordsDoNotMatch);
      return;
    }

    CommonSnackBar.show(context, strings.signUpSuccessfully);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Ambient Eco-Green Glow Effects
            Positioned(
              top: -80,
              right: -80,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.primary.withValues(alpha: isDark ? 0.08 : 0.07),
                ),
              ),
            ),
            Positioned(
              top: 240,
              left: -90,
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorScheme.secondary.withValues(alpha: isDark ? 0.05 : 0.05),
                ),
              ),
            ),

            // Main Content ScrollView
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // Top Bar with Back Button, Theme Switcher & Language Selector
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: colorScheme.onSurface,
                            size: 20,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: isDark
                                ? colorScheme.surface
                                : colorScheme.surface.withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.4),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              ThemeToggleButton(),
                              SizedBox(width: 2),
                              LanguageSelector(),
                            ],
                          ),
                        ),

                      ],
                    ),

                    const SizedBox(height: 20),

                    // Header Info
                    Center(
                      child: Column(
                        children: [
                          Container(
                            width: 72,
                            height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  colorScheme.primary,
                                  colorScheme.primary.withValues(alpha: 0.85),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.primary.withValues(alpha: 0.35),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.person_add_rounded,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            strings.createAccount,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            strings.signUpToGetStarted,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    // Sign Up Form Card
                    Container(
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: isDark ? colorScheme.surface : Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.5),
                        ),
                        boxShadow: [
                          if (!isDark)
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Full Name
                          CommonText(
                            text: strings.enterFullName,
                            prefixIcon: Icons.person_outline_rounded,
                          ),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: _nameController,
                            hintText: strings.enterYourFullName,
                            prefixIcon: Icons.badge_outlined,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return strings.enterYourFullName;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Email
                          CommonText(
                            text: strings.enterEmail,
                            prefixIcon: Icons.email_outlined,
                          ),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: _emailController,
                            hintText: strings.enterYourEmail,
                            prefixIcon: Icons.alternate_email_rounded,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return strings.enterYourEmail;
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 16),

                          // Password
                          CommonText(
                            text: strings.enterPassword,
                            prefixIcon: Icons.lock_outline_rounded,
                          ),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: _passwordController,
                            hintText: strings.enterYourPassword,
                            prefixIcon: Icons.key_outlined,
                            obscureText: _obscurePassword,
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return strings.enterYourPassword;
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Confirm Password
                          CommonText(
                            text: strings.enterConfirmPassword,
                            prefixIcon: Icons.lock_outline_rounded,
                          ),
                          const SizedBox(height: 8),
                          CommonTextField(
                            controller: _confirmPasswordController,
                            hintText: strings.enterYourConfirmPassword,
                            prefixIcon: Icons.key_outlined,
                            obscureText: _obscureConfirmPassword,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return strings.enterYourConfirmPassword;
                              }
                              return null;
                            },
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureConfirmPassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: colorScheme.onSurfaceVariant,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPassword = !_obscureConfirmPassword;
                                });
                              },
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Sign Up Button
                          CommonButton(
                            text: strings.signUp,
                            onPressed: _handleSignUp,
                          ),

                          const SizedBox(height: 16),

                          // Already have an account row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                strings.alreadyHaveAccount,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: colorScheme.onSurfaceVariant,
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  minimumSize: Size.zero,
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                                child: Text(
                                  strings.signIn,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

