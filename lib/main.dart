import 'package:assesment_5d/constants/app_theme.dart';
import 'package:assesment_5d/constants/screen_keys.dart';
import 'package:assesment_5d/screens/add_meal_screen.dart';
import 'package:assesment_5d/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final GoRouter _routes = GoRouter(

    initialLocation: ScreenKeys.homeScreen,

    routes: [
      GoRoute(
        path: ScreenKeys.homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: ScreenKeys.addMealScreen,
        builder: (context, state) => AddMealScreen(),
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
