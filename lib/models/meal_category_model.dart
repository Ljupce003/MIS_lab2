

class MealCategoryModel{
  int id;
  String name;
  String imageUrl;
  String description;

  MealCategoryModel.name({required this.id, required this.name, required this.imageUrl, required this.description});

  @override
  String toString() {
    return "Category w id: $id, name: $name, url: $imageUrl, desc: $description";
  }


}