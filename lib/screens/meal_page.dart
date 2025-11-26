
import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_model.dart';
// import 'package:url_launcher/url_launcher.dart';



class MealDetailPage extends StatelessWidget {
  final MealModel? meal;

  const MealDetailPage({super.key, required this.meal});

  // void _launchYoutube(String url) async {
  //   final uri = Uri.parse(url);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     debugPrint("Could not launch $url");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    if (meal == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Meal Details"),
        ),
        body: const Center(
          child: Text(
            "Meal non existent",
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(meal!.name)),
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

            // Category & Area
            Text("Category: ${meal!.category}", style: const TextStyle(fontWeight: FontWeight.bold)),
            Text("Area: ${meal!.area}", style: const TextStyle(fontWeight: FontWeight.bold)),

            const SizedBox(height: 8),

            // YouTube link
            if (meal!.youtubeLink.isNotEmpty)
              Text(meal!.youtubeLink),
              // GestureDetector(
              //   onTap: () => _launchYoutube(meal!.youtubeLink),
              //   child: Text(
              //     "Watch Recipe on YouTube",
              //     style: TextStyle(
              //       color: Colors.blue.shade700,
              //       decoration: TextDecoration.underline,
              //     ),
              //   ),
              // ),

            const SizedBox(height: 16),

            // Instructions
            const Text("Instructions:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 4),
            Text(meal!.instructions),

            const SizedBox(height: 16),

            // Ingredients & Measures
            if (meal!.ingredients.isNotEmpty) ...[
              const Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              ...meal!.ingredients.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Text(e, style: const TextStyle(fontSize: 14)),
              )),
            ],
            if (meal!.measures.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text("Measures:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              ...meal!.measures.map((e) => Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(e, style: const TextStyle(fontSize: 14)),
              )),
            ],
          ],
        ),
      ),
    );
  }
}