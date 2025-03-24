import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MealTile extends ConsumerWidget {
  const MealTile({super.key,required this.mealIndex});

  final int mealIndex;

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final mealState = ref.read(mealsProvider);
    final Size size = MediaQuery.sizeOf(context);
    return Container(
      width: size.width * 0.9,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50.withOpacity(0.35),
        borderRadius: BorderRadius.circular(12),
        ),
      child: Container(
        // color: Colors.red,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              width: size.width * 0.3,
              height: size.height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                // color: Colors.red,
                image: DecorationImage(
                  image: AssetImage('assets/images/burger1.jpg',),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Text('Smashed Burger',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                      const Spacer(),
                      InkWell(
                        onTap: (){
                          ref.read(mealsProvider.notifier).removeMeal(mealState.meals[mealIndex]);
                        },
                        child: Icon(Icons.delete,color: Colors.redAccent,),
                        ),
                        const SizedBox(width: 8,)
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Text('1 hour ago',style: TextStyle(color: AppColors.darkGray),),
                  Spacer(),
                  Row(
                    children: [
                      Spacer(),
                      Text("200 Calories",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: AppColors.primaryOrange),),
                      const SizedBox(width: 10,),
                    ],
                  ),
                  const SizedBox(height: 15)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}