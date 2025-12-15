

import 'package:flutter/widgets.dart';
import 'package:mis_lab2/models/meal_by_category_model.dart';
// import 'package:mis_lab2/repository/favorites_local_repository.dart';
import 'package:mis_lab2/widgets/meal_by_category_card.dart';

class MealByCategoryGrid extends StatelessWidget{

  final List<MealByCategoryModel> mealsByCategory;
  // final FavoritesLocalRepository favoritesRepository;

  // const MealByCategoryGrid({super.key, required this.mealsByCategory,required this.favoritesRepository});
  const MealByCategoryGrid({super.key, required this.mealsByCategory});

  @override
  Widget build(BuildContext context) {

    return SizedBox(child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      // itemBuilder: (context, index) => MealByCategoryCard(mealByCategoryModel: mealsByCategory[index],favoritesRepository: favoritesRepository),
      itemBuilder: (context, index) => MealByCategoryCard(mealByCategoryModel: mealsByCategory[index]),
      itemCount: mealsByCategory.length,shrinkWrap: true,));

  }


}