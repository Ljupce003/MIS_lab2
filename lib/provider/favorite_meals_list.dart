
import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_model.dart';

class FavoriteMealsList extends ChangeNotifier{

  List<MealModel> favoriteMeals = [];

  List<MealModel> getFavoriteMeals(){
    return favoriteMeals;
  }

  void addFavoriteMeal(MealModel favoriteMeal){
    favoriteMeals.add(favoriteMeal);
    notifyListeners();
  }

  void removeFavoriteMeal(int mealId){
    MealModel? mealToBeRemoved = favoriteMeals.where((meal) => meal.id==mealId).firstOrNull;

    if(mealToBeRemoved == null){
      throw Exception("Favorite Meal with mealId $mealId was not found");
    }

    favoriteMeals.remove(mealToBeRemoved);
    notifyListeners();
  }

  bool isFavorite(int mealId){
    MealModel? mealToBeRemoved = favoriteMeals.where((meal) => meal.id==mealId).firstOrNull;

    if(mealToBeRemoved == null){
      return false;
    }
    return true;
  }

}