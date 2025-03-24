import 'package:assesment_5d/constants/app_enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final sortMealProvider = StateProvider.autoDispose<MealSortOptions?>((ref) => null);