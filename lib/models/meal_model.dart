
class MealModel{

  int id;
  String name;
  String category;
  String area;
  String instructions;
  String youtubeLink;
  List<String> ingredients;
  List<String> measures;

  MealModel({required this.id,required this.name,required this.category,required this.area,required this.instructions, required this.youtubeLink,
      required this.ingredients,required this.measures});

  static MealModel fromJson(dynamic json){

    List<String> ingredients = [];
    List<String> measures = [];

    for(var i= 1;i< 20; i++){
      final ingredient = json["strIngredient$i"];
      if(ingredient != null && ingredient.toString().trim().isNotEmpty){
        ingredients.add(ingredient.toString().trim());
      }
    }
    for(var i= 1;i< 20; i++){
      final measure = json["strMeasure$i"];
      if(measure != null && measure.toString().trim().isNotEmpty){
        measures.add(measure.toString());
      }
    }
    
    int id = int.parse(json["idMeal"]);

    String youtubeLink = json["strYoutube"] ?? "";
    var meal = MealModel(id: id, name: json["strMeal"], category: json["strCategory"],area: json["strArea"],instructions: json["strInstructions"], youtubeLink: youtubeLink, ingredients: ingredients, measures: measures);

    return meal;
  }

  @override
  String toString() {
    return 'MealModel{id: $id, name: $name, category: $category, area: $area, instructions: $instructions, youtubeLink: $youtubeLink, ingredients: $ingredients, measures: $measures}';
  }


}