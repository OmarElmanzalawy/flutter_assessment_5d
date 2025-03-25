import 'package:assesment_5d/constants/app_theme.dart';
import 'package:assesment_5d/constants/screen_keys.dart';
import 'package:assesment_5d/screens/add_meal_screen.dart';
import 'package:assesment_5d/screens/home_screen.dart';
import 'package:assesment_5d/screens/onboarding_screen.dart';
import 'package:assesment_5d/service/startup_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() async{
  await StartupService.init();

  //for testing purposes only
  // await StorageService.clearAll();

  final isFirstTime = await StartupService.isUserFirstTime();
  runApp(ProviderScope(child: MainApp(isUserFirstTime: isFirstTime,)));
  
}

class MainApp extends StatelessWidget {

  final bool isUserFirstTime;

  MainApp({super.key, required this.isUserFirstTime});

  late final GoRouter _routes = GoRouter(

    initialLocation: isUserFirstTime ? ScreenKeys.onBoardingScreen : ScreenKeys.homeScreen,

    routes: [
      GoRoute(
        path: ScreenKeys.homeScreen,
        pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: HomeScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
      ),
      GoRoute(
        path: ScreenKeys.addMealScreen,
        builder: (context, state) => AddMealScreen(),
      ),
      GoRoute(
        path: ScreenKeys.onBoardingScreen,
        builder: (context, state) => OnboardingScreen(),
      ),
    ]
    );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _routes,
      theme: AppTheme.themeData
    );
  }
}
