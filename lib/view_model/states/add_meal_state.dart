import 'dart:io';

class AddMealState {
  final File? selectedImage;
  final DateTime selectedDateTime;
  late final String formattedTime;

  AddMealState({this.selectedImage,DateTime? selectedDateTime}) : selectedDateTime = selectedDateTime ?? DateTime.now(){

    formattedTime = '${this.selectedDateTime.day}/${this.selectedDateTime.month}/${this.selectedDateTime.year} ${this.selectedDateTime.hour.toString().padLeft(2, '0')}:${this.selectedDateTime.minute.toString().padLeft(2, '0')}';

  }

  AddMealState copyWith({
    File? selectedImage,
    DateTime? selectedDateTime,
    bool? isImagePicked,
  }){
    return AddMealState(
      selectedImage: selectedImage,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
      );
  }

}