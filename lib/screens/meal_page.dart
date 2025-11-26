import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/service/api_service.dart';

class MealDetailPage extends StatelessWidget {
  final MealModel? meal;

  const MealDetailPage({super.key, required this.meal});

  // void _fetchRandomMeal(BuildContext context) async {
  //   // Fetch random meal
  //   MealModel? randomMeal = await ApiService.fetchRandomMeal();
  //   if (randomMeal != null) {
  //     // Navigate to a new details page with the new meal
  //     Navigator.pop(context);
  //     Navigator.pushNamed(
  //       context,"/meal", arguments: randomMeal);
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text("Failed to fetch random meal")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (meal == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Meal Details")),
        body: const Center(
          child: Text("Meal non existent", style: TextStyle(fontSize: 18)),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        // title: ElevatedButton(
        //   onPressed: () => _fetchRandomMeal(context),
        //   style: ElevatedButton.styleFrom(
        //     backgroundColor: Colors.blue,
        //     foregroundColor: Colors.black,
        //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //   ),
        //   child: const Text("Get Random Meal"),
        // ),
        title: Text("Meal"),
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Text(
              meal!.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    meal!.imageUrl,
                    width: 120,
                    height: 120,
                    fit: BoxFit.cover,
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category: ${meal!.category}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Area: ${meal!.area}",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                    ],
                  ),
                ),
              ],
            ),

            if (meal!.youtubeLink.isNotEmpty) const SizedBox(height: 8),
            SelectableText(
              meal!.youtubeLink,
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
              ),
            ),

            const SizedBox(height: 16),

            // Instructions
            const Text(
              "Instructions:",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(meal!.instructions),

            const SizedBox(height: 16),

            // Ingredients
            if (meal!.ingredients.isNotEmpty) ...[
              const Text(
                "Ingredients:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              ...meal!.ingredients.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ),
              ),
            ],

            // Measures
            if (meal!.measures.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                "Measures:",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              ...meal!.measures.map(
                (e) => Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text(e, style: const TextStyle(fontSize: 14)),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
