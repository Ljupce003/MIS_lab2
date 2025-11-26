

class MealByCategoryModel{
  String name;
  String imageUrl;
  int mealId;

  MealByCategoryModel({required this.name, required this.imageUrl, required this.mealId});

  @override
  String toString() {
    return 'MealByCategoryModel{name: $name, imageUrl: $imageUrl, mealId: $mealId}';
  }

  static MealByCategoryModel fromJson(dynamic json){
    return MealByCategoryModel(
      name: json["strMeal"],
      imageUrl: json["strMealThumb"],
      mealId: int.parse(json["idMeal"]),
    );
  }


}