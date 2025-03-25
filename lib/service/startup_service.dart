import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt getIt = GetIt.instance;

void registerSingletons(){
  getIt.registerLazySingleton<StartupService>(()=> StartupService());
}

class StartupService {

  static Future init()async{
    WidgetsFlutterBinding.ensureInitialized();
    registerSingletons();
  }

  static Future<bool> isUserFirstTime()async{
    final prefs = await SharedPreferences.getInstance();
    final isFirstTime = prefs.getBool('isFirstTime');
    if(isFirstTime == null){
      print('user\'s first time');
      await prefs.setBool('isFirstTime', true);
      return true;
    }
    else{
      print('user\'s not first time');
      await prefs.setBool('isFirstTime', false);
      return false;
    }
  }

  static Future<void> LoadMealsFromStorage(WidgetRef ref)async{
    await ref.read(mealsProvider.notifier).loadMeals();
  }

}



