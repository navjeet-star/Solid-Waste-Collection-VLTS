import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vlts_swc/app/routes/app_pages.dart';
import 'package:vlts_swc/core/app_locale.dart';
import 'package:vlts_swc/features/overview/view/widgets/overview_page_one.dart';
import 'package:vlts_swc/features/overview/view/widgets/overview_page_three.dart';
import 'package:vlts_swc/features/overview/view/widgets/overview_page_two.dart';
import 'package:vlts_swc/widgets/LanguageSelector.dart';
import 'package:vlts_swc/widgets/common_button.dart';
import 'package:vlts_swc/widgets/theme_toggle_button.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;
  static const int _totalPages = 3;

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    } else {
      _goToHome();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _skipPages() {
    _goToHome();
  }

  void _goToHome() {
    Get.offNamed(Routes.login);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final colorScheme = Theme.of(context).colorScheme;
    final bool isFirstPage = _currentPage == 0;
    final bool isLastPage = _currentPage == _totalPages - 1;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Theme toggle, Language Selector and Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.35),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ThemeToggleButton(),
                        SizedBox(width: 4),
                        LanguageSelector(),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: _skipPages,
                    style: TextButton.styleFrom(
                      foregroundColor: colorScheme.primary,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    ),
                    child: Text(
                      strings.skip,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Overview pages with smooth slide transition
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const BouncingScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  OverviewPageOne(isActive: _currentPage == 0),
                  OverviewPageTwo(isActive: _currentPage == 1),
                  OverviewPageThree(isActive: _currentPage == 2),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Animated page indicator dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _totalPages,
                (index) {
                  final bool isActive = _currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 28 : 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.35),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // Preview and Next buttons with smooth animations
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  // Animated Preview button (slides out / fades disabled on page 1)
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 250),
                    opacity: isFirstPage ? 0.35 : 1.0,
                    child: CommonOutlinedButton(
                      text: strings.preview,
                      width: 110,
                      onPressed: isFirstPage ? null : _previousPage,
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Next / Get Started button with CommonButton
                  Expanded(
                    child: CommonButton(
                      text: isLastPage ? strings.getStarted : strings.next,
                      icon: isLastPage
                          ? Icons.check_circle_outline_rounded
                          : Icons.arrow_forward_rounded,
                      onPressed: _nextPage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
