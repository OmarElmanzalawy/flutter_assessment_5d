import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/widgets/onboarding/onboarding_element.dart';
import 'package:assesment_5d/constants/screen_keys.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends ConsumerWidget {
  
  OnboardingScreen({super.key});

  final PageController _pageController = PageController();

  final isLastPageProvider = StateProvider<bool>((ref) => false);

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final bool isLastPage = ref.watch(isLastPageProvider);
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: [
              OnboardingElement(
                title: 'Stay on top of your nutrition',
                description: 'Track your daily meals and calories with ease, making healthy eating a simple and enjoyable part of your lifestyle.',
                illustration: 'assets/images/diet1.png',
              ),
              OnboardingElement(
                title: 'Organized & Sorted for You',
                description: 'Your meal history neatly organized and easily searchable',
                illustration: 'assets/images/diet_plan.png',
              ),
              OnboardingElement(
                title: 'Hope You Enjoy the App! ',
                description: 'Built with care for 5D. Looking forward to your feedback',
                illustration: 'assets/images/logo.png',
                imageColor: AppColors.primaryOrange,
              ),
            ],
            onPageChanged: (value) {
              value == 2 ? ref.read(isLastPageProvider.notifier).state = true : isLastPage ? ref.read(isLastPageProvider.notifier).state = false : null  ;
            },
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: SmoothPageIndicator(
                    controller: _pageController,
                    count: 3,
                    effect: WormEffect(
                      dotColor: AppColors.lightGray,
                      activeDotColor: AppColors.primaryOrange,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 16,
                    ),
                  ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 48,
            child: Column(
              children: [
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => context.go(ScreenKeys.homeScreen),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppColors.darkGray,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_pageController.page == 2) {
                            context.go(ScreenKeys.homeScreen);
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryOrange,
                          foregroundColor: AppColors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          _pageController.hasClients && _pageController.page == 2
                              ? 'Get Started'
                              : 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}