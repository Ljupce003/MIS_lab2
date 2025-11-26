

class CategoryModel{
  int id;
  String name;
  String imageUrl;
  String description;

  CategoryModel({required this.id, required this.name, required this.imageUrl, required this.description});

  @override
  String toString() {
    return "Category w id: $id, name: $name, url: $imageUrl, desc: $description";
  }

  static CategoryModel fromJson(dynamic json){
    return CategoryModel(id: int.parse(json['idCategory']),name: json['strCategory'],imageUrl: json['strCategoryThumb'],description: json['strCategoryDescription']);
  }


}