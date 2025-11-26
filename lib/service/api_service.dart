

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mis_lab2/models/meal_category_model.dart';



class ApiService{

  static Future<List<MealCategoryModel>> fetchMealCategories() async {

    List<MealCategoryModel> categoryList = [];

    final categoriesResponse = await http.get(Uri.parse("https://www.themealdb.com/api/json/v1/1/categories.php"));

    if(categoriesResponse.statusCode == 200){
      final categoriesData = json.decode(categoriesResponse.body);
      List<dynamic> categoriesListData = categoriesData['categories'];
      
      for(var i=0;i<categoriesListData.length;i++){
        categoryList.add(MealCategoryModel.fromJson(categoriesListData[i]));
      }

    }

    return categoryList;
  }



}