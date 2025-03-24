
class MealModel {
  final String id;
  final String name;
  final int calories;
  final DateTime date;
  final String? imagePath;

  MealModel({required this.name, required this.calories, required this.date,this.imagePath,required this.id});

  Map<String,dynamic> toJson() => {
      'id': id,
      'name': name,
      'calories': calories,
      'date': date.toIso8601String(),
      'imagePath': imagePath,
    };

  factory MealModel.fromJson(Map<String,dynamic> json) => MealModel(
    id: json['id'],
    name: json['name'],
    calories: json['calories'],
    date: DateTime.parse(json['date']), 
    imagePath: json['imagePath']
  );
}