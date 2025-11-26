import 'package:flutter/material.dart';
import 'package:mis_lab2/models/meal_model.dart';
import 'package:mis_lab2/screens/category_page.dart';
import 'package:mis_lab2/screens/home_page_screen.dart';
import 'package:mis_lab2/screens/meal_page.dart';
void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab1 ',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(),
        "/category": (context) => MealByCategoryPage(),
        "/meal": (context) => MealDetailPage(meal: ModalRoute.of(context)!.settings.arguments as MealModel?),
      },

    );
  }
}


