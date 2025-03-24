import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/models/meal_model.dart';
import 'package:assesment_5d/utils/oval_buttom_clipper.dart';
import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:assesment_5d/widgets/home/calories_circle.dart';
import 'package:assesment_5d/widgets/home/meal_tile.dart';
import 'package:assesment_5d/widgets/home/sortButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final _listKey = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final mealsState = ref.watch(mealsProvider);

    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      // backgroundColor: Colors.grey.shade50,
      body: Column(
        children: [
          ClipPath(
          clipper: OvalBottomClipper(),
          child: Stack(
            // alignment: Alignment.center, 
            children: [
              Container(
              height: 380,
              color: AppColors.primaryOrange,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 60,),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text('Meal Tracker',style: TextStyle(color: AppColors.white,fontSize: 24,fontWeight: FontWeight.bold),),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              print("add click");
                            },
                            child: Icon(Icons.add,color: AppColors.white,size: 30),
                            ),
                        ],
                      )),
                    const SizedBox(height: 30,),
                    const SizedBox(height: 10,),
                    CaloriesCircle(),
                  ],
                ),
              ),
            )
            ]
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 20),
          child: Row(
            children: [
              Text("Today's Calories:",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Spacer(),
              Sortbutton(),
            ],
          ),
        ),
        Expanded(
          child: AnimatedList.separated(
            key: _listKey,
            padding: EdgeInsets.zero,
            initialItemCount: mealsState.meals.length + 1,
            separatorBuilder: (context, index, animation) => index <= mealsState.meals.length ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
            removedSeparatorBuilder: (context, index, animation) => SizedBox(),
            itemBuilder: (context, index, animation){
              print("index: $index");
              if(index < mealsState.meals.length){
                return MealTile(mealIndex: index -1,);
              }
              else{
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: InkWell(
                  // radius: 25,
                  borderRadius: BorderRadius.circular(25),
                  onTap: (){
                    print("click");
                    ref.read(mealsProvider.notifier).addMeal(MealModel(calories: index, name: "Meal $index",date: DateTime.now(),id: UniqueKey().toString()));
                  },
                  child: Container(
                    width: size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey.shade200.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Icon(Icons.add,color: AppColors.darkGray,size: 30,),
                    ),
                  ),
                ),
              );
            }
            },
            ),
        )
        
        ]
      ),
    );
  }
}