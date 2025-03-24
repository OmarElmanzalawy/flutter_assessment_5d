import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void registerSingletons(){
  getIt.registerLazySingleton<StartupService>(()=> StartupService());
}

class StartupService {

  static Future init()async{
    WidgetsFlutterBinding.ensureInitialized();
    registerSingletons();
  }

  static Future<void> LoadMealsFromStorage(WidgetRef ref)async{
    await ref.read(mealsProvider.notifier).loadMeals();
  }

}



