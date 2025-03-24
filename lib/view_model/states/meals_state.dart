import 'package:assesment_5d/models/meal_model.dart';

class MealsState {
  final List<MealModel> meals;
  final bool isMealsLoading;
  //checks if user opened the app for the first time
  final bool isUserFirstTime;
  late final int totalCalories;

  MealsState({
    this.meals = const [],
    this.isMealsLoading = false,
    this.totalCalories = 0,
    this.isUserFirstTime = false,
    }){
    meals.map((meal) => totalCalories += meal.calories);
  }

  MealsState copyWith({
    List<MealModel>? meals,
    bool? isMealsLoading,
  }){
    return MealsState(
      meals: meals ?? this.meals,
      isMealsLoading: isMealsLoading ?? this.isMealsLoading,
    );
  }
}