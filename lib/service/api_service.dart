import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mis_lab2/models/category_model.dart';
import 'package:mis_lab2/models/meal_by_category_model.dart';
import 'package:mis_lab2/models/meal_model.dart';

class ApiService {
  static Future<List<CategoryModel>> fetchMealCategories() async {
    List<CategoryModel> categoryList = [];

    final categoriesResponse = await http.get(
      Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"),
    );

    if (categoriesResponse.statusCode == 200) {
      final categoriesData = json.decode(categoriesResponse.body);
      List<dynamic> categoriesListData = categoriesData['categories'];

      for (var i = 0; i < categoriesListData.length; i++) {
        categoryList.add(CategoryModel.fromJson(categoriesListData[i]));
      }
    }

    return categoryList;
  }

  static Future<List<MealByCategoryModel>> fetchMealsByCategory(
    String categoryName,
  ) async {
    List<MealByCategoryModel> meals = [];

    final mealsByCatResponse = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/filter.php?c=$categoryName"));

    if (mealsByCatResponse.statusCode == 200) {
      final mealsByCatData = json.decode(mealsByCatResponse.body);
      List<dynamic> mealsListData = mealsByCatData['meals'];

      for (var i = 0; i < mealsListData.length; i++) {
        // meals.add(
        //   MealByCategoryModel(
        //     name: mealsListData[i]["strMeal"],
        //     imageUrl: mealsListData[i]["strMealThumb"],
        //     mealId: int.parse(mealsListData[i]["idMeal"]),
        //   ),
        // );
        meals.add(MealByCategoryModel.fromJson(mealsListData[i]));
      }
    }

    return meals;
  }

  static Future<List<MealByCategoryModel>> filterMealsByName(
      String categoryName,String queryName
      ) async {
    List<MealByCategoryModel> meals = [];

    final mealsByCatResponse = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/search.php?s=$queryName"));

    if (mealsByCatResponse.statusCode == 200) {
      final mealsByCatData = json.decode(mealsByCatResponse.body);
      if(mealsByCatData['meals'] != null){
        List<dynamic> mealsListData = mealsByCatData['meals'];

        for (var i = 0; i < mealsListData.length; i++) {

          String mealCat = mealsListData[i]["strCategory"];
          MealByCategoryModel meal = MealByCategoryModel.fromJson(mealsListData[i]);
          if(categoryName == mealCat){
            meals.add(meal);
          }
        }
      }
      else {
        return Future.value([]);
      }

    }

    return meals;
  }

  static Future<MealModel?> fetchMealById(int mealId) async {

    final mealByIdResponse = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId"));

    if(mealByIdResponse.statusCode == 200){
      final mealByIdData = json.decode(mealByIdResponse.body);
      if(mealByIdData['meals'] != null){
        List<dynamic> mealsListData = mealByIdData['meals'];

        if(mealsListData.isNotEmpty){
          MealModel meal = MealModel.fromJson(mealsListData[0]);

          return meal;
        }

      }


    }
    return Future.value(null);

  }
}
