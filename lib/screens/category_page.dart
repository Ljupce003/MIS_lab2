import 'package:flutter/material.dart';
import 'package:mis_lab2/models/category_model.dart';
import 'package:mis_lab2/models/meal_by_category_model.dart';
import 'package:mis_lab2/service/api_service.dart';
import 'package:mis_lab2/widgets/meal_by_category_grid.dart';

class MealByCategoryPage extends StatefulWidget {
  const MealByCategoryPage({super.key});

  @override
  State<StatefulWidget> createState() => MealByCategoryPageState();
}

class MealByCategoryPageState extends State<MealByCategoryPage> {
  late CategoryModel categoryModel;
  bool _isLoading = true;
  String _filterString = "";
  final TextEditingController filterController = TextEditingController(
    text: "",
  );
  bool _isInit = false;

  List<MealByCategoryModel> mealsByCategory = [];
  List<MealByCategoryModel> filtered = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInit) {
      categoryModel =
          ModalRoute.of(context)!.settings.arguments as CategoryModel;
      _fetchMealsByCategory();
      _isInit = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: ExamAppBar(isExpired: isExpired, exam: exam),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(categoryModel.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              controller: filterController,
              decoration: const InputDecoration(
                hintText: "Search Meal by name",
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (val) => _filterMealByCategory(val),
            ),

            const SizedBox(height: 10),

            _isLoading
                ? Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : (_filterString.isNotEmpty && filtered.isEmpty)
                ? Center(
                    child: Text(
                      "No Meal of category ${categoryModel.name} with that name",
                    ),
                  )
                : Expanded(
                    child: MealByCategoryGrid(mealsByCategory: filtered),
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
                    "${filtered.length}",
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

  void _fetchMealsByCategory() async {
    List<MealByCategoryModel> meals = await ApiService.fetchMealsByCategory(
      categoryModel.name,
    );

    setState(() {
      mealsByCategory = meals;
      filtered = meals;
      _isLoading = false;
    });
  }

  void _filterMealByCategory(String val) async {
    if (val.isEmpty) {
      setState(() {
        filtered = mealsByCategory;
        _filterString = val;
      });
    } else {

      List<MealByCategoryModel> meals = await ApiService.filterMealsByName(
        categoryModel.name,
        val,
      );

      setState(() {
        filtered = meals;
        // _isLoading = false;
        _filterString = val;
      });
    }
  }
}
