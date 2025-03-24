import 'dart:convert';
import 'package:assesment_5d/models/meal_model.dart';
import 'package:assesment_5d/service/storage_service.dart';
import 'package:assesment_5d/view_model/states/meals_state.dart';
import 'package:assesment_5d/widgets/home/meal_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
final mealsProvider = StateNotifierProvider<MealsNotifier,MealsState>((ref) => MealsNotifier());

class MealsNotifier extends StateNotifier<MealsState>{
  MealsNotifier(): super(MealsState());

  GlobalKey<AnimatedListState>? listKey;

  //TODO FIX SHARED PREFERENCES BUGS

  void setListKey(GlobalKey<AnimatedListState> key) {
    listKey = key;
  }

  //add a meal to the list
  void addMeal(MealModel newMeal)async{
    final pref = await SharedPreferences.getInstance();
    final udpatedMealList = [...state.meals,newMeal]; 
    StorageService.saveMealsToStorage(udpatedMealList);
    state = state.copyWith(meals: udpatedMealList);
    
    listKey?.currentState?.insertItem(
      state.meals.length - 1,
      duration: const Duration(milliseconds: 300),
    );
  }

  //remove a meal from the list
  void removeMeal(MealModel meal)async{
    final pref = await SharedPreferences.getInstance();
    final index = state.meals.indexOf(meal);
    final removedMeal = meal;
    
    listKey?.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: MealTile(mealIndex: index),
      ),
      duration: const Duration(milliseconds: 300),
    );

    final updatedMealList = state.meals.where((element) => element != meal).toList();
    state = state.copyWith(meals: updatedMealList);
    StorageService.saveMealsToStorage(updatedMealList);
  }

  Future<void> loadMeals()async{
    state = state.copyWith(isMealsLoading: true);
    final mealList = await StorageService.getMealsFromStorage();
    
    if (mealList != null) {
      final loadedMeals = mealList.map((meal) =>  MealModel.fromJson(jsonDecode(meal))).toList();
      state = state.copyWith(isMealsLoading: false,meals: loadedMeals);
      
    } else {
      state = state.copyWith(isMealsLoading: false,meals: []);
    }

  }


}