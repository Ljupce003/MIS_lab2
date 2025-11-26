import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_by_category_model.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/service/api_service.dart';

class MealByCategoryCard extends StatelessWidget {
  final MealByCategoryModel mealByCategoryModel;

  const MealByCategoryCard({super.key, required this.mealByCategoryModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => goToMeal(context,mealByCategoryModel),
      child: Card(
        elevation: 5,
        color: Colors.yellowAccent.shade400,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                mealByCategoryModel.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1),
              child: Text(
                mealByCategoryModel.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


void goToMeal(BuildContext context,MealByCategoryModel mealByCategoryModel) async {
  showDialog(context: context,barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(),));

  MealModel? meal = await ApiService.fetchMealById(mealByCategoryModel.mealId);
  Navigator.pop(context);
  Navigator.pushNamed(context, "/meal", arguments: meal);
}
