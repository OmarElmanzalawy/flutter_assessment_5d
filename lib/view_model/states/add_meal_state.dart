import 'dart:io';

class AddMealState {
  final File? selectedImage;
  final DateTime selectedDateTime;
  final bool isImagePicked;
  late final String formattedTime;

  AddMealState({this.selectedImage,this.isImagePicked = false,DateTime? selectedDateTime}) : selectedDateTime = selectedDateTime ?? DateTime.now(){

    formattedTime = '${this.selectedDateTime.day}/${this.selectedDateTime.month}/${this.selectedDateTime.year} ${this.selectedDateTime.hour.toString().padLeft(2, '0')}:${this.selectedDateTime.minute.toString().padLeft(2, '0')}';

  }

  AddMealState copyWith({
    File? selectedImage,
    DateTime? selectedDateTime,
    bool? isImagePicked,
  }){
    return AddMealState(
      selectedImage: selectedImage ?? this.selectedImage,
      selectedDateTime: selectedDateTime ?? this.selectedDateTime,
      isImagePicked: isImagePicked ?? this.isImagePicked
      );
  }

}