
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vlts_swc/core/animations/splash_animation.dart';
import 'package:vlts_swc/features/splash/viewModels/splash_view_model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {

  late final SplashAnimation splashAnimation;
  late final SplashViewModel splashViewModel;

  Timer? navigationTimer;

  @override
  void initState() {
    super.initState();

    // Initialize animation.
    splashAnimation = SplashAnimation(vsync: this);
    splashAnimation.start();

    // Get existing ViewModel from GetX binding.
    splashViewModel = Get.find<SplashViewModel>();

    // Navigate after 6 seconds.
    navigationTimer = Timer(
      const Duration(seconds: 5),
          () {
        if (!mounted) return;

        splashViewModel.navigateToNextRoute();
      },
    );
  }

  @override
  void dispose() {
    navigationTimer?.cancel();
    splashAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colorScheme.primary,
              colorScheme.primary.withValues(alpha: 0.8),
              colorScheme.secondary,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Animated Logo
            ScaleTransition(
              scale: splashAnimation.scaleAnimation,
              child: FadeTransition(
                opacity: splashAnimation.fadeAnimation,
                child: Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 25,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.recycling_rounded,
                    size: 75,
                    color: Color(0xFF228B55),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Animated App Name
            SlideTransition(
              position: splashAnimation.slideAnimation,
              child: FadeTransition(
                opacity: splashAnimation.fadeAnimation,
                child: Column(
                  children: [
                    const Text(
                      'VLTS',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 3,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'Solid Waste Collection',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.9),
                        letterSpacing: 1,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Smart Waste Management System',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 60),

            // Loading Indicator
            SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                color: Colors.white,
                backgroundColor:
                Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
