import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/repository/favorites_local_repository.dart';
import 'package:mis_lab2/widgets/favorite_meal_grid.dart';

import '../service/api_service.dart';

class FavoriteMealsPage extends StatefulWidget {
  const FavoriteMealsPage({super.key});

  @override
  State<StatefulWidget> createState() => _FavoriteMealsPageState();
}

class _FavoriteMealsPageState extends State<FavoriteMealsPage> {
  late List<MealModel> favoriteMeals = [];
  bool _isLoading = true;

  final favoritesRepository = FavoritesLocalRepository();

  @override
  void initState() {
    super.initState();
    //
    _fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red.shade300,
        title: Text("Favorites"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            _isLoading
                ? Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Expanded(
                    child: FavoriteMealGrid(favoriteMeals: favoriteMeals,onRemove: (meal) => _removeFavoriteMeal(meal),),
                  ),

            const SizedBox(height: 5),

            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsetsGeometry.only(right: 5, bottom: 5),
                child: Badge(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 10,
                  ),
                  label: Text(
                    "${favoriteMeals.length}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchMeals() async {
    List<int> favMealIds = await favoritesRepository.getFavorites();
    List<MealModel> favMeals = [];
    for (var mealId in favMealIds) {
      MealModel? meal = await ApiService.fetchMealById(mealId);
      if (meal != null) {
        favMeals.add(meal);
      }
    }

    setState(() {
      favoriteMeals = favMeals;
      _isLoading = false;
    });
  }

  void _removeFavoriteMeal(MealModel meal) async{
    await favoritesRepository.removeFavorite(meal.id);
    setState(() {
      favoriteMeals.remove(meal);
    });
  }
}
