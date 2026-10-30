import 'package:flutter/material.dart';
import 'package:solid_waste_collection_vlts/core/app_locale.dart';
import 'package:solid_waste_collection_vlts/home_screen.dart';
import 'package:solid_waste_collection_vlts/overview/overview_page_one.dart';
import 'package:solid_waste_collection_vlts/overview/overview_page_three.dart';
import 'package:solid_waste_collection_vlts/overview/overview_page_two.dart';
import 'package:solid_waste_collection_vlts/widgets/theme_toggle_button.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<Widget> _pages = const [
    OverviewPageOne(),
    OverviewPageTwo(),
    OverviewPageThree(),
  ];

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _goToHome();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipPages() {
    _goToHome();
  }

  void _goToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
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
    final bool isLastPage = _currentPage == _pages.length - 1;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar: Theme toggle and Skip button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skipPages,
                    child: Text(
                      strings.skip,
                      style: TextStyle(
                        fontSize: 16,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Overview pages
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: _pages,
              ),
            ),

            const SizedBox(height: 20),

            // Dots: one for every page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) {
                  final bool isActive = _currentPage == index;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 8,
                    width: isActive ? 24 : 8,
                    decoration: BoxDecoration(
                      color: isActive
                          ? colorScheme.primary
                          : colorScheme.outline.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 28),

            // Preview and Next buttons
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Row(
                children: [
                  // Preview button
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isFirstPage ? null : _previousPage,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: colorScheme.primary,
                        minimumSize: const Size(0, 52),
                        side: BorderSide(
                          color: isFirstPage
                              ? colorScheme.outline.withValues(alpha: 0.3)
                              : colorScheme.primary,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(strings.preview),
                    ),
                  ),

                  const SizedBox(width: 16),

                  // Next / Get Started button
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        minimumSize: const Size(0, 52),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        isLastPage ? strings.getStarted : strings.next,
                      ),
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
