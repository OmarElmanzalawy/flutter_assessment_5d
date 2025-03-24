import 'package:assesment_5d/models/meal_model.dart';
import 'package:assesment_5d/view_model/states/meals_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = StateNotifierProvider<MealsNotifier,MealsState>((ref) => MealsNotifier());

class MealsNotifier extends StateNotifier<MealsState>{
  MealsNotifier(): super(MealsState());

  //add a meal to the list
  void addMeal(MealModel newMeal){
    final udpatedMealList = [...state.meals,newMeal]; 
    state = state.copyWith(meals: udpatedMealList);
  }

  //remove a meal from the list
  void removeMeal(MealModel meal){
    final udpatedMealList = state.meals.where((element) => element != meal).toList();
    state = state.copyWith(meals: udpatedMealList);
  }


}