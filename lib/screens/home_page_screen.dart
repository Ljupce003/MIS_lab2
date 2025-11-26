import 'package:flutter/material.dart';
import 'package:mis_lab2/models/category_model.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/service/api_service.dart';
import '../widgets/category_grid.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<CategoryModel> categories = [];
  List<CategoryModel> searched = [];
  bool _loading = true;
  String _searchString = "";
  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  void _fetchRandomMeal(BuildContext context) async {
    MealModel? randomMeal = await ApiService.fetchRandomMeal();
    if (randomMeal != null) {
      // Navigator.pop(context);
      Navigator.pushNamed(
          context,"/meal", arguments: randomMeal);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch random meal")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: const Text("Baking App - 221563",style: TextStyle(fontSize: 16),),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: ElevatedButton(
              onPressed: () => _fetchRandomMeal(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: const Text("Get Random Meal"),
            ),)
        ],
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          TextField(
            controller: searchController,
            decoration: const InputDecoration(
              hintText: "Search Category by name",
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (val) => _searchCategories(val),
          ),

          const SizedBox(height: 10),

          _loading
              ? Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(),
            ),
          )
              : (_searchString.isNotEmpty && searched.isEmpty)
              ? Center(child: Text("No Category with that name"))
              : CategoriesList(categories: searched),

          const SizedBox(height: 15),

          Align(
            alignment: Alignment.centerRight,
            child: Badge(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              label: Text(
                "${searched.length}",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _fetchCategories() async {
    // List<MealCategoryModel> fetchedCategories = await Future.delayed(
    //   const Duration(seconds: 2),
    //   ApiService.fetchMealCategories,
    // );

    List<CategoryModel> fetchedCategories =
    await ApiService.fetchMealCategories();

    setState(() {
      categories = fetchedCategories;
      searched = fetchedCategories;
      _loading = false;
    });
  }

  void _searchCategories(String value) {
    final lower = value.toLowerCase();

    setState(() {
      searched = categories
          .where((cat) => cat.name.toLowerCase().contains(lower))
          .toList();
      _searchString = value;
    });
  }
}
