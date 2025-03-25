import 'package:flutter/material.dart';
import 'package:assesment_5d/constants/app_colors.dart';

class OnboardingElement extends StatelessWidget {
  final String title;
  final String description;
  final String illustration;
  final Color? imageColor;

  const OnboardingElement({
    super.key,
    required this.title,
    required this.description,
    required this.illustration,
    this.imageColor,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width,
            height: size.height * 0.6,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Image.asset(illustration, fit: BoxFit.contain,color: imageColor,),
              ),
            ),
          ),
          // const SizedBox(height: 48),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryOrange,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.darkGray,
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}