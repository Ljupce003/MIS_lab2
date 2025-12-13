import 'package:flutter/widgets.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/widgets/favorite_meal_card.dart';

class FavoriteMealGrid extends StatelessWidget {
  final List<MealModel> favoriteMeals;
  final void Function(MealModel) onRemove;

  const FavoriteMealGrid({
    super.key,
    required this.favoriteMeals,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      // physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        MealModel meal = favoriteMeals[index];
        return FavoriteMealCard(meal: meal, onRemove: () => onRemove(meal));
      },
      separatorBuilder: (context, index) => SizedBox(height: 5),
      itemCount: favoriteMeals.length,
    );
  }
}
