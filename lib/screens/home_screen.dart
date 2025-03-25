import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/constants/screen_keys.dart';
import 'package:assesment_5d/service/startup_service.dart';
import 'package:assesment_5d/utils/oval_buttom_clipper.dart';
import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:assesment_5d/widgets/home/calories_circle.dart';
import 'package:assesment_5d/widgets/home/meal_tile.dart';
import 'package:assesment_5d/widgets/home/sortButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class HomeScreen extends ConsumerStatefulWidget {
  HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref.read(mealsProvider.notifier).setListKey(_listKey);
    WidgetsBinding.instance.addPostFrameCallback((_){
      //for testing only
      // StorageService.clearAll();
      StartupService.LoadMealsFromStorage(ref);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    final mealsState = ref.watch(mealsProvider);
    print("isloading: ${mealsState.isMealsLoading}");
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Column(
        children: [
          ClipPath(
          clipper: OvalBottomClipper(),
          child: Stack(
            children: [
              Container(
              height: size.height * 0.44,
              // height: 380,
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
                              context.push(ScreenKeys.addMealScreen);
                            },
                            child: Icon(Icons.add,color: AppColors.white,size: 30),
                            ),
                        ],
                      )),
                    const SizedBox(height: 30,),
                    const SizedBox(height: 10,),
                    CaloriesCircle(calorieCount: mealsState.totalCalories,),
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
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: mealsState.isMealsLoading  
            ?
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              separatorBuilder: (context, index) => const SizedBox(height: 15,),
              itemBuilder:(context, index) => ShimmerMealTile(),
              )
            // CircularProgressIndicator(color: AppColors.darkGray,)
            // Text("hello")
           : 
           AnimatedList.separated(
            key: _listKey,
            padding: EdgeInsets.zero,
            initialItemCount: mealsState.meals.length + 1,
            separatorBuilder: (context, index, animation) => index <= mealsState.meals.length ? const SizedBox(height: 15,) : const SizedBox(height: 0,),
            removedSeparatorBuilder: (context, index, animation) => SizedBox(),
            itemBuilder: (context, index, animation){
              print("index: $index");
              print("meals length: ${mealsState.meals.length}");
              if(index != mealsState.meals.length && mealsState.meals.isNotEmpty){
                return MealTile(mealIndex: index,model: mealsState.meals[index],);
              }
              //add button
              else{
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: InkWell(
                  // radius: 25,
                  borderRadius: BorderRadius.circular(25),
                  onTap: (){
                    print("click");
                    context.push(ScreenKeys.addMealScreen);
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
          ),
        ),
        ]
      ),
    );
  }
}