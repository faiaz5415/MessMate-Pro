import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../auth/sign_in_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_IntroPage> _pages = const [
    _IntroPage(
      icon: Icons.restaurant_menu_outlined,
      title: 'Manage your mess smartly',
      subtitle: 'Meals, costs, and members in one place',
      color: AppColors.primary,
    ),
    _IntroPage(
      icon: Icons.calendar_today_outlined,
      title: 'Track meals without confusion',
      subtitle: 'Day & night meals with guest support',
      color: AppColors.orange,
    ),
    _IntroPage(
      icon: Icons.payments_outlined,
      title: 'Clear costs, no arguments',
      subtitle: 'Automatic calculation for everyone',
      color: AppColors.success,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _navigateToSignIn() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const SignInScreen(),
      ),
    );
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToSignIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// SKIP BUTTON
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(AppStyles.spaceMedium),
                child: TextButton(
                  onPressed: _navigateToSignIn,
                  child: const Text('Skip'),
                ),
              ),
            ),

            /// PAGE VIEW
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _IntroPageWidget(page: _pages[index]);
                },
              ),
            ),

            /// PAGE INDICATOR
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppStyles.spaceLarge,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                      (index) => _PageIndicator(
                    isActive: index == _currentPage,
                  ),
                ),
              ),
            ),

            /// BOTTOM BUTTON
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppStyles.spaceLarge,
                0,
                AppStyles.spaceLarge,
                AppStyles.spaceLarge,
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  child: Text(
                    _currentPage == _pages.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// INTRO PAGE DATA MODEL
/// ------------------------------------------------------------
class _IntroPage {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _IntroPage({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });
}

/// ------------------------------------------------------------
/// INTRO PAGE WIDGET
/// ------------------------------------------------------------
class _IntroPageWidget extends StatelessWidget {
  final _IntroPage page;

  const _IntroPageWidget({
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppStyles.spaceXLarge,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// ICON
          Container(
            padding: const EdgeInsets.all(AppStyles.spaceXLarge),
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              page.icon,
              size: 80,
              color: page.color,
            ),
          ),

          const SizedBox(height: AppStyles.spaceXLarge),

          /// TITLE
          Text(
            page.title,
            style: AppStyles.heading1.copyWith(
              fontSize: 26,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppStyles.spaceMedium),

          /// SUBTITLE
          Text(
            page.subtitle,
            style: AppStyles.bodyLarge.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// PAGE INDICATOR DOT
/// ------------------------------------------------------------
class _PageIndicator extends StatelessWidget {
  final bool isActive;

  const _PageIndicator({
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isActive ? 24 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? AppColors.primary : AppColors.border,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
