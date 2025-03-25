import 'dart:io';
import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/models/meal_model.dart';
import 'package:assesment_5d/view_model/providers/add_meal_provider.dart';
import 'package:assesment_5d/view_model/providers/meals_provider.dart';
import 'package:assesment_5d/widgets/add_meal/rounded_textField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddMealScreen extends ConsumerWidget {
  AddMealScreen({super.key});

   final TextEditingController _mealController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final Size size = MediaQuery.sizeOf(context);
    print('rebuild');
    final addMealState = ref.watch(addMealProvider);

    final selectedImage = addMealState.selectedImage;

    if (_dateController.text.isEmpty) {
      _dateController.text = addMealState.formattedTime;
    }
    
    return Scaffold(
      // extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: AppColors.primaryOrange,iconTheme: IconThemeData(color: AppColors.white),title: Text("Add a meal",style: TextStyle(color: Colors.white),),),
        body: Form(
          key: _formKey,
          child: Column(
          children: [
            GestureDetector(
              onTap: selectedImage != null ? null : () async{
                await ref.read(addMealProvider.notifier).pickImage();
              },
              child: Container(
                margin: EdgeInsets.all(20),
                height: size.height * 0.2,
                decoration: BoxDecoration(
                  color: selectedImage != null ? Colors.transparent : AppColors.primaryOrange,
                  borderRadius: BorderRadius.circular(12),
                  image: selectedImage != null
                    ? DecorationImage(
                        image: FileImage(selectedImage),
                        fit: BoxFit.cover,
                      )
                    : null,
                ),
                child: selectedImage == null
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 10,),
                          Icon(Icons.add_a_photo_outlined, color: AppColors.white, size: 70,),
                          const SizedBox(height: 12,),
                          Text("Click to upload photo", style: TextStyle(color: AppColors.white, fontSize: 20, fontWeight: FontWeight.w500),),
                        ],
                      ),
                    )
                  : Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(), // Empty container to ensure stack has content
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.7),
                            radius: 18,
                            child: IconButton(
                              icon: Icon(Icons.close, size: 18, color: Colors.black),
                              onPressed: () {
                                  ref.read(addMealProvider.notifier).removeImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
            const SizedBox(height: 22,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text("Meal Name: ",style: TextStyle(fontSize: 18,),),
                Spacer(flex: 1,),
                Expanded(flex: 12,child: RoundedTextfield(
                  hintText: "Sushi",
                  controller: _mealController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Meal name cannot be empty';
                    }
                    return null;
                  },
                )),
                Spacer(flex: 1,)
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text("Calories: ",style: TextStyle(fontSize: 18,),),
                Spacer(flex: 1,),
                Expanded(flex: 12,
                child: RoundedTextfield(
                  hintText: "Calories",
                  controller: _caloriesController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Calories cannot be empty';
                    }
                    final calories = int.tryParse(value);
                    if (calories == null) {
                      return 'Please enter a valid number';
                    }
                    if (calories <= 0) {
                      return 'Calories must be greater than zero';
                    }
                    return null;
                  },
                  )
                ),
                Spacer(flex: 1,),
              ],
            ),
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              children: [
                Text("Date: ",style: TextStyle(fontSize: 18,),),
                Spacer(flex: 1,),
                Expanded(flex: 12,
                  child: GestureDetector(
                    onTap: () async => await ref.read(addMealProvider.notifier).selectDate(context,_dateController),
                    child: AbsorbPointer(
                      child: RoundedTextfield(
                        hintText: "Select date and time",
                        controller: _dateController,
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Date cannot be empty';
                          }
                          return null;
                        },
                        suffixIcon: Icon(Icons.calendar_today, color: AppColors.primaryOrange),
                      ),
                    ),
                  ),
                ),
                Spacer(flex: 1,),
              ],
            ),
          ),
          const SizedBox(height: 25,),
          SizedBox(
            width: size.width * 0.8,
            child: ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  
                  final String mealName = _mealController.text;
                  final int calories = int.parse(_caloriesController.text);
                  final String? imagePath = selectedImage?.path;
                  
                  final newMeal = MealModel(
                    id: UniqueKey().toString(),
                    name: mealName,
                    calories: calories,
                    date: addMealState.selectedDateTime,
                    imagePath: imagePath,
                  );
                  
                  // Add the meal to the provider
                  ref.read(mealsProvider.notifier).addMeal(newMeal);

                  Future.delayed(Duration(milliseconds: 100),(){
                    context.pop(context);
                  });
                  
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppColors.primaryOrange),
                foregroundColor: WidgetStatePropertyAll(AppColors.white),
                iconColor: WidgetStatePropertyAll(AppColors.white),
                elevation: WidgetStatePropertyAll(0),
              ),
              icon: Icon(Icons.restaurant),
               label: Text("Add Meal")
               ),
          )
          ],
        ),
      ),
      );
  }
  }


