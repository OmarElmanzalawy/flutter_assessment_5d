import 'dart:io';
import 'package:assesment_5d/constants/app_colors.dart';
import 'package:assesment_5d/view_model/states/add_meal_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final addMealProvider = StateNotifierProvider.autoDispose<AddMealNotifier,AddMealState>((ref)=> AddMealNotifier());

class AddMealNotifier extends StateNotifier<AddMealState>{

  AddMealNotifier() : super(AddMealState());

  Future<void> pickImage() async {
    ImagePicker _picker = ImagePicker();
    try {
      final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
          final _selectedImage = File(pickedImage.path);
          state = state.copyWith(selectedImage: _selectedImage,isImagePicked: true);
      }
    } catch (e) {
      print("error while selecting image");
    }
  }

  void removeImage(){
    state = state.copyWith(selectedImage: null);
  }

  Future<void> selectDate(BuildContext context, TextEditingController dateController) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryOrange,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(DateTime.now()),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryOrange,
              ),
            ),
            child: child!,
          );
        },
      );
      
      if (pickedTime != null) {
        
          final selectedTime = DateTime(
            picked.year,
            picked.month,
            picked.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          state = state.copyWith(selectedDateTime: selectedTime);

          dateController.text = state.formattedTime;
        
      }
    }
  }


}