import 'package:assesment_5d/constants/app_colors.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class CaloriesCircle extends StatelessWidget {
  const CaloriesCircle({super.key, required this.calorieCount});

  final int calorieCount;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
                      borderType: BorderType.Circle,
                      strokeWidth: 5,
                      color: AppColors.white,
                      dashPattern: [4,12],
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TweenAnimationBuilder<int>(
                              duration: Duration(milliseconds: 300),
                              tween: IntTween(begin: 0,end: calorieCount),
                              builder: (context,value,child){
                                return Text('$value',style: TextStyle(color: AppColors.white,fontSize: 40,fontWeight: FontWeight.bold),);
                              } 
                              ),
                              Text("Calories",style: TextStyle(fontSize: 16,color: AppColors.white),
                              ),
                          ],
                        ),
                      ),
                    );
  }
}