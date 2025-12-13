import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_by_category_model.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/repository/favorites_local_repository.dart';
import 'package:mis_lab2/service/api_service.dart';

class MealByCategoryCard extends StatefulWidget {
  final MealByCategoryModel mealByCategoryModel;
  final FavoritesLocalRepository favoritesRepository;

  const MealByCategoryCard({
    super.key,
    required this.mealByCategoryModel,
    required this.favoritesRepository,
  });

  @override
  State<MealByCategoryCard> createState() => _MealByCategoryCardState();
}

class _MealByCategoryCardState extends State<MealByCategoryCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkIfFavorite();
  }

  void _checkIfFavorite() async {
    final fav = await widget.favoritesRepository.isFavorite(
      widget.mealByCategoryModel.mealId,
    );
    setState(() {
      isFavorite = fav;
    });
  }

  void _toggleFavorite() async {
    if (isFavorite) {
      await widget.favoritesRepository.removeFavorite(
        widget.mealByCategoryModel.mealId,
      );
    } else {
      await widget.favoritesRepository.addFavorite(
        widget.mealByCategoryModel.mealId,
      );
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToMeal(context, widget.mealByCategoryModel),
      child: Card(
        elevation: 5,
        color: Colors.yellowAccent.shade400,
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.network(
                    widget.mealByCategoryModel.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: GestureDetector(
                      onTap: _toggleFavorite,
                      child: Container(
                        padding: const EdgeInsets.all(2), // 1px padding around the icon
                        decoration: BoxDecoration(
                          color: Colors.yellowAccent.shade400,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          isFavorite ? Icons.star : Icons.star_border,
                          color: Colors.redAccent,
                          size: 28,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                widget.mealByCategoryModel.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _goToMeal(
    BuildContext context,
    MealByCategoryModel mealByCategoryModel,
  ) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    MealModel? meal = await ApiService.fetchMealById(
      mealByCategoryModel.mealId,
    );
    Navigator.pop(context);
    Navigator.pushNamed(context, "/meal", arguments: meal);
  }
}
