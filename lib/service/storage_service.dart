import 'dart:convert';

import 'package:assesment_5d/models/meal_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {

  static Future<void> saveMealsToStorage(List<MealModel> meals) async {
    final prefs = await SharedPreferences.getInstance();
    final mealList = meals.map((meal) => jsonEncode(meal.toJson())).toList();
    await prefs.setStringList('meals', mealList);
  }

  static Future<List<String>?> getMealsFromStorage() async {
    await Future.delayed(Duration(seconds: 2),(){});
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('meals');
  }

  //for tetsing only
  static Future<void> clearAll()async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  
}