import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/constants/app_enums.dart';
import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Sortbutton extends ConsumerWidget {
  const Sortbutton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sortState = ref.watch(mealsProvider.select((s)=> s.sortOptions));
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: AppColors.primaryOrange,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: DropdownButton(
          elevation: 0,
          iconEnabledColor: AppColors.white,
          underline: const SizedBox(),
          value: sortState,
          hint: Text("Sort by", style: TextStyle(color: AppColors.white)),
          style: TextStyle(color: AppColors.white),
          items: [
            DropdownMenuItem(
              child: Text("Name", style: TextStyle(color: AppColors.darkGray)),
              value: MealSortOptions.name,
            ),
            DropdownMenuItem(
              child: Text(
                "Calories",
                style: TextStyle(color: AppColors.darkGray),
              ),
              value: MealSortOptions.calories,
            ),
            DropdownMenuItem(
              child: Text("Date", style: TextStyle(color: AppColors.darkGray)),
              value: MealSortOptions.date,
            ),
          ],
          selectedItemBuilder: (BuildContext context) {
            return [
              Center(
                child: Text("Name", style: TextStyle(color: AppColors.white)),
              ),
              Center(
                child: Text(
                  "Calories",
                  style: TextStyle(color: AppColors.white),
                ),
              ),
              Center(
                child: Text("Date", style: TextStyle(color: AppColors.white)),
              ),
            ];
          },
          onChanged: (value) {
            ref.read(mealsProvider.notifier).updateSortOption(value);
          },
        ),
      ),
    );
  }
}
